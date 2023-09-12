local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

-- TODO: pass func here for theme
lualine.setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = {
            statusline = { "packer", "alpha", "dashboard", "NVimTree", "NeoTree", "Outline" },
            winbar = { "packer", "alpha", "dashboard", "NVimTree", "NeoTree", "Outline" },
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true,
    },
    extensions = { "fzf", "fugitive", "neo-tree", "nvim-dap-ui", "toggleterm", "nvim-tree", "quickfix" },
    sections = {
        lualine_a = {},
        lualine_b = {
            { "branch", cond = hide_in_width },
            {
                "diff",
                colored = true, -- displays diff status in color if set to true
                -- symbols = { added = "+", modified = "~", removed = "-" }, -- changes diff symbols
                symbols = { added = " ", modified = " ", removed = " " },
                cond = hide_in_width,
            },
        },
        lualine_c = {
            {
                "diagnostics",
                -- color = {bg='#eee8d5'},
                sources = { "nvim_diagnostic" },
                sections = { "error", "warn", "info", "hint" },
                always_visible = true,
                colored = true,
                -- symbols = { error = "❌ ", warn = "⚠️  ", info = "ℹ️  ", hint = "💡 " },
                symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
            function()
                return "%="
            end,
            { "filename", file_status = true, path = 0 },
        },
        lualine_x = { { "filetype", colored = true } },
        lualine_y = { "location" },
        lualine_z = { "mode", "progress" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
})
