local status_ok, blankline = pcall(require, "indent_blankline")
if not status_ok then
    return
end

-- vim.cmd [[highlight IndentBlanklineIndent1 guifg=#eee8d5 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent2 guifg=#2aa198 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent3 guifg=#268bd2 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent4 guifg=#d33682 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent5 guifg=#cb4b16 gui=nocombine]]
-- vim.cmd [[highlight IndentBlanklineIndent6 guifg=#dc322f gui=nocombine]]

local buftype_excludes = {
    "alpha",
    "terminal",
    "nofile",
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "neo-tree",
    "Trouble",
}

local filetype_excludes = {
    "help",
    "startify",
    "dashboard",
    "packer",
    "neogitstatus",
    "NvimTree",
    "neo-tree",
    "Trouble",
}

local use_ts = true
local show_context = true

vim.g.indent_blankline_buftype_exclude = buftype_excludes
vim.g.indent_blankline_filetype_exclude = filetype_excludes
vim.g.indent_blankline_use_treesitter = use_ts
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = show_context
vim.g.indent_blankline_show_first_indent_level = false

blankline.setup({
    char = "┆",
    buftype_exclude = buftype_excludes,
    space_char_blankline = " ",
    use_treesitter = use_ts,
    show_current_context = show_context,
    show_current_context_start = show_context,
})

-- local nfox_ok, palettes = pcall(require, "nightfox.palette")
-- if not nfox_ok then
--     return
-- end
-- local palette = palettes.load("nordfox")
--
-- -- alternating bg shade
-- vim.cmd("highlight IndentBlanklineIndent1 guibg=" .. palette.bg1 .. " gui=nocombine")
-- vim.cmd("highlight IndentBlanklineIndent2 guibg=" .. palette.bg2 .. " gui=nocombine")
-- blankline.setup({
--     buftype_exclude = buftype_excludes,
--     use_treesitter = use_ts,
--     show_current_context = show_context,
--     char = "",
--     char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--     },
--     space_char_highlight_list = {
--         "IndentBlanklineIndent1",
--         "IndentBlanklineIndent2",
--     },
--     show_trailing_blankline_indent = false,
-- })

local palette = {
    bg0 = "#232831",
    bg1 = "#2e3440",
    bg2 = "#39404f",
    bg3 = "#444c5e",
    bg4 = "#5a657d",
    black = {
        base = "#3b4252",
        bright = "#465780",
        dim = "#353a45",
        light = false,
    },
    blue = {
        base = "#81a1c1",
        bright = "#8cafd2",
        dim = "#668aab",
        light = false,
    },
    comment = "#60728a",
    cyan = {
        base = "#88c0d0",
        bright = "#93ccdc",
        dim = "#69a7ba",
        light = false,
    },
    fg0 = "#c7cdd9",
    fg1 = "#cdcecf",
    fg2 = "#abb1bb",
    fg3 = "#7e8188",
    green = {
        base = "#a3be8c",
        bright = "#b1d196",
        dim = "#8aa872",
        light = false,
    },
    magenta = {
        base = "#b48ead",
        bright = "#c895bf",
        dim = "#9d7495",
        light = false,
    },
    meta = {
        light = false,
        name = "nordfox",
    },
    orange = {
        base = "#c9826b",
        bright = "#d89079",
        dim = "#b46950",
        light = false,
    },
    pink = {
        base = "#bf88bc",
        bright = "#d092ce",
        dim = "#a96ca5",
        light = false,
    },
    red = {
        base = "#bf616a",
        bright = "#d06f79",
        dim = "#a54e56",
        light = false,
    },
    sel0 = "#3e4a5b",
    sel1 = "#4f6074",
    white = {
        base = "#e5e9f0",
        bright = "#e7ecf4",
        dim = "#bbc3d4",
        light = false,
    },
    yellow = {
        base = "#ebcb8b",
        bright = "#f0d399",
    },
}
