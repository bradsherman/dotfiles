local M = {}
local cmd = vim.cmd

M.map = function(mode, combo, mapping, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, combo, mapping, options)
end

M.create_augroup = function(autocmds, name)
	cmd("augroup " .. name)
	cmd("autocmd!")
	for _, autocmd in ipairs(autocmds) do
		cmd("autocmd " .. table.concat(autocmd, " "))
	end
	cmd("augroup END")
end

M.print = function(v)
	print(vim.inspect(v))
	return v
end

if pcall(require, "plenary") then
	RELOAD = require("plenary.reload").reload_module

	M.reload = function(name)
		RELOAD(name)
		return require(name)
	end
end

return M
