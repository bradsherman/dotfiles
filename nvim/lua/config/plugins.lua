-- Install the browser preview binary when the plugin is added or updated.
vim.api.nvim_create_autocmd("PackChanged", {
	group = vim.api.nvim_create_augroup("MarkdownPreviewInstall", { clear = true }),
	callback = function(ev)
		if ev.data.spec.name == "markdown-preview.nvim" and ev.data.kind ~= "delete" then
			vim.cmd("packadd markdown-preview.nvim")
			vim.fn["mkdp#util#install"]()
		end
	end,
})

vim.pack.add({
	{ src = "https://github.com/iamcco/markdown-preview.nvim" },
	{ src = "https://github.com/karb94/neoscroll.nvim" },
	{ src = "https://github.com/rebelot/kanagawa.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://github.com/folke/which-key.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/NicholasZolton/neojj" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/mrcjkb/haskell-snippets.nvim" },
	{ src = "https://github.com/mfussenegger/nvim-lint" },
	{ src = "https://github.com/echasnovski/mini.surround" },
	{ src = "https://github.com/echasnovski/mini.ai" },
	{ src = "https://github.com/chrisgrieser/nvim-spider" },
	{ src = "https://github.com/hat0uma/csvview.nvim" },
	{ src = "https://github.com/chrisgrieser/nvim-origami" },
	{ src = "https://github.com/luukvbaal/statuscol.nvim" },
	{ src = "https://github.com/kevinhwang91/nvim-bqf" },
	{ src = "https://github.com/rafikdraoui/jj-diffconflicts" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" },
})
