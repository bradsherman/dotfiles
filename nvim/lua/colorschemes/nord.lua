local status_ok, nord = pcall(require, "nord")
if not status_ok then
    return
end

vim.g.nord_contrast = true
vim.g.nord_borders = true
vim.g.nord_disable_background = false
vim.g.nord_cursorline_transparent = false
vim.g.nord_enable_sidebar_background = true
vim.g.nord_italic = true
vim.g.nord_uniform_diff_background = true
vim.g.nord_bold = true

-- Load the colorscheme
require("nord").set()

-- Load the colorscheme
nord.set()
