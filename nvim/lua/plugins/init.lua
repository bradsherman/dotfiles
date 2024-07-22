return {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "tpope/vim-repeat",
    {
        "numToStr/Comment.nvim",
        lazy = false,
        dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
        config = function()
            local comment = require("Comment")
            comment.setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
    },
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({ "telescope" })
        end,
    },
    "Aasim-A/scrollEOF.nvim",
    {
        "nvim-tree/nvim-web-devicons",
        priority = 500,
        opts = {
            -- your personnal icons can go here (to override)
            -- you can specify color or cterm_color instead of specifying both of them
            -- DevIcon will be appended to `name`
            override = {
                zsh = {
                    icon = "",
                    color = "#428850",
                    cterm_color = "65",
                    name = "Zsh",
                },
                norg = {
                    icon = "◉ ",
                    color = "#4878BE",
                    name = "Neorg",
                },
                oil = {
                    icon = "󰏇 ",
                    color = "#24283b",
                    name = "oil",
                },
            },
            -- globally enable different highlight colors per icon (default to true)
            -- if set to false all icons will have the default icon's color
            color_icons = true,
            -- globally enable default icons (default to false)
            -- will get overriden by `get_icons` option
            default = true,
            -- globally enable "strict" selection of icons - icon will be looked up in
            -- different tables, first by filename, and if not found by extension; this
            -- prevents cases when file doesn't have any extension but still gets some icon
            -- because its name happened to match some extension (default to false)
            strict = true,
            -- same as `override` but specifically for overrides by filename
            -- takes effect when `strict` is true
            override_by_filename = {
                [".gitignore"] = {
                    icon = "",
                    color = "#f1502f",
                    name = "Gitignore",
                },
            },
            -- same as `override` but specifically for overrides by extension
            -- takes effect when `strict` is true
            override_by_extension = {
                ["log"] = {
                    icon = "",
                    color = "#81e043",
                    name = "Log",
                },
                ["hcl"] = {
                    icon = " ",
                    color = "#5F43E9",
                    name = "HCL",
                },
            },
        },
    },
    "dhruvasagar/vim-table-mode",
    "moll/vim-bbye",
    "nvim-neorg/neorg-telescope",
    {
        "MagicDuck/grug-far.nvim",
        config = function()
            require("grug-far").setup({
                -- shortcuts for the actions you see at the top of the buffer
                -- set to '' to unset. Unset mappings will be removed from the help header
                -- They are all mappings for both insert and normal mode except for gotoLocation
                -- which is normal mode only. The distinction is mostly due to how they tend to
                -- be used and in order to show something that is not too busy-looking in the help menu
                keymaps = {
                    -- normal and insert mode
                    replace = "<C-r>",
                    qflist = "<C-q>",
                    syncLocations = "<C-t>",
                    close = "<C-x>",

                    -- normal mode only
                    gotoLocation = "<enter>",
                },
            })
        end,
    },
    {
        {
            "Bekaboo/dropbar.nvim",
            -- optional, but required for fuzzy finder support
            dependencies = {
                "nvim-telescope/telescope-fzf-native.nvim",
            },
        },
    },

    "akinsho/toggleterm.nvim",

    { "j-hui/fidget.nvim", opts = {} },
    { "xiyaowong/transparent.nvim" },
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
    },
    {
        "folke/zen-mode.nvim",
        opts = {},
    },
    {
        "folke/twilight.nvim",
        opts = {},
    },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    { "kevinhwang91/promise-async" },
    {
        "anuvyklack/windows.nvim",
        dependencies = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim",
        },
        config = function()
            vim.o.winwidth = 10
            vim.o.winminwidth = 10
            vim.o.equalalways = false
            require("windows").setup()
        end,
    },
    "sindrets/winshift.nvim",
    "mrjones2014/smart-splits.nvim",
    "luukvbaal/statuscol.nvim",
    {
        "OlegGulevskyy/better-ts-errors.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
        config = true,
    },
    "hiphish/rainbow-delimiters.nvim",
    "ziontee113/syntax-tree-surfer",
    -- end ui

    "Vigemus/iron.nvim",

    -- { "AdeAttwood/ivy.nvim", build = "cargo build --release" },

    { "fazibear/screen_saviour.nvim" },
    {
        "danymat/neogen",
        config = true,
    },
    {
        "chrisgrieser/nvim-recorder",
        dependencies = "rcarriga/nvim-notify", -- optional
        opts = {}, -- required even with default settings, since it calls `setup()`
    },
    {
        "max397574/better-escape.nvim",
        config = function()
            require("better_escape").setup()
        end,
    },
}
