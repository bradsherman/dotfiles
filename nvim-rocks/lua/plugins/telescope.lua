local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
require('telescope').setup({
    -- picker = {
    -- hidden = false,
    -- },
    defaults = {
        borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
        -- borderchars = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
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
        file_ignore_patterns = { "node_modules", ".git/", "dist/" },
        path_display = {
            shorten = {
                len = 3,
                exclude = { -1 },
            },
        },
        use_less = false,
        set_env = { ["COLORTERM"] = "truecolor" },
        file_previewer = previewers.cat.new,
        grep_previewer = previewers.vimgrep.new,
        qflist_previewer = previewers.qflist.new,
        buffer_previewer_maker = previewers.buffer_previewer_maker,
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
})
