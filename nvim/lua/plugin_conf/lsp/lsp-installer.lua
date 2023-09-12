local status_ok, mason = pcall(require, "mason")
if not status_ok then
    return
end

local mason_lsp_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not mason_lsp_status_ok then
    return
end

local lspconf_status, nvim_lsp = pcall(require, "lspconfig")
if not lspconf_status then
    return
end

local handlers_ok, my_handlers = pcall(require, "plugin_conf.lsp.handlers")
if not handlers_ok then
    return
end

mason.setup()

local default_setup = {
    on_attach = my_handlers.on_attach,
    capabilities = my_handlers.capabilities,
}
local current_buf = vim.api.nvim_get_current_buf()
local def_opts = { noremap = true, silent = true, buffer = current_buf }

local ht_ok, haskell_tools = pcall(require, "haskell-tools")
if ht_ok then
    local settings_ok, hls_settings = pcall(require, "plugin_conf.lsp.settings.hls")
    if not settings_ok then
        return
    end
    vim.g.haskell_tools = {
        -- haskell_tools.setup({
        tools = {
            -- haskell-language-server relies heavily on codeLenses,
            -- so auto-refresh (see advanced configuration) is enabled by default
            codeLens = { autoRefresh = true },
        },
        hls = {
            on_attach = function(client, bufnr)
                local opts = vim.tbl_extend("keep", def_opts, { buffer = bufnr })
                vim.keymap.set("n", "<space>ca", vim.lsp.codelens.run, opts)
                vim.keymap.set("n", "<space>hs", haskell_tools.hoogle.hoogle_signature, opts)
                vim.keymap.set("n", "<space>ea", haskell_tools.lsp.buf_eval_all, opts)
                -- Suggested keymaps that do not depend on haskell-language-server
                -- Toggle a GHCi repl for the current package
                vim.keymap.set("n", "<leader>rr", haskell_tools.repl.toggle, def_opts)
                -- Toggle a GHCi repl for the current buffer
                vim.keymap.set("n", "<leader>rf", function()
                    haskell_tools.repl.toggle(vim.api.nvim_buf_get_name(0))
                end, def_opts)
                vim.keymap.set("n", "<leader>rq", haskell_tools.repl.quit, def_opts)
                haskell_tools.dap.discover_configurations(bufnr)
                my_handlers.on_attach(client, bufnr) -- if defined, see nvim-lspconfig
            end,
            default_settings = {
                haskell = { -- haskell-language-server options
                    formattingProvider = "fourmolu",
                    -- Setting this to true could have a performance impact on large mono repos.
                    checkProject = false,
                    -- ...
                },
            },
            -- default_settings = hls_settings,
            settings = function()
                return hls_settings
            end,
            capabilities = my_handlers.capabilities,
        },
    }
end

local augroup = vim.api.nvim_create_augroup("TsOrganizeImports", {})

local ts_organize_imports = function(bufnr)
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        command = "TSToolsOrganizeImports",
    })
end

local ts_ok, typescript_tools = pcall(require, "typescript-tools")
if ts_ok then
    typescript_tools.setup({
        on_attach = function(client, bufnr)
            -- This removes random characters
            -- ts_organize_imports(bufnr)
            my_handlers.on_attach(client, bufnr)
        end,
        capabilities = my_handlers.capabilities,
        --[[ handlers = { ... }, ]]
        settings = {
            -- spawn additional tsserver instance to calculate diagnostics on it
            separate_diagnostic_server = true,
            -- "change"|"insert_leave" determine when the client asks the server about diagnostic
            publish_diagnostic_on = "insert_leave",
            -- string|nil -specify a custom path to `tsserver.js` file, if this is nil or file under path
            -- not exists then standard path resolution strategy is applied
            tsserver_path = nil,
            -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
            -- (see 💅 `styled-components` support section)
            tsserver_plugins = {},
            -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
            -- memory limit in megabytes or "auto"(basically no limit)
            tsserver_max_memory = "auto",
            -- described below
            tsserver_format_options = {},
            tsserver_file_preferences = {},
        },
    })
end

mason_lsp.setup({
    ensure_installed = {
        "bashls",
        "dhall_lsp_server",
        "dockerls",
        "html",
        --[[ "hls", ]]
        "jsonls",
        "lua_ls",
        "nil_ls",
        "pylsp",
        "rust_analyzer",
        "taplo",
        "terraformls",
        "tflint",
        --[[ "tsserver", ]]
        "yamlls",
        "zls",
    },
})
mason_lsp.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        nvim_lsp[server_name].setup(default_setup)
    end,
    ["lua_ls"] = function()
        local settings_ok, lua_settings = pcall(require, "plugin_conf.lsp.settings.lua")
        if not settings_ok then
            return
        end
        nvim_lsp.lua_ls.setup({
            settings = lua_settings,
            on_attach = my_handlers.on_attach,
            capabilities = my_handlers.capabilities,
        })
    end,
    --[[ ["hls"] = function() ]]
    --[[     local settings_ok, hls_settings = pcall(require, "plugin_conf.lsp.settings.hls") ]]
    --[[     if not settings_ok then ]]
    --[[         return ]]
    --[[     end ]]
    --[[     nvim_lsp.hls.setup({ ]]
    --[[         settings = hls_settings, ]]
    --[[         on_attach = my_handlers.on_attach, ]]
    --[[         capabilities = my_handlers.capabilities, ]]
    --[[     }) ]]
    --[[ end, ]]
    ["sqls"] = function()
        nvim_lsp.sqls.setup({
            on_attach = function(client, bufnr)
                client.server_capabilities.document_formatting = false
                client.server_capabilities.document_range_formatting = false
                require("sqls").on_attach(client, bufnr)
                my_handlers.on_attach(client, bufnr)
            end,
            capabilities = my_handlers.capabilities,
        })
    end,
    ["dockerls"] = function()
        local settings_ok, docker_settings = pcall(require, "plugin_conf.lsp.settings.docker")
        if not settings_ok then
            return
        end
        nvim_lsp.dockerls.setup({
            on_attach = my_handlers.on_attach,
            capabilities = my_handlers.capabilities,
            settings = docker_settings,
        })
    end,
    ["tflint"] = function()
        nvim_lsp.tflint.setup({
            on_attach = my_handlers.on_attach,
            capabilities = my_handlers.capabilities,
            root_dir = nvim_lsp.util.root_pattern(".git", ".tflint.hcl"),
        })
    end,
    ["yamlls"] = function()
        local settings_ok, yaml_settings = pcall(require, "plugin_conf.lsp.settings.yaml")
        if not settings_ok then
            return
        end
        nvim_lsp.yamlls.setup({
            settings = yaml_settings,
            on_attach = my_handlers.on_attach,
            capabilities = my_handlers.capabilities,
        })
    end,
})

--[[ local ts_ok, ts = pcall(require, "typescript") ]]
--[[ if ts_ok then ]]
--[[     ts.setup({ ]]
--[[         disable_commands = false, -- prevent the plugin from creating Vim commands ]]
--[[         disable_formatting = false, -- disable tsserver's formatting capabilities ]]
--[[         debug = false, -- enable debug logging for commands ]]
--[[         server = { -- pass options to lspconfig's setup method ]]
--[[             on_attach = my_handlers.on_attach, ]]
--[[             capabilities = my_handlers.capabilities, ]]
--[[         }, ]]
--[[     }) ]]
--[[ end ]]
