local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    return
end

lazy.setup({
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "s1n7ax/nvim-window-picker",
    "tpope/vim-repeat",
    "numToStr/Comment.nvim",
    { "kylechui/nvim-surround", version = "*", event = "VeryLazy" },
    "rcarriga/nvim-notify",
    { "kevinhwang91/nvim-bqf", ft = "qf" },
    { "SmiteshP/nvim-navic", lazy = true },
    "nvim-lualine/lualine.nvim",
    "windwp/nvim-autopairs",
    "junegunn/fzf",
    "junegunn/fzf.vim",
    "ibhagwan/fzf-lua",
    "NvChad/nvim-colorizer.lua",
    "karb94/neoscroll.nvim",
    "Aasim-A/scrollEOF.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-neo-tree/neo-tree.nvim",
    "mrbjarksen/neo-tree-diagnostics.nvim",
    "stevearc/dressing.nvim",
    "dhruvasagar/vim-table-mode",
    "moll/vim-bbye",
    "nvim-neorg/neorg-telescope",
    { "nvim-neorg/neorg", dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" } },
    "lewis6991/hover.nvim",

    -- begin colorschemes
    -- set lazy = false for main colorscheme
    { "mcchrish/zenbones.nvim", lazy = true },
    { "EdenEast/nightfox.nvim", lazy = true },
    { "folke/tokyonight.nvim", lazy = true },
    { "marko-cerovac/material.nvim", lazy = true },
    { "sainnhe/everforest", lazy = true },
    { "sainnhe/sonokai", lazy = true },
    { "tanvirtin/monokai.nvim", lazy = true },
    { "shaunsingh/nord.nvim", lazy = true },
    { "ishan9299/nvim-solarized-lua", lazy = true },
    { "navarasu/onedark.nvim", lazy = true },
    { "NTBBloodbath/doom-one.nvim", lazy = true },
    { "catppuccin/nvim", lazy = true, name = "catppuccin" },
    { "rmehri01/onenord.nvim", lazy = true },
    { "daschw/leaf.nvim", lazy = true },
    { "rebelot/kanagawa.nvim", lazy = false },
    { "projekt0n/github-nvim-theme", lazy = true },
    -- end colorschemes

    -- begin git
    "lewis6991/gitsigns.nvim",
    "akinsho/git-conflict.nvim",
    "ruifm/gitlinker.nvim",
    "bradsherman/git-worktree.nvim",
    "NeogitOrg/neogit",
    "sindrets/diffview.nvim",
    -- end git

    -- being telescope
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
    "luc-tielen/telescope_hoogle",
    "mrcjkb/telescope-manix",
    -- end telescope

    -- begin lsp / cmp
    { "williamboman/mason.nvim", build = ":MasonUpdate" },
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    { "MrcJkb/haskell-tools.nvim", branch = "2.x.x" },
    "folke/neodev.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {},
    },
    "rafamadriz/friendly-snippets",
    "molleweide/LuaSnip-snippets.nvim",
    "mrcjkb/haskell-snippets.nvim",
    "camilledejoye/nvim-lsp-selection-range",
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-cmdline",
            "ray-x/cmp-treesitter",
            "quangnguyen30192/cmp-nvim-tags",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
    },
    { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
    "smjonas/inc-rename.nvim",
    "hashivim/vim-terraform",
    "nanotee/sqls.nvim",
    "mattn/emmet-vim",
    "vmchale/dhall-vim",
    "LnL7/vim-nix",
    -- { "mrcjkb/nvim-lsp-foldexpr", lazy = false },
    "mfussenegger/nvim-lint",
    "mhartington/formatter.nvim",
    -- end lsp / cmp

    -- begin treesitter
    { "nvim-treesitter/nvim-treesitter", lazy = false, build = ":TSUpdate" },
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag",
    "hiphish/rainbow-delimiters.nvim",
    "ziontee113/syntax-tree-surfer",
    -- end treesitter

    -- begin dap
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "nvim-telescope/telescope-dap.nvim",
    "Pocco81/DAPInstall.nvim",
    "theHamsta/nvim-dap-virtual-text",
    -- end dap

    -- begin term
    "akinsho/toggleterm.nvim",
    -- end term

    -- begin ui
    "folke/noice.nvim",
    "glepnir/lspsaga.nvim",
    "rainbowhxch/beacon.nvim",
    { "lukas-reineke/indent-blankline.nvim", branch = "v3" },
    "folke/todo-comments.nvim",
    "folke/zen-mode.nvim",
    "folke/twilight.nvim",
    "folke/which-key.nvim",
    "akinsho/bufferline.nvim",
    "zbirenbaum/neodim",
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    { "kevinhwang91/promise-async" },
    { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
    "anuvyklack/windows.nvim",
    "sindrets/winshift.nvim",
    "mrjones2014/smart-splits.nvim",
    "nvim-zh/colorful-winsep.nvim",
    "luukvbaal/statuscol.nvim",
    "Bekaboo/dropbar.nvim",
    { "goolord/alpha-nvim", event = "VimEnter" },
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

    -- begin mini.nvim
    { "echasnovski/mini.files", version = false },
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = { "BufReadPre", "BufNewFile" },
    },
    -- end mini.nvim
})
