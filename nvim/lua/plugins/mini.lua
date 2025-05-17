return {
    {
        "echasnovski/mini.extra",
        opts = {},
        config = function()
            require("mini.extra").setup()
        end,
    },
    {
        "echasnovski/mini.ai",
        opts = {},
        config = function()
            require("mini.ai").setup()
        end,
    },
    {
        "echasnovski/mini.bracketed",
        opts = {},
        config = function()
            require("mini.bracketed").setup()
        end,
    },
    {
        "echasnovski/mini.pairs",
        opts = {},
        config = function()
            require("mini.pairs").setup()
        end,
    },
    {
        "echasnovski/mini.files",
        opts = {
            -- Customization of explorer windows
            windows = {
                -- Maximum number of windows to show side by side
                max_number = math.huge,
                -- Whether to show preview of file/directory under cursor
                preview = false,
                -- Width of focused window
                width_focus = 50,
                -- Width of non-focused window
                width_nofocus = 15,
                -- Width of preview window
                width_preview = 25,
            },
        },
    },
    {
        "echasnovski/mini.icons",
        version = false,
        config = function()
            require("mini.icons").setup()
        end,
    },
    {
        "echasnovski/mini.indentscope",
        -- event = { "BufReadPre", "BufNewFile" },
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
    },
    {
        "echasnovski/mini.operators",
        version = false,
        config = function()
            require("mini.operators").setup()
        end,
    },
    {
        "echasnovski/mini.surround",
        version = false,
        config = function()
            require("mini.surround").setup()
        end,
    },
    {
        "echasnovski/mini.pick",
        opts = {
            -- Delays (in ms; should be at least 1)
            delay = {
                -- Delay between forcing asynchronous behavior
                async = 10,
                -- Delay between computation start and visual feedback about it
                busy = 50,
            },

            -- Keys for performing actions. See `:h MiniPick-actions`.
            mappings = {
                caret_left = "<Left>",
                caret_right = "<Right>",

                choose = "<CR>",
                choose_in_split = "<C-s>",
                choose_in_tabpage = "<C-t>",
                choose_in_vsplit = "<C-v>",
                choose_marked = "<M-CR>",

                delete_char = "<BS>",
                delete_char_right = "<Del>",
                delete_left = "<C-u>",
                delete_word = "<C-w>",

                mark = "<C-x>",
                mark_all = "<C-a>",

                move_down = "<C-j>",
                move_start = "<C-g>",
                move_up = "<C-k>",

                paste = "<C-r>",

                refine = "<C-Space>",
                refine_marked = "<M-Space>",

                scroll_down = "<C-f>",
                scroll_left = "<C-h>",
                scroll_right = "<C-l>",
                scroll_up = "<C-b>",

                stop = "<Esc>",

                toggle_info = "<S-Tab>",
                toggle_preview = "<Tab>",
            },

            -- General options
            options = {
                -- Whether to show content from bottom to top
                content_from_bottom = false,

                -- Whether to cache matches (more speed and memory on repeated prompts)
                use_cache = false,
            },

            -- Source definition. See `:h MiniPick-source`.
            source = {
                items = nil,
                name = nil,
                cwd = nil,

                match = nil,
                show = nil,
                preview = nil,

                choose = nil,
                choose_marked = nil,
            },

            -- Window related options
            window = {
                -- Float window config (table or callable returning it)
                config = nil,
            },
        },
    },
}
