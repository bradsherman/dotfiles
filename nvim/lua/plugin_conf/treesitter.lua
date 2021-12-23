local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

parser_configs.norg = {
	install_info = {
		url = "https://github.com/nvim-neorg/tree-sitter-norg",
		files = { "src/parser.c", "src/scanner.cc" },
		branch = "main",
	},
}

require("nvim-treesitter.configs").setup({
	-- one of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = {
		"norg",
		"haskell",
		"graphql",
		"json",
		"javascript",
		"yaml",
		"bash",
		"typescript",
		"markdown",
		"html",
		"clojure",
		"rust",
		"lua",
		"python",
		"query",
	},
	-- setting this to true looks nice but drastically reduces UI responsiveness
	highlight = { enable = true, additional_vim_regex_highlighting = true },
	indent = { enable = true },
	autopairs = { enable = true },
	context_commentstring = { enable = true, enable_autocmd = false },
	rainbow = {
		enable = true,
		-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
		extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
		max_file_lines = nil, -- Do not enable for files with more than n lines, int
		-- colors = {}, -- table of hex strings
		-- termcolors = {} -- table of colour name strings
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
})
