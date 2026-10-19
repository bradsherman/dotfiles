-- lua-language-server. Configured for editing your Neovim config (knows `vim`).
return {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", "stylua.toml", ".git" },
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				checkThirdParty = false,
				-- Make the nvim runtime (and plugins) available for completion/hover.
				library = vim.api.nvim_get_runtime_file("", true),
			},
			hint = { enable = true }, -- inlay hints
			telemetry = { enable = false },
		},
	},
}
