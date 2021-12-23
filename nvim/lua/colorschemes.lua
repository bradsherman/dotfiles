vim.opt.background = "light"
-- not sure if this is correct, but colors seem to work
if vim.opt.termguicolors then
	vim.opt.termguicolors = true
end

-- To enable transparency
if vim.fn.has("gui_running") == 0 then
	vim.g.solarized_termtrans = 0
else
	vim.g.solarized_termtrans = 1
end
vim.g.solarized_italics = 1
vim.g.solarized_visbility = "normal"
vim.cmd("colorscheme solarized-flat")

-- vim.cmd("colorscheme zenbones")
-- vim.cmd("colorscheme tokyonight")

-- local nightfox = require("nightfox")

-- nightfox.setup({
-- 	fox = "dawnfox", -- change the colorscheme to use nordfox
-- 	alt_nc = false,
-- 	styles = {
-- 		comments = "italic", -- change style of comments to be italic
-- 		keywords = "bold", -- change style of keywords to be bold
-- 		functions = "italic,bold", -- styles can be a comma separated list
-- 	},
-- 	inverse = {
-- 		match_paren = true, -- inverse the highlighting of match_parens
-- 	},
-- 	colors = {
-- 		red = "#FF000", -- Override the red color for MAX POWER
-- 		bg_alt = "#000000",
-- 	},
-- 	hlgroups = {
-- 		TSPunctDelimiter = { fg = "${red}" }, -- Override a highlight group with the color red
-- 		LspCodeLens = { bg = "#000000", style = "italic" },
-- 	},
-- })
--
-- -- Load the configuration set above and apply the colorscheme
-- nightfox.load()
