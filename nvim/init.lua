-- Core preferences first, then packages and their configuration.
require("options")
require("keybindings")
require("autocommands")
require("config.plugins")
require("config.appearance")
require("statusline")

-- Load file and LSP integrations after the first screen so opening a file
-- does not wait for every optional integration to initialize.
local integrations_loaded = false
local function load_integrations()
	if integrations_loaded then
		return
	end
	integrations_loaded = true
	require("config.lsp")
	require("config.treesitter")
	require("config.navigation")
	require("config.formatting")
	require("editing")
	require("linting")

	-- A file passed on the command line may have fired FileType before these
	-- integrations were registered. Initialize their buffer-local behavior now.
	local buf = vim.api.nvim_get_current_buf()
	local filetype = vim.bo[buf].filetype
	if filetype ~= "" and vim.bo[buf].buftype == "" then
		pcall(vim.treesitter.start, buf)
		local has_parser = pcall(vim.treesitter.get_parser, buf)
		vim.wo.foldmethod = has_parser and "expr" or "indent"
		vim.wo.foldexpr = has_parser and "v:lua.vim.treesitter.foldexpr()" or "0"
	end
end

vim.schedule(load_integrations)
