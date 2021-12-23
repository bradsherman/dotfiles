local map = require("utils").map

vim.g.nvim_tree_quit_on_open = 1

require("nvim-tree").setup({
	diagnostics = {
		enable = true,
	},
	filters = {
		custom = { ".git", "*.hie" },
	},
	open_on_setup = false,
	auto_close = true,
	view = {
		side = "right",
	},
})

map("n", "<c-e>", ":NvimTreeToggle<cr>")
map("n", "<leader>e", ":NvimTreeFindFile<cr>")
