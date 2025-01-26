return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
        },
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
                    "http",
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
                    "xml",
                    "yaml",
                    "zig",
                },
                auto_install = true,
                -- setting this to true looks nice but drastically reduces UI responsiveness
                highlight = {
                    enable = true,
                    -- additional_vim_regex_highlighting = false,
                },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        -- init_selection = "<leader>ss",
                        -- node_incremental = "<leader>si",
                        -- scope_incremental = "<leader>sc",
                        -- node_decremental = "<leader>sd",
                        init_selection = "<C-space>",
                        node_incremental = "<C-space>",
                        scope_incremental = false,
                        node_decremental = "<bs>",
                    },
                },
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
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = true,
        config = function()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    select = {
                        enable = true,

                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            -- note, Haskell does not support these first four
                            ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                            ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                            ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
                            ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

                            ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
                            ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

                            ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                            ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

                            ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                            ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                            ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                            ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                            ["am"] = {
                                query = "@function.outer",
                                desc = "Select outer part of a method/function definition",
                            },
                            ["im"] = {
                                query = "@function.inner",
                                desc = "Select inner part of a method/function definition",
                            },

                            ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
                            ["<leader>nm"] = "@function.outer", -- swap function with next
                        },
                        swap_previous = {
                            ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
                            ["<leader>pm"] = "@function.outer", -- swap function with previous
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            ["]f"] = { query = "@call.outer", desc = "Next function call start" },
                            ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
                            ["]c"] = { query = "@class.outer", desc = "Next class start" },
                            ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                            ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

                            -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                            -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                            ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
                            ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
                        },
                        goto_next_end = {
                            ["]F"] = { query = "@call.outer", desc = "Next function call end" },
                            ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
                            ["]C"] = { query = "@class.outer", desc = "Next class end" },
                            ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
                            ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                        },
                        goto_previous_start = {
                            ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
                            ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
                            ["[c"] = { query = "@class.outer", desc = "Prev class start" },
                            ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
                            ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
                        },
                        goto_previous_end = {
                            ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
                            ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
                            ["[C"] = { query = "@class.outer", desc = "Prev class end" },
                            ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
                            ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
                        },
                    },
                },
            })
            local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")

            -- vim way: ; goes to the direction you were moving.
            -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
            vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

            -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
            vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
            vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
        end,
    },
    {
        "ColinKennedy/cursor-text-objects.nvim",
        config = function()
            local down_description = "Operate from your current cursor to the end of some text-object."
            local up_description = "Operate from the start of some text-object to your current cursor."

            vim.keymap.set("o", "[", "<Plug>(cursor-text-objects-up)", { desc = up_description })
            vim.keymap.set("o", "]", "<Plug>(cursor-text-objects-down)", { desc = down_description })
            vim.keymap.set("x", "[", "<Plug>(cursor-text-objects-up)", { desc = up_description })
            vim.keymap.set("x", "]", "<Plug>(cursor-text-objects-down)", { desc = down_description })
        end,
        version = "v1.*",
    },
    { "cshuaimin/ssr.nvim" },
    {
        "Wansmer/treesj",
        keys = { "<space>m", "<space>j", "<space>s" },
        dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
        config = function()
            require("treesj").setup({})
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        config = function()
            require("treesitter-context").setup({
                enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
                max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
                min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
                line_numbers = true,
                multiline_threshold = 3, -- Maximum number of lines to show for a single context
                trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
                mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
                -- Separator between context and content. Should be a single character string, like '-'.
                -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
                separator = nil,
                zindex = 20, -- The Z-index of the context window
                on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
            })
        end,
    },

    "nvim-treesitter/playground",
    {
        "JoosepAlviste/nvim-ts-context-commentstring",
        config = function()
            require("ts_context_commentstring").setup({ enable_autocmd = false })
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup({
                opts = {
                    -- Defaults
                    enable_close = true, -- Auto close tags
                    enable_rename = true, -- Auto rename pairs of tags
                    enable_close_on_slash = true, -- Auto close on trailing </
                },
            })
        end,
    },

    {
        "yorickpeterse/nvim-tree-pairs",
        config = true,
    },
    {
        "aaronik/treewalker.nvim",
        opts = {
            highlight = true, -- Whether to briefly highlight the node after jumping to it
        },
        config = function(_, opts)
            vim.api.nvim_set_keymap("n", "<M-j>", ":Treewalker Down<CR>", { noremap = true })
            vim.api.nvim_set_keymap("n", "<M-k>", ":Treewalker Up<CR>", { noremap = true })
            vim.api.nvim_set_keymap("n", "<M-h>", ":Treewalker Left<CR>", { noremap = true })
            vim.api.nvim_set_keymap("n", "<M-l>", ":Treewalker Right<CR>", { noremap = true })
            require("treewalker").setup(opts)
        end,
    },
}
