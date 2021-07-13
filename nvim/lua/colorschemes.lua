vim.opt.background = 'light'
-- not sure if this is correct, but colors seem to work
if vim.opt.termguicolors
then
	vim.opt.termguicolors = true
end
vim.cmd('colorscheme NeoSolarized')
vim.g.neosolarized_contrast = 'high'

