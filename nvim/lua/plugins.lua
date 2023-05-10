local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
    "rktjmp/lush.nvim",
    "nvim-lualine/lualine.nvim",
    "j-hui/fidget.nvim",
    "windwp/nvim-autopairs",
    "junegunn/fzf",
    "junegunn/fzf.vim",
    "NvChad/nvim-colorizer.lua",
    "karb94/neoscroll.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-tree/nvim-tree.lua",
    "nvim-neo-tree/neo-tree.nvim",
    {
        "stevearc/oil.nvim",
        -- Optional dependencies
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    "mrbjarksen/neo-tree-diagnostics.nvim",
    "stevearc/dressing.nvim",
    "dhruvasagar/vim-table-mode",
    "christoomey/vim-tmux-navigator",
    "moll/vim-bbye",
    "lewis6991/impatient.nvim",
    "nvim-neorg/neorg-telescope",
    { "nvim-neorg/neorg", dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" } },
    "ThePrimeagen/harpoon",
    "lewis6991/hover.nvim",

    -- begin colorschemes
    { "mcchrish/zenbones.nvim", lazy = true },
    { "EdenEast/nightfox.nvim", lazy = true },
    { "folke/tokyonight.nvim", lazy = true },
    { "marko-cerovac/material.nvim", lazy = true },
    { "sainnhe/everforest", lazy = true },
    { "tanvirtin/monokai.nvim", lazy = true },
    { "shaunsingh/nord.nvim", lazy = true },
    { "ishan9299/nvim-solarized-lua", lazy = true },
    { "navarasu/onedark.nvim", lazy = true },
    { "NTBBloodbath/doom-one.nvim", lazy = true },
    { "catppuccin/nvim", lazy = true, name = "catppuccin" },
    { "rmehri01/onenord.nvim", lazy = true },
    { "daschw/leaf.nvim", lazy = true },
    { "rebelot/kanagawa.nvim", lazy = true },
    -- end colorschemes

    -- begin git
    "lewis6991/gitsigns.nvim",
    "akinsho/git-conflict.nvim",
    "ruifm/gitlinker.nvim",
    "ThePrimeagen/git-worktree.nvim",
    "TimUntersberger/neogit",
    --[[ "pwntester/octo.nvim", ]]
    {
        "NWVi/octo.nvim",
        branch = "config-review-use-local-fs",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            "nvim-web-devicons",
        },
    },
    "ldelossa/litee.nvim",
    "ldelossa/gh.nvim",
    "sindrets/diffview.nvim",
    -- end git

    -- being telescope
    "nvim-telescope/telescope.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim",
    "nvim-telescope/telescope-fzy-native.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-file-browser.nvim",
    "luc-tielen/telescope_hoogle",
    "princejoogie/dir-telescope.nvim",
    -- end telescope

    -- begin lsp / cmp
    { "williamboman/mason.nvim", build = ":MasonUpdate" },
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "MrcJkb/haskell-tools.nvim",
    "jose-elias-alvarez/null-ls.nvim",
    "jose-elias-alvarez/typescript.nvim",
    "rafamadriz/friendly-snippets",
    "molleweide/LuaSnip-snippets.nvim",
    "camilledejoye/nvim-lsp-selection-range",
    "onsails/lspkind.nvim",
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
    "L3MON4D3/LuaSnip",
    "smjonas/inc-rename.nvim",
    {
        "nvim-neotest/neotest",
        requires = {
            "mrcjkb/neotest-haskell",
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
        },
    },
    "hashivim/vim-terraform",
    "nanotee/sqls.nvim",
    "mattn/emmet-vim",
    "vmchale/dhall-vim",
    "LnL7/vim-nix",
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    -- end lsp / cmp

    -- begin treesitter
    { "nvim-treesitter/nvim-treesitter", lazy = false },
    "nvim-treesitter/nvim-treesitter-context",
    "nvim-treesitter/playground",
    "JoosepAlviste/nvim-ts-context-commentstring",
    "windwp/nvim-ts-autotag",
    "mrjones2014/nvim-ts-rainbow",
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
    "folke/trouble.nvim",
    "folke/noice.nvim",
    "glepnir/lspsaga.nvim",
    "rainbowhxch/beacon.nvim",
    "lukas-reineke/indent-blankline.nvim",
    "folke/todo-comments.nvim",
    "folke/zen-mode.nvim",
    "folke/twilight.nvim",
    "folke/which-key.nvim",
    "akinsho/bufferline.nvim",
    "zbirenbaum/neodim",
    "simrat39/symbols-outline.nvim",
    {
        "iamcco/markdown-preview.nvim",
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    "anuvyklack/keymap-amend.nvim",
    "anuvyklack/pretty-fold.nvim",
    "anuvyklack/fold-preview.nvim",
    "anuvyklack/middleclass",
    "anuvyklack/animation.nvim",
    "anuvyklack/windows.nvim",
    { "mvllow/modes.nvim", tag = "v0.2.0" },
    "sindrets/winshift.nvim",
    "mrjones2014/smart-splits.nvim",
    "lukas-reineke/headlines.nvim",
    "nvim-zh/colorful-winsep.nvim",
    "ray-x/guihua.lua",
    "ray-x/sad.nvim",
    "luukvbaal/statuscol.nvim",
    -- end ui
})
