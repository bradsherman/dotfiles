return {
	cmd = { "docker-langserver", "--stdio" },
	filetypes = { "dockerfile" },
	root_markers = { "Dockerfile", "compose.yaml", "docker-compose.yml", ".jj", ".git" },
}
