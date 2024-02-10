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
    { "nvim-tree/nvim-web-devicons", lazy = true },
    "dhruvasagar/vim-table-mode",
    "moll/vim-bbye",
    "nvim-neorg/neorg-telescope",
    { "nvim-pack/nvim-spectre", dependencies = { "nvim-lua/plenary.nvim" } },
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

    -- begin testing
    "mrcjkb/neotest-haskell",
    {
        "nvim-neotest/neotest",
        dependencies = {
            "mrcjkb/neotest-haskell",
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
        },
    },
    -- end testing
    "Vigemus/iron.nvim",

    { "AdeAttwood/ivy.nvim", build = "cargo build --release" },

    { "fazibear/screen_saviour.nvim" },
}
