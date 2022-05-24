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
    use("TimUntersberger/neogit")

    use("numToStr/Comment.nvim")
    use("JoosepAlviste/nvim-ts-context-commentstring")
    use("tpope/vim-fugitive")
    use("tpope/vim-repeat")
    use("tpope/vim-surround")

    use("rcarriga/nvim-notify")

    use("flazz/vim-colorschemes")
    use({
        "mcchrish/zenbones.nvim",
        requires = "rktjmp/lush.nvim",
    })
    use("EdenEast/nightfox.nvim")
    use("folke/tokyonight.nvim")
    use("nvim-lualine/lualine.nvim")
    use("j-hui/fidget.nvim")
    use("windwp/nvim-autopairs")
    use("windwp/nvim-ts-autotag")

    use("~/.fzf")
    use("junegunn/fzf")
    use("junegunn/fzf.vim")
    use("nvim-telescope/telescope.nvim")
    use("nvim-telescope/telescope-fzy-native.nvim")
    use("nvim-telescope/telescope-file-browser.nvim")
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
    use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })

    use("norcalli/nvim-colorizer.lua")
    use("luochen1990/rainbow")
    use("karb94/neoscroll.nvim")
    use("kyazdani42/nvim-web-devicons")
    use("kyazdani42/nvim-tree.lua")
    use("ishan9299/nvim-solarized-lua")

    use("folke/lsp-colors.nvim")
    use("neovim/nvim-lspconfig")
    use("williamboman/nvim-lsp-installer")
    use("jose-elias-alvarez/null-ls.nvim")
    use("jose-elias-alvarez/typescript.nvim")
    use("rafamadriz/friendly-snippets")
    use("JASONews/glow-hover")
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

    use({
        "filipdutescu/renamer.nvim",
        branch = "master",
        requires = { "nvim-lua/plenary.nvim" },
    })

    use("pwntester/octo.nvim")
    use("ldelossa/litee.nvim")
    use("ldelossa/gh.nvim")
    use("luukvbaal/stabilize.nvim")

    use("mfussenegger/nvim-dap")
    use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })
    use({ "nvim-telescope/telescope-dap.nvim" })
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) -- We recommend updating the parsers on update
    use("mfussenegger/nvim-ts-hint-textobject")
    use("Pocco81/DAPInstall.nvim")
    use("theHamsta/nvim-dap-virtual-text")
    use("nvim-treesitter/nvim-treesitter-context")
    use("nvim-treesitter/playground")
    use("p00f/nvim-ts-rainbow")
    use("folke/trouble.nvim")
    use("ray-x/lsp_signature.nvim")
    use("tami5/lspsaga.nvim")
    use("hashivim/vim-terraform")
    use("stevearc/dressing.nvim")
    use("rainbowhxch/beacon.nvim")

    use("nanotee/sqls.nvim")
    -- -- use 'lifepillar/pgsql.vim'
    use("dhruvasagar/vim-table-mode")
    -- -- use 'unisonweb/unison', { 'branch': 'trunk', 'rtp': 'editor-support/vim' }

    use("akinsho/toggleterm.nvim")

    use("mattn/emmet-vim")

    -- use("ggandor/lightspeed.nvim")
    use("vmchale/dhall-vim")
    use("lukas-reineke/indent-blankline.nvim")
    use("christoomey/vim-tmux-navigator")

    use("folke/todo-comments.nvim")
    use("sindrets/diffview.nvim")
    use("folke/zen-mode.nvim")
    use("folke/twilight.nvim")
    use({
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
    })

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

    use("narutoxy/dim.lua")
    -- this may be better since it's at lsp level, but doesn't
    -- work for haskell
    -- use("zbirenbaum/neodim")
    use("simrat39/symbols-outline.nvim")

    use("napmn/react-extract.nvim")
    use("ziontee113/syntax-tree-surfer")
    use("LnL7/vim-nix")
    -- use({ "goolord/alpha-nvim", requires = "kyazdani42/nvim-web-devicons" })
    -- use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight

    use({
        "iamcco/markdown-preview.nvim",
        run = function()
            vim.fn["mkdp#util#install"]()
        end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
