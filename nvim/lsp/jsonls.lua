return {
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	root_markers = { "package.json", ".jj", ".git" },
	init_options = { provideFormatter = true },
	settings = { json = { validate = { enable = true }, format = { enable = true } } },
}
