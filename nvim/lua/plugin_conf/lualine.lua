local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

local hide_in_width = function()
    return vim.fn.winwidth(0) > 80
end

lualine.setup({
    options = {
        -- theme = "zenbones",
        theme = "nightfox",
        -- theme = "solarized_light",
        -- theme = "tokyonight",
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        disabled_filetypes = { "packer", "alpha", "dashboard", "NvimTree", "Outline" },
        always_divide_middle = true,
    },
    extensions = { "fzf", "fugitive", "nvim-tree", "quickfix" },
    sections = {
        lualine_a = {},
        lualine_b = {
            { "branch", cond = hide_in_width },
            {
                "diff",
                colored = true, -- displays diff status in color if set to true
                -- symbols = { added = "+", modified = "~", removed = "-" }, -- changes diff symbols
                symbols = { added = " ", modified = "柳 ", removed = " " },
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
