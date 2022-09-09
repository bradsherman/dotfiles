local status_ok, moonlight = pcall(require, "moonlight")
if not status_ok then
    return
end

vim.g.moonlight_italic_comments = true
vim.g.moonlight_italic_keywords = true
vim.g.moonlight_italic_functions = true
vim.g.moonlight_italic_variables = false
vim.g.moonlight_contrast = true
vim.g.moonlight_borders = false
vim.g.moonlight_disable_background = false

-- Load the colorscheme
moonlight.set()
