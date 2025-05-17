return {
    { "williamboman/mason.nvim", build = ":MasonUpdate", config = true },
    {
        "neovim/nvim-lspconfig",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            local config = {
                -- virtual_lines = {
                --     format = function(diag)
                --         return "● " .. diag.source .. ": " .. diag.message
                --     end,
                -- },
                -- virtual_text = {
                --     source = "always",
                --     spacing = 4,
                --     prefix = "●",
                -- },
                -- show signs
                signs = {
                    { name = "DiagnosticSignError", text = " " },
                    { name = "DiagnosticSignWarn", text = " " },
                    { name = "DiagnosticSignHint", text = " " },
                    { name = "DiagnosticSignInfo", text = " " },
                },
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
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig", "SmiteshP/nvim-navic" },
        config = function(_, opts)
            local handlers_ok, my_handlers = pcall(require, "plugins.lsp.handlers")
            if not handlers_ok then
                return
            end

            local default_setup = {
                on_attach = my_handlers.on_attach,
                capabilities = my_handlers.capabilities,
            }

            local mason_lsp = require("mason-lspconfig")
            mason_lsp.setup(opts)
            local nvim_lsp = require("lspconfig")

            local lua_settings = {}
            local settings_ok, maybe_lua_settings = pcall(require, "plugins.lsp.settings.lua")
            if settings_ok then
                lua_settings = vim.tbl_deep_extend("force", lua_settings, maybe_lua_settings)
            end
            vim.lsp.config("lua_ls", {
                settings = lua_settings,
                on_attach = my_handlers.on_attach,
                capabilities = my_handlers.capabilities,
            })

            vim.lsp.config("ts_ls", {
                on_attach = my_handlers.on_attach,
                capabilities = my_handlers.capabilities,
            })

            vim.lsp.config("sqls", {
                on_attach = function(client, bufnr)
                    client.server_capabilities.document_formatting = false
                    client.server_capabilities.document_range_formatting = false
                    require("sqls").on_attach(client, bufnr)
                    my_handlers.on_attach(client, bufnr)
                end,
                capabilities = my_handlers.capabilities,
            })

            vim.lsp.config("tailwindcss", {
                capabilities = my_handlers.capabilities,
                on_attach = my_handlers.on_attach,
                filetypes = { "html", "elixir", "eelixir", "heex" },
                init_options = {
                    userLanguages = {
                        elixir = "html-eex",
                        eelixir = "html-eex",
                        heex = "html-eex",
                    },
                },
                settings = {
                    tailwindCSS = {
                        experimental = {
                            classRegex = {
                                'class[:]\\s*"([^"]*)"',
                            },
                        },
                    },
                },
            })

            local docker_settings = {}
            local docker_settings_ok, m_docker_settings = pcall(require, "plugins.lsp.settings.docker")
            if docker_settings_ok then
                docker_settings = vim.tbl_deep_extend("force", docker_settings, m_docker_settings)
            end
            vim.lsp.config("dockerls", {
                on_attach = my_handlers.on_attach,
                capabilities = my_handlers.capabilities,
                settings = docker_settings,
            })

            vim.lsp.config("tflint", {
                on_attach = my_handlers.on_attach,
                capabilities = my_handlers.capabilities,
                root_dir = nvim_lsp.util.root_pattern(".git", ".tflint.hcl"),
            })

            vim.lsp.config("jsonls", {
                settings = {
                    json = {
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                        provideFormatter = false,
                    },
                },
            })

            local yaml_settings = {}
            local yaml_settings_ok, m_yaml_settings = pcall(require, "plugins.lsp.settings.yaml")
            if yaml_settings_ok then
                yaml_settings = vim.tbl_deep_extend("force", yaml_settings, m_yaml_settings)
            end
            vim.lsp.config("yamlls", {
                settings = yaml_settings,
                on_attach = my_handlers.on_attach,
                capabilities = my_handlers.capabilities,
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
                -- "postgres_lsp",
                -- "pylsp",
                -- "rust_analyzer",
                "taplo",
                "terraformls",
                -- "tflint",
                "ts_ls",
                "v_analyzer",
                "yamlls",
                "zls",
            },
        },
    },
    {
        "MrcJkb/haskell-tools.nvim",
        version = "^6",
        lazy = false,
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
                        vim.keymap.set("n", "<space>sh", ht.hoogle.hoogle_signature, opts)
                        -- vim.keymap.set("n", "<space>ea", ht.lsp.buf_eval_all, opts)
                        -- Suggested keymaps that do not depend on haskell-language-server
                        -- Toggle a GHCi repl for the current package
                        vim.keymap.set("n", "<leader>rr", ht.repl.toggle, opts)
                        -- Toggle a GHCi repl for the current buffer
                        vim.keymap.set("n", "<leader>rf", function()
                            ht.repl.toggle(vim.api.nvim_buf_get_name(0))
                        end, opts)
                        vim.keymap.set("n", "<leader>rq", ht.repl.quit, opts)
                        vim.keymap.set("n", "<leader>hs", "<cmd>Haskell packageYaml<cr>", opts)
                        vim.keymap.set("n", "<leader>hp", "<cmd>Haskell projectFile<cr>", opts)
                        ht.dap.discover_configurations(bufnr)
                        my_handlers.on_attach(client, bufnr) -- if defined, see nvim-lspconfig
                    end,
                    capabilities = my_handlers.capabilities,
                    -- settings = {
                    --     haskell = {
                    -- checkProject = false,
                    -- checkParents = "CheckOnSave",
                    -- formattingProvider = "fourmolu",
                    -- plugin = {
                    --     stan = { globalOn = false },
                    --     semanticTokens = { globalOn = true },
                    -- },
                    --     },
                    -- },
                },
                tools = {
                    codeLens = { autoRefresh = false },
                    hoogle = { mode = "auto" },
                    -- hover = {},
                    definition = { hoogle_signature_fallback = true },
                    repl = { handler = "toggleterm" },
                    -- tags = {},
                    log = {
                        level = vim.log.levels.DEBUG,
                    },
                },
            }
        end,
    },
    -- {
    --     "pmizio/typescript-tools.nvim",
    --     dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    --     opts = function()
    --         local handlers_ok, my_handlers = pcall(require, "plugins.lsp.handlers")
    --         if not handlers_ok then
    --             return
    --         end
    --         return {
    --             on_attach = function(client, bufnr)
    --                 -- This removes random characters
    --                 -- ts_organize_imports(bufnr)
    --                 my_handlers.on_attach(client, bufnr)
    --             end,
    --             capabilities = my_handlers.capabilities,
    --             --[[ handlers = { ... }, ]]
    --             settings = {
    --                 -- spawn additional tsserver instance to calculate diagnostics on it
    --                 separate_diagnostic_server = true,
    --                 -- "change"|"insert_leave" determine when the client asks the server about diagnostic
    --                 publish_diagnostic_on = "insert_leave",
    --                 expose_as_code_action = "all",
    --                 -- string|nil -specify a custom path to `tsserver.js` file, if this is nil or file under path
    --                 -- not exists then standard path resolution strategy is applied
    --                 tsserver_path = nil,
    --                 -- specify a list of plugins to load by tsserver, e.g., for support `styled-components`
    --                 -- (see 💅 `styled-components` support section)
    --                 tsserver_plugins = {},
    --                 -- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-sizesize-in-megabytes
    --                 -- memory limit in megabytes or "auto"(basically no limit)
    --                 tsserver_max_memory = "auto",
    --                 -- described below
    --                 tsserver_format_options = {},
    --                 tsserver_file_preferences = {},
    --             },
    --         }
    --     end,
    -- },
    {
        "elixir-tools/elixir-tools.nvim",
        version = "*",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local elixir = require("elixir")
            local elixirls = require("elixir.elixirls")

            elixir.setup({
                nextls = { enable = true },
                credo = { enable = true },
                elixirls = {
                    -- cmd = { vim.fn.expand("~/.local/bin/elixir-ls/language_server.sh") },
                    enable = true,
                    repo = "elixir-lsp/elixir-ls",
                    settings = elixirls.settings({
                        dialyzerEnabled = true,
                        enableTestLenses = false,
                    }),
                    on_attach = function(client, bufnr)
                        vim.keymap.set("n", "<space>fp", ":ElixirFromPipe<cr>", { buffer = true, noremap = true })
                        vim.keymap.set("n", "<space>tp", ":ElixirToPipe<cr>", { buffer = true, noremap = true })
                        vim.keymap.set("v", "<space>em", ":ElixirExpandMacro<cr>", { buffer = true, noremap = true })
                        local handlers_ok, my_handlers = pcall(require, "plugins.lsp.handlers")
                        if handlers_ok then
                            my_handlers.on_attach(client, bufnr)
                        end
                    end,
                },
            })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "luckasRanarison/tailwind-tools.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            custom_filetypes = { "heex", "elixir", "eelixir" },
        },
    },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup({})
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
    {
        "mrcjkb/rustaceanvim",
        version = "^6", -- Recommended
        ft = { "rust" },
    },
}
