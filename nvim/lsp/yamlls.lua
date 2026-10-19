return {
	cmd = { "yaml-language-server", "--stdio" },
	filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
	root_markers = { ".yamllint", ".yamllint.yaml", ".jj", ".git" },
	settings = {
		yaml = {
			keyOrdering = false,
			validate = true,
			hover = true,
			completion = true,
			schemaStore = { enable = true },
			format = { enable = true },
		},
	},
}
