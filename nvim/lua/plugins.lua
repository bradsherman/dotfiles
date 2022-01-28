local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
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
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

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
	use("TimUntersberger/neogit")

	-- use 'ntpeters/vim-better-whitespace'
	use("mhinz/vim-signify")

	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("tpope/vim-fugitive")
	use("tpope/vim-repeat")
	use("tpope/vim-surround")

	use("flazz/vim-colorschemes")
	use({
		"mcchrish/zenbones.nvim",
		requires = "rktjmp/lush.nvim",
	})
	use("EdenEast/nightfox.nvim")
	use("folke/tokyonight.nvim")
	use("nvim-lualine/lualine.nvim")
	use("arkav/lualine-lsp-progress")
	use("APZelos/blamer.nvim")
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	use("~/.fzf")
	use("junegunn/fzf")
	use("junegunn/fzf.vim")
	use("nvim-telescope/telescope.nvim")
	use("nvim-telescope/telescope-fzy-native.nvim")
	use({ "nvim-telescope/telescope-file-browser.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })

	use("norcalli/nvim-colorizer.lua")
	use("luochen1990/rainbow")
	use("karb94/neoscroll.nvim")
	use("inside/vim-search-pulse")
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("ishan9299/nvim-solarized-lua")

	use("folke/lsp-colors.nvim")
	use("neovim/nvim-lspconfig")
	use("williamboman/nvim-lsp-installer")
	use("jose-elias-alvarez/null-ls.nvim")
	use("jose-elias-alvarez/nvim-lsp-ts-utils")
	-- Install nvim-cmp, and buffer source as a dependency
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"quangnguyen30192/cmp-nvim-tags",
			"saadparwaiz1/cmp_luasnip", -- Snippets source for nvim-cmp
		},
	})
	use("L3MON4D3/LuaSnip")

	use({
		"hood/popui.nvim",
		requires = {
			"RishabhRD/popfix",
		},
	})
	use({
		"filipdutescu/renamer.nvim",
		branch = "master",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	use("pwntester/octo.nvim")
	use("luc-tielen/telescope_hoogle")
	use("luukvbaal/stabilize.nvim")

	use("rafamadriz/friendly-snippets")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- We recommend updating the parsers on update
	use("romgrk/nvim-treesitter-context")
	use("nvim-treesitter/playground")
	use("p00f/nvim-ts-rainbow")
	use("folke/trouble.nvim")
	use("ray-x/lsp_signature.nvim")
	use("tami5/lspsaga.nvim")
	use("hashivim/vim-terraform")
	use("stevearc/dressing.nvim")

	-- -- use 'lifepillar/pgsql.vim'
	use("dhruvasagar/vim-table-mode")
	-- -- use 'unisonweb/unison', { 'branch': 'trunk', 'rtp': 'editor-support/vim' }

	use("akinsho/toggleterm.nvim")

	use("mattn/emmet-vim")

	use("ggandor/lightspeed.nvim")
	use("vmchale/dhall-vim")
	use("lukas-reineke/indent-blankline.nvim")
	use("christoomey/vim-tmux-navigator")

	use("folke/todo-comments.nvim")
	use("sindrets/diffview.nvim")
	use("Pocco81/TrueZen.nvim")
	use("folke/zen-mode.nvim")
	use({
		"dstein64/vim-startuptime",
		cmd = "StartupTime",
	})

	use({
		"nvim-neorg/neorg",
		requires = "nvim-lua/plenary.nvim",
	})

	use("folke/which-key.nvim")
	use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
	use("moll/vim-bbye")
	use("lewis6991/impatient.nvim")
	use({ "goolord/alpha-nvim", requires = "kyazdani42/nvim-web-devicons" })
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
