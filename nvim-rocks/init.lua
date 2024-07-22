require("options")
require("keybindings")

local rocks_config = {
  rocks_path = vim.env.HOME .. "/.local/share/nvim-rocks/rocks",
	luarocks_binary = "/usr/local/bin/luarocks",
	-- luarocks_binary = "/home/bsherman/.local/share/nvim-rocks/rocks/bin/luarocks",
}

vim.g.rocks_nvim = rocks_config

local luarocks_path = {
	vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?.lua"),
	vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "init.lua"),
	--vim.fs.joinpath(rocks_config.rocks_path, "share", "lua", "5.1", "?", "*.lua"),
}
package.path = package.path .. ";" .. table.concat(luarocks_path, ";")

local luarocks_cpath = {
	vim.fs.joinpath(rocks_config.rocks_path, "lib", "lua", "5.1", "?.so"),
	vim.fs.joinpath(rocks_config.rocks_path, "lib64", "lua", "5.1", "?.so"),
}
package.cpath = package.cpath .. ";" .. table.concat(luarocks_cpath, ";")

vim.opt.runtimepath:append(vim.fs.joinpath(rocks_config.rocks_path, "lib", "luarocks", "rocks-5.1", "rocks.nvim", "*"))

 
-- This is necessary to autoload the colorscheme
-- vim.cmd("packadd kanagawa.nvim")
-- vim.cmd("packadd heirline.nvim")
require("rocks").packadd("kanagawa.nvim")
require("rocks").packadd("heirline.nvim")
