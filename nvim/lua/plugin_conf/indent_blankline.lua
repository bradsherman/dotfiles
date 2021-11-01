vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_show_first_indent_level = false

-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#eee8d5 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#2aa198 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#268bd2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#d33682 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#cb4b16 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#dc322f gui=nocombine]]

require("indent_blankline").setup {
    char = "┆",
    buftype_exclude = {"terminal"},
    space_char_blankline = " ",
    use_treesitter = true,
    show_current_context = true,
}


-- alternating bg shade
-- vim.cmd [[highlight IndentBlanklineIndent1 guibg=#fdf6e3 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guibg=#eee8d5 gui=nocombine]]
-- require("indent_blankline").setup {
--     buftype_exclude = {"terminal"},
--     space_char_blankline = " ",
--     show_current_context = true,
--     char = " ",
--     char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--     },
--     space_char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--     },
--     show_trailing_blankline_indent = false,
-- }

