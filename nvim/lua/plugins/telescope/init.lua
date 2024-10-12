return {
    {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        keys = {
            -- { "<c-f>", "<cmd>Telescope find_files<cr>", desc = "Files" },
            -- { "<c-g>", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", desc = "Grep" },
            -- { "<c-b>", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            -- { "<c-t>", "<cmd>Telescope tags<cr>", desc = "Tags" },
        },
        opts = function()
            local actions = require("telescope.actions")
            return {
                defaults = {
                    borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
                    -- borderchars = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" }
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--trim",
                        -- one of these two causes a major slowdown, probably hidden
                        -- "--no-ignore",
                        "--hidden",
                    },
                    results_title = false,
                    layout_strategy = "horizontal",
                    layout_config = {
                        prompt_position = "bottom",
                    },
                    prompt_prefix = "     ",
                    -- selection_caret = "  ",
                    -- prompt_prefix = " ",
                    selection_caret = " ",
                    entry_prefix = "  ",
                    file_ignore_patterns = { "node_modules/", ".git/", "dist/", ".elixir_ls/", "_build/" },
                    path_display = {
                        -- shorten = {
                        --     len = 3,
                        --     exclude = { -1 },
                        -- },
                        filename_first = {
                            reverse_directories = false,
                        },
                    },
                    use_less = false,
                    set_env = { ["COLORTERM"] = "truecolor" },
                    mappings = {
                        i = {
                            ["<c-n>"] = actions.cycle_history_next,
                            ["<c-p>"] = actions.cycle_history_prev,
                            ["<c-j>"] = actions.move_selection_next,
                            ["<c-k>"] = actions.move_selection_previous,
                            ["<c-q>"] = actions.send_to_qflist,
                        },
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                        follow = true,
                        -- find_command = {
                        --     "fd",
                        --     "--color=never",
                        --     "--type",
                        --     "f",
                        --     "-x",
                        --     "printf",
                        --     '"{}: [0;9{//}[0m {}"',
                        -- },
                        -- string.format(
                        -- [[fd --color=never --type f --hidden --follow --exclude .git -x printf "{/} %s {}\n"]],
                        -- fzfutils.ansi_codes.grey('{//}')
                    },
                    buffers = {
                        show_all_buffers = true,
                        sort_lastused = true,
                        mappings = {
                            i = {
                                ["<c-d>"] = "delete_buffer",
                            },
                        },
                    },
                },
                extensions = {
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    file_browser = {
                        theme = "ivy",
                    },
                    live_grep_args = {
                        auto_quoting = true, -- enable/disable auto-quoting
                        -- define mappings, e.g.
                        mappings = { -- extend mappings
                            -- i = {
                            -- ["<C-k>"] = lga_actions.quote_prompt(),
                            -- ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                            -- },
                        },
                        -- ... also accepts theme settings, for example:
                        -- theme = "dropdown", -- use dropdown theme
                        -- theme = { }, -- use own theme spec
                        -- layout_config = { mirror=true }, -- mirror preview pane
                    },
                },
            }
        end,
    },
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
    "luc-tielen/telescope_hoogle",
    "mrcjkb/telescope-manix",
    {
        "fdschmidt93/telescope-egrepify.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").load_extension("egrepify")
        end,
    },
}
