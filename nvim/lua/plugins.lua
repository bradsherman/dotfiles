-- auto install packer
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

vim.cmd([[autocmd BufWritePost plugins.lua source <afile> | PackerCompile]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'TimUntersberger/neogit'

  use 'ntpeters/vim-better-whitespace'
  use 'mhinz/vim-signify'

  use 'tpope/vim-commentary'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'

  use 'flazz/vim-colorschemes'
  use 'hoob3rt/lualine.nvim'
  use 'APZelos/blamer.nvim'
  use 'jiangmiao/auto-pairs'

  use '~/.fzf'
  use 'junegunn/fzf'
  use 'junegunn/fzf.vim'
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-fzy-native.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  use 'norcalli/nvim-colorizer.lua'
  use 'luochen1990/rainbow'
  use 'RRethy/vim-illuminate'
  use 'karb94/neoscroll.nvim'
  use 'inside/vim-search-pulse'
  use 'preservim/nerdtree'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'ryanoasis/vim-devicons'
  use 'overcache/NeoSolarized'
  use 'lifepillar/vim-solarized8'
  use 'arcticicestudio/nord-vim'

  use 'folke/lsp-colors.nvim'
  use 'neovim/nvim-lspconfig'
  use 'glepnir/lspsaga.nvim'
  use 'onsails/lspkind-nvim'
  -- Install nvim-cmp, and buffer source as a dependency
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
      'quangnguyen30192/cmp-nvim-tags',
      'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    }
  }
  use 'L3MON4D3/LuaSnip'

  use 'hrsh7th/nvim-compe'
  use 'rafamadriz/friendly-snippets'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/vim-vsnip-integ'
  use 'nvim-lua/lsp-status.nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}  -- We recommend updating the parsers on update
  use 'nvim-treesitter/playground'
  use 'folke/trouble.nvim'
  use 'ray-x/lsp_signature.nvim'

  use 'lifepillar/pgsql.vim'
  use 'dhruvasagar/vim-table-mode'
  -- use 'unisonweb/unison', { 'branch': 'trunk', 'rtp': 'editor-support/vim' }

  use 'kassio/neoterm'

  use 'mattn/emmet-vim'

  use {
    'phaazon/hop.nvim',
    as = 'hop',
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
  use 'vmchale/dhall-vim'
  use 'Yggdroot/indentLine'
  -- use 'lukas-reineke/indent-blankline.nvim'
  use 'christoomey/vim-tmux-navigator'

  use 'folke/todo-comments.nvim'
  use 'sindrets/diffview.nvim'
  use 'folke/zen-mode.nvim'
  use {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
  }
end)
