-- Treesitter (main branch / rewrite API).
-- NOTE: the `main` branch does NOT use `require("nvim-treesitter.configs").setup()`.
-- Parsers are installed explicitly, and highlighting is started per-buffer.
require("nvim-treesitter").setup({})

-- Parsers to keep installed (matches the languages used elsewhere in this config).
-- `install()` is async; parsers compile in the background and persist across restarts.
require("nvim-treesitter").install({
	"bash",
	"diff",
	"dockerfile",
	"rust",
	"git_rebase",
	"gitcommit",
	"haskell",
	"hcl",
	"javascript",
	"json",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"nix",
	"python",
	"query",
	"regex",
	"sql",
	"terraform",
	"toml",
	"tsx",
	"typescript",
	"vim",
	"vimdoc",
	"yaml",
})

-- Start treesitter highlighting whenever a buffer has a parser available.
vim.api.nvim_create_autocmd("FileType", {
	group = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true }),
	callback = function(args)
		-- pcall guards filetypes that have no installed/available parser.
		pcall(vim.treesitter.start, args.buf)
	end,
})
