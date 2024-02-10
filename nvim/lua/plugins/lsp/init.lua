return {
    { "williamboman/mason.nvim", build = ":MasonUpdate", config = true },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            local signs = {
                { name = "DiagnosticSignError", text = " " },
                { name = "DiagnosticSignWarn", text = " " },
                { name = "DiagnosticSignHint", text = " " },
                { name = "DiagnosticSignInfo", text = " " },
            }

            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
            end

            local config = {
                virtual_text = {
                    source = "always",
                    spacing = 4,
                    prefix = "●",
                    -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                    -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                    -- prefix = "icons",
                },
                -- show signs
                sign = true,
                -- signs = {
                --     active = false,
                -- },
                update_in_insert = false,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = true,
                    style = "minimal",
                    border = "rounded",
                    source = "if_many",
                    enabled = false,
                    header = "",
                    prefix = "",
                },
            }

            vim.diagnostic.config(config)

            vim.api.nvim_command([[ hi def link LspReferenceText CursorLine ]])
            vim.api.nvim_command([[ hi def link LspReferenceWrite CursorLine ]])
            vim.api.nvim_command([[ hi def link LspReferenceRead CursorLine ]])
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = function(_, opts)
            local mason_lsp = require("mason-lspconfig")
            mason_lsp.setup(opts)
            local nvim_lsp = require("lspconfig")

            local handlers_ok, my_handlers = pcall(require, "plugins.lsp.handlers")
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
        end,
        opts = {
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
            },
        },
    },
    {
        "MrcJkb/haskell-tools.nvim",
        version = "^3",
        ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
        config = function()
            local handlers_ok, my_handlers = pcall(require, "plugins.lsp.handlers")
            if not handlers_ok then
                return
            end
            vim.g.haskell_tools = {
                hls = {
                    on_attach = function(client, bufnr, ht)
                        local opts = { noremap = true, silent = true, buffer = bufnr }
                        vim.keymap.set("n", "<space>ca", vim.lsp.codelens.run, opts)
                        vim.keymap.set("n", "<space>hs", ht.hoogle.hoogle_signature, opts)
                        -- vim.keymap.set("n", "<space>ea", ht.lsp.buf_eval_all, opts)
                        -- Suggested keymaps that do not depend on haskell-language-server
                        -- Toggle a GHCi repl for the current package
                        vim.keymap.set("n", "<leader>rr", ht.repl.toggle, opts)
                        -- Toggle a GHCi repl for the current buffer
                        vim.keymap.set("n", "<leader>rf", function()
                            ht.repl.toggle(vim.api.nvim_buf_get_name(0))
                        end, opts)
                        vim.keymap.set("n", "<leader>rq", ht.repl.quit, opts)
                        vim.keymap.set("n", "<leader>hs", "<cmd>HsPackageYaml<cr>", opts)
                        vim.keymap.set("n", "<leader>hp", "<cmd>HsProjectFile<cr>", opts)
                        ht.dap.discover_configurations(bufnr)
                        my_handlers.on_attach(client, bufnr) -- if defined, see nvim-lspconfig
                    end,
                    capabilities = my_handlers.capabilities,
                    settings = {
                        haskell = {
                            plugin = {
                                stan = { globalOn = false },
                                semanticTokens = { globalOn = true },
                            },
                        },
                    },
                },
                tools = {
                    codeLens = { autoRefresh = true },
                    hoogle = { mode = "auto" },
                    -- hover = {},
                    definition = { hoogle_signature_fallback = true },
                    repl = { handler = "toggleterm" },
                    -- tags = {},
                    -- log = {},
                },
            }
        end,
    },
    "folke/neodev.nvim",
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = function()
            local handlers_ok, my_handlers = pcall(require, "plugins.lsp.handlers")
            if not handlers_ok then
                return
            end
            return {
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
            }
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
        end,
    },
    "hashivim/vim-terraform",
    "nanotee/sqls.nvim",
    "vmchale/dhall-vim",
    "LnL7/vim-nix",
    "b0o/schemastore.nvim",
    {
        "someone-stole-my-name/yaml-companion.nvim",
        dependencies = {
            { "neovim/nvim-lspconfig" },
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim" },
        },
    },
    -- { "Zeioth/garbage-day.nvim", event = "VeryLazy" },
    {
        "mrcjkb/rustaceanvim",
        version = "^3", -- Recommended
        ft = { "rust" },
    },
}
