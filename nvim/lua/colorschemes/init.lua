vim.opt.background = "dark"
vim.opt.termguicolors = true

local cs = "kanagawa"

require("colorschemes." .. cs)

vim.cmd("colorscheme " .. cs)
