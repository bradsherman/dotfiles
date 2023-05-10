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
    --[[ "MunifTanjim/nui.nvim", ]]
    --[[ "s1n7ax/nvim-window-picker", ]]
    { "EdenEast/nightfox.nvim", lazy = true },
    "lewis6991/hover.nvim",

    -- begin lsp / cmp
    { "williamboman/mason.nvim", build = ":MasonUpdate" },
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    "MrcJkb/haskell-tools.nvim",
    --[[ "jose-elias-alvarez/null-ls.nvim", ]]
    --[[ "jose-elias-alvarez/typescript.nvim", ]]
    --[[ "rafamadriz/friendly-snippets", ]]
    --[[ "molleweide/LuaSnip-snippets.nvim", ]]
    --[[ "onsails/lspkind.nvim", ]]
    --[[ { ]]
    --[[     "hrsh7th/nvim-cmp", ]]
    --[[     dependencies = { ]]
    --[[         "hrsh7th/cmp-buffer", ]]
    --[[         "hrsh7th/cmp-nvim-lsp", ]]
    --[[         "hrsh7th/cmp-path", ]]
    --[[         "hrsh7th/cmp-nvim-lua", ]]
    --[[         "hrsh7th/cmp-cmdline", ]]
    --[[         "ray-x/cmp-treesitter", ]]
    --[[         "quangnguyen30192/cmp-nvim-tags", ]]
    --[[         "saadparwaiz1/cmp_luasnip", ]]
    --[[         "hrsh7th/cmp-nvim-lsp-document-symbol", ]]
    --[[         "hrsh7th/cmp-nvim-lsp-signature-help", ]]
    --[[     }, ]]
    --[[ }, ]]
    --[[ "L3MON4D3/LuaSnip", ]]
    --[[ "smjonas/inc-rename.nvim", ]]
    --[[ "hashivim/vim-terraform", ]]
    --[[ "nanotee/sqls.nvim", ]]
    --[[ "mattn/emmet-vim", ]]
    --[[ "vmchale/dhall-vim", ]]
    --[[ "LnL7/vim-nix", ]]
    --[[ "https://git.sr.ht/~whynothugo/lsp_lines.nvim", ]]
    -- end lsp / cmp

    -- begin treesitter
    --[[ { "nvim-treesitter/nvim-treesitter", lazy = false }, ]]
    --[[ "nvim-treesitter/nvim-treesitter-context", ]]
    --[[ "nvim-treesitter/playground", ]]
    --[[ "JoosepAlviste/nvim-ts-context-commentstring", ]]
    --[[ "windwp/nvim-ts-autotag", ]]
    --[[ "mrjones2014/nvim-ts-rainbow", ]]
    --[[ "ziontee113/syntax-tree-surfer", ]]
    -- end treesitter
})

--[[ require("plugin_conf.cmp") ]]
require("plugin_conf.lsp")
--[[ require("plugin_conf.treesitter") ]]
