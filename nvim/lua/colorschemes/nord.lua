local status_ok, nord = pcall(require, "nord")
if not status_ok then
    return
end

vim.g.nord_contrast = true
vim.g.nord_borders = false
vim.g.nord_disable_background = false
vim.g.nord_italic = true
vim.g.nord_uniform_diff_background = true

-- Load the colorscheme
nord.set()
