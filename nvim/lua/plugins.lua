local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    -- selene: allow(unscoped_variables,unused_variable)
    PACKER_BOOTSTRAP = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd([[ packadd packer.nvim ]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local pc = vim.api.nvim_create_augroup("PackerConfig", { clear = true })
vim.api.nvim_create_autocmd(
    "BufWritePost",
    { pattern = "plugins.lua", command = "source <afile> | PackerSync", group = pc }
)

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init({
    display = {
        open_fn = function()
            return require("packer.util").float({ border = "rounded" })
        end,
    },
})

return packer.startup(function(use)
    use("wbthomason/packer.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-lua/plenary.nvim")
    use({
        "MrcJkb/haskell-tools.nvim",
        requires = {
            "neovim/nvim-lspconfig",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim", -- optional
        },
    })

    use("TimUntersberger/neogit")
    use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
    use({ "akinsho/git-conflict.nvim", tag = "*" })
    use({
        "ruifm/gitlinker.nvim",
        requires = "nvim-lua/plenary.nvim",
    })
    use("ThePrimeagen/git-worktree.nvim")

    use("numToStr/Comment.nvim")
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("tpope/vim-repeat")
    use("kylechui/nvim-surround")

    use("rcarriga/nvim-notify")
    use({ "kevinhwang91/nvim-bqf", ft = "qf" })

    -- colorschemes
    use({
        "mcchrish/zenbones.nvim",
        requires = "rktjmp/lush.nvim",
    })
    use("EdenEast/nightfox.nvim")
    use("folke/tokyonight.nvim")
    use("marko-cerovac/material.nvim")
    use("sainnhe/everforest")
    use("tanvirtin/monokai.nvim")
    use("shaunsingh/nord.nvim")
    use("ishan9299/nvim-solarized-lua")
    use("navarasu/onedark.nvim")
    use("NTBBloodbath/doom-one.nvim")
    use({ "catppuccin/nvim", as = "catppuccin" })
    use("rmehri01/onenord.nvim")
    use("daschw/leaf.nvim")
    use("rebelot/kanagawa.nvim")

    use("nvim-lualine/lualine.nvim")

    use("j-hui/fidget.nvim")
    use("windwp/nvim-autopairs")
    use("windwp/nvim-ts-autotag")

    use("~/.fzf")
    use("junegunn/fzf")
    use("junegunn/fzf.vim")
    use({ "nvim-telescope/telescope.nvim", requires = "nvim-telescope/telescope-live-grep-args.nvim" })
    use("nvim-telescope/telescope-fzy-native.nvim")
    use("nvim-telescope/telescope-file-browser.nvim")
    use("luc-tielen/telescope_hoogle")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({
        "princejoogie/dir-telescope.nvim",
        -- telescope.nvim is a required dependency
        requires = { "nvim-telescope/telescope.nvim" },
    })

    use("NvChad/nvim-colorizer.lua")
    use("karb94/neoscroll.nvim")
    --[[ use("petertriho/nvim-scrollbar") ]]
    use("kyazdani42/nvim-web-devicons")
    use("kyazdani42/nvim-tree.lua")
    use({ "nvim-neo-tree/neo-tree.nvim", requires = { "MunifTanjim/nui.nvim", "s1n7ax/nvim-window-picker" } })
    use({
        "mrbjarksen/neo-tree-diagnostics.nvim",
        requires = "nvim-neo-tree/neo-tree.nvim",
    })

    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")
    use("neovim/nvim-lspconfig")
    use("jose-elias-alvarez/null-ls.nvim")
    use("jose-elias-alvarez/typescript.nvim")
    use("rafamadriz/friendly-snippets")
    use("molleweide/LuaSnip-snippets.nvim")
    use("onsails/lspkind.nvim")
    -- Install nvim-cmp, and buffer source as a dependency
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-cmdline",
            "ray-x/cmp-treesitter",
            "quangnguyen30192/cmp-nvim-tags",
            "saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "hrsh7th/cmp-nvim-lsp-signature-help",
        },
    })
    use("L3MON4D3/LuaSnip")

    use("smjonas/inc-rename.nvim")

    use("pwntester/octo.nvim")
    use("ldelossa/litee.nvim")
    use("ldelossa/gh.nvim")

    use("mfussenegger/nvim-dap")
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
    use({ "nvim-telescope/telescope-dap.nvim" })
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- We recommend updating the parsers on update
    use("Pocco81/DAPInstall.nvim")
    use("theHamsta/nvim-dap-virtual-text")
    use("nvim-treesitter/nvim-treesitter-context")
    use("nvim-treesitter/playground")
    use("folke/trouble.nvim")
    use("glepnir/lspsaga.nvim")
    use("hashivim/vim-terraform")
    use("stevearc/dressing.nvim")
    use("rainbowhxch/beacon.nvim")
    use("mrjones2014/nvim-ts-rainbow")

    use("nanotee/sqls.nvim")
    use("dhruvasagar/vim-table-mode")

    use("akinsho/toggleterm.nvim")

    use("mattn/emmet-vim")

    use("vmchale/dhall-vim")
    use("lukas-reineke/indent-blankline.nvim")
    use("christoomey/vim-tmux-navigator")

    use("folke/todo-comments.nvim")
    use("sindrets/diffview.nvim")
    use("folke/zen-mode.nvim")
    use("folke/twilight.nvim")

    use({
        "nvim-neorg/neorg",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-neorg/neorg-telescope",
        },
    })

    use("folke/which-key.nvim")
    use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
    use("moll/vim-bbye")
    use("lewis6991/impatient.nvim")

    use("zbirenbaum/neodim")
    use("simrat39/symbols-outline.nvim")

    use("ziontee113/syntax-tree-surfer")
    use("LnL7/vim-nix")

    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })

    use("ThePrimeagen/harpoon")
    use({
        "anuvyklack/fold-preview.nvim",
        requires = "anuvyklack/keymap-amend.nvim",
    })
    use("anuvyklack/pretty-fold.nvim")
    use({
        "anuvyklack/windows.nvim",
        requires = {
            "anuvyklack/middleclass",
            "anuvyklack/animation.nvim",
        },
    })
    --[[ use("gbprod/yanky.nvim") ]]
    use({ "mvllow/modes.nvim", tag = "v0.2.0" })

    use("sindrets/winshift.nvim")
    use("mrjones2014/smart-splits.nvim")

    --[[ use("folke/noice.nvim") ]]
    use("lukas-reineke/headlines.nvim")
    use("nvim-zh/colorful-winsep.nvim")

    use("ray-x/guihua.lua")
    use("ray-x/sad.nvim")
    use("luukvbaal/statuscol.nvim")

    --[[ use("nyngwang/murmur.lua") ]]

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    -- selene: allow(undefined_variable)
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
