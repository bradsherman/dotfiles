vim.opt.background = "dark"
vim.opt.termguicolors = true

local cs = "onenord"

require("colorschemes." .. cs)

vim.cmd("colorscheme " .. cs)
