-- nil: Nix language server. Uses nixfmt for formatting (matches your conform).
return {
	cmd = { "nil" },
	filetypes = { "nix" },
	root_markers = { "flake.nix", "default.nix", "shell.nix", ".git" },
	settings = {
		["nil"] = {
			formatting = { command = { "nixfmt" } },
		},
	},
}
