local mason = require('mason')
mason.setup()
--vim.cmd(":MasonUpdate")
local mason_lsp = require("mason-lspconfig")
mason_lsp.setup({
    ensure_installed = {
        "bashls",
        "dhall_lsp_server",
        "dockerls",
        -- "html",
        --[[ "hls", ]]
        "jsonls",
        "lua_ls",
        "nil_ls",
        -- "pylsp",
        -- "rust_analyzer",
        "taplo",
        "terraformls",
        "tflint",
        --[[ "tsserver", ]]
        "v_analyzer",
        "yamlls",
        "zls",
    }
  })
local nvim_lsp = require("lspconfig")

local handlers_ok, my_handlers = pcall(require, "lsp")
if not handlers_ok then
    return
end

local default_setup = {
    on_attach = my_handlers.on_attach,
    capabilities = my_handlers.capabilities,
}

mason_lsp.setup_handlers({
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        nvim_lsp[server_name].setup(default_setup)
    end,
    ["lua_ls"] = function()
        nvim_lsp.lua_ls.setup({
            settings = {
    Lua = {
        runtime = {
            version = "LuaJIT",
        },
        diagnostics = {
            globals = { "vim" },
        },
        workspace = {
            checkThirdParty = false,
            library = {
                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                [vim.fn.stdpath("config") .. "lua"] = true,
                ["/usr/share/nvim/runtime/lua"] = true,
                ["/usr/share/nvim/runtime/lua/vim"] = true,
                ["/usr/share/nvim/runtime/lua/vim/lsp"] = true,
            },
        },
        telemetry = {
            enable = false,
        },
    },
      },
            on_attach = my_handlers.on_attach,
            capabilities = my_handlers.capabilities,
        })
    end,
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
    -- ["elixirls"] = function()
    --     nvim_lsp.elixirls.setup({
    --         cmd = { vim.fn.expand("~/.local/bin/elixir-ls/language_server.sh") },
    --         capabilities = my_handlers.capabilities,
    --         on_attach = my_handlers.on_attach,
    --         settings = {
    --             elixirLS = {
    --                 -- I choose to disable dialyzer for personal reasons, but
    --                 -- I would suggest you also disable it unless you are well
    --                 -- acquainted with dialzyer and know how to use it.
    --                 dialyzerEnabled = false,
    --                 -- I also choose to turn off the auto dep fetching feature.
    --                 -- It often get's into a weird state that requires deleting
    --                 -- the .elixir_ls directory and restarting your editor.
    --                 fetchDeps = false,
    --             },
    --         },
    --     })
    -- end,
    ["dockerls"] = function()
        local settings_ok, docker_settings = pcall(require, "plugins.lsp.settings.docker")
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
    ["jsonls"] = function()
        nvim_lsp.jsonls.setup({
            settings = {
                json = {
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                },
            },
        })
    end,
    ["yamlls"] = function()
        local settings_ok, yaml_settings = pcall(require, "plugins.lsp.settings.yaml")
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
