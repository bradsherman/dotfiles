return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function(_, opts)
            require("nvim-treesitter").setup(opts)
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                -- one of "all", "maintained" (parsers with maintainers), or a list of languages
                ensure_installed = {
                    "bash",
                    "clojure",
                    "cpp",
                    "css",
                    "diff",
                    "git_rebase",
                    "gitcommit",
                    "go",
                    "graphql",
                    "haskell",
                    "hcl",
                    "html",
                    "javascript",
                    "json",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "ninja",
                    "nix",
                    "norg",
                    "ocaml",
                    "org",
                    "python",
                    "query",
                    "regex",
                    "rust",
                    "scss",
                    "sql",
                    "toml",
                    "tsx",
                    "typescript",
                    "typescript",
                    "terraform",
                    "vim",
                    "yaml",
                    "zig",
                },
                auto_install = true,
                -- setting this to true looks nice but drastically reduces UI responsiveness
                highlight = { enable = true, additional_vim_regex_highlighting = false },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<leader>ss",
                        node_incremental = "<leader>si",
                        scope_incremental = "<leader>sc",
                        node_decremental = "<leader>sd",
                    },
                },
                autopairs = { enable = true },
                autotag = { enable = true, enable_close_on_slash = false },
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = "o",
                        toggle_hl_groups = "i",
                        toggle_injected_languages = "t",
                        toggle_anonymous_nodes = "a",
                        toggle_language_display = "I",
                        focus_language = "f",
                        unfocus_language = "F",
                        update = "R",
                        goto_node = "<cr>",
                        show_help = "?",
                    },
                },
            })
        end,
    },
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            vim.g.skip_ts_context_commentstring_module = true
            require("ts_context_commentstring").setup({})
        end,
    },
    "windwp/nvim-ts-autotag",
}
