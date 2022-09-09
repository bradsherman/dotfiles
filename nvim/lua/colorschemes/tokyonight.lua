local status_ok, _ = pcall(require, "tokyonight")
if not status_ok then
    return
end

vim.g.tokyonight_style = "storm" -- "storm", night" or "day"
vim.g.tokyonight_day_brightness = 0.3
vim.g.tokyonight_transparent = false
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_hide_inactive_statusline = false
vim.g.tokyonight_terminal_colors = true
vim.g.tokyonight_sidebars = {}
vim.g.tokyonight_colors = {}
vim.g.tokyonight_dev = false
vim.g.tokyonight_dark_float = true
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_transparent_sidebar = true
vim.g.tokyonight_transform_colors = false
vim.g.tokyonight_lualine_bold = false
