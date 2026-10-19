-- bash-language-server.
return {
	cmd = { "bash-language-server", "start" },
	filetypes = { "sh", "bash" },
	root_markers = { ".jj", ".git" },
}
