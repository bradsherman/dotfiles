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

mason.setup({
    ui = {
        -- Whether to automatically check for new versions when opening the :Mason window.
        check_outdated_packages_on_open = true,

        -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
        border = "none",

        icons = {
            -- The list icon to use for installed packages.
            package_installed = "◍",
            -- The list icon to use for packages that are installing, or queued for installation.
            package_pending = "◍",
            -- The list icon to use for packages that are not installed.
            package_uninstalled = "◍",
        },

        keymaps = {
            -- Keymap to expand a package
            toggle_package_expand = "<CR>",
            -- Keymap to install the package under the current cursor position
            install_package = "i",
            -- Keymap to reinstall/update the package under the current cursor position
            update_package = "u",
            -- Keymap to check for new version for the package under the current cursor position
            check_package_version = "c",
            -- Keymap to update all installed packages
            update_all_packages = "U",
            -- Keymap to check which installed packages are outdated
            check_outdated_packages = "C",
            -- Keymap to uninstall a package
            uninstall_package = "X",
            -- Keymap to cancel a package installation
            cancel_installation = "<C-c>",
            -- Keymap to apply language filter
            apply_language_filter = "<C-f>",
        },
    },

    -- The directory in which to install packages.
    --[[ install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }), ]]

    pip = {
        -- These args will be added to `pip install` calls. Note that setting extra args might impact intended behavior
        -- and is not recommended.
        --
        -- Example: { "--proxy", "https://proxyserver" }
        install_args = {},
    },

    -- Controls to which degree logs are written to the log file. It's useful to set this to vim.log.levels.DEBUG when
    -- debugging issues with package installations.
    log_level = vim.log.levels.INFO,

    -- Limit for the maximum amount of packages to be installed at the same time. Once this limit is reached, any further
    -- packages that are requested to be installed will be put in a queue.
    max_concurrent_installers = 4,

    github = {
        -- The template URL to use when downloading assets from GitHub.
        -- The placeholders are the following (in order):
        -- 1. The repository (e.g. "rust-lang/rust-analyzer")
        -- 2. The release version (e.g. "v0.3.0")
        -- 3. The asset name (e.g. "rust-analyzer-v0.3.0-x86_64-unknown-linux-gnu.tar.gz")
        download_url_template = "https://github.com/%s/releases/download/%s/%s",
    },
})

local default_setup = {
    on_attach = my_handlers.on_attach,
    capabilities = my_handlers.capabilities,
}
local def_opts = { noremap = true, silent = true }

local ht_ok, haskell_tools = pcall(require, "haskell-tools")
if ht_ok then
    local settings_ok, hls_settings = pcall(require, "plugin_conf.lsp.settings.hls")
    if not settings_ok then
        return
    end
    haskell_tools.setup({
        hls = {
            on_attach = function(client, bufnr)
                local opts = vim.tbl_extend("keep", def_opts, { buffer = bufnr })
                -- haskell-language-server relies heavily on codeLenses,
                -- so auto-refresh (see advanced configuration) is enabled by default
                vim.keymap.set("n", "<space>ca", vim.lsp.codelens.run, opts)
                vim.keymap.set("n", "<space>hs", haskell_tools.hoogle.hoogle_signature, opts)
                my_handlers.on_attach(client, bufnr) -- if defined, see nvim-lspconfig
            end,
            settings = function()
                return hls_settings
            end,
            capabilities = my_handlers.capabilities,
        },
    })
    -- Suggested keymaps that do not depend on haskell-language-server
    -- Toggle a GHCi repl for the current package
    vim.keymap.set("n", "<leader>rr", haskell_tools.repl.toggle, def_opts)
    -- Toggle a GHCi repl for the current buffer
    vim.keymap.set("n", "<leader>rf", function()
        haskell_tools.repl.toggle(vim.api.nvim_buf_get_name(0))
    end, def_opts)
    vim.keymap.set("n", "<leader>rq", haskell_tools.repl.quit, def_opts)
end

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
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.stdpath("config") .. "lua"] = true,
                            ["/usr/share/nvim/runtime/lua"] = true,
                            ["/usr/share/nvim/runtime/lua/vim"] = true,
                            ["/usr/share/nvim/runtime/lua/vim/lsp"] = true,
                        },
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
    --[[ ["sqlls"] = function() ]]
    --[[     nvim_lsp.sqlls.setup({ ]]
    --[[         on_attach = function(client, bufnr) ]]
    --[[             client.server_capabilities.document_formatting = false ]]
    --[[             client.server_capabilities.document_range_formatting = false ]]
    --[[             my_handlers.on_attach(client, bufnr) ]]
    --[[         end, ]]
    --[[         capabilities = my_handlers.capabilities, ]]
    --[[     }) ]]
    --[[ end, ]]
    ["dockerls"] = function()
        nvim_lsp.dockerls.setup({
            on_attach = my_handlers.on_attach,
            capabilities = my_handlers.capabilities,
            settings = {
                docker = {
                    languageserver = {
                        formatter = {
                            ignoreMultilineInstructions = true,
                        },
                    },
                },
            },
        })
    end,
    ["tflint"] = function()
        nvim_lsp.tflint.setup({
            on_attach = my_handlers.on_attach,
            capabilities = my_handlers.capabilities,
            root_dir = nvim_lsp.util.root_pattern(".git", ".tflint.hcl"),
        })
    end,
})

local ts_ok, ts = pcall(require, "typescript")
if ts_ok then
    ts.setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        disable_formatting = false, -- disable tsserver's formatting capabilities
        debug = false, -- enable debug logging for commands
        server = { -- pass options to lspconfig's setup method
            on_attach = my_handlers.on_attach,
            capabilities = my_handlers.capabilities,
        },
    })
end
