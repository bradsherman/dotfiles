return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function(_, opts)
        require("snacks").setup(opts)
    end,
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,
            preset = {
                keys = {
                    { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = " ", key = "g", desc = "Neogit", action = ":Neogit" },
                    {
                        icon = " ",
                        key = "r",
                        desc = "Recent Files",
                        action = ":lua Snacks.dashboard.pick('oldfiles')",
                    },
                    {
                        icon = " ",
                        key = "c",
                        desc = "Config",
                        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                    },
                    { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    {
                        icon = "󰒲 ",
                        key = "L",
                        desc = "Lazy",
                        action = ":Lazy",
                        enabled = package.loaded.lazy ~= nil,
                    },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
            sections = {
                { section = "header" },
                { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
                { section = "startup" },
            },
        },
        image = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true },
        picker = {
            enabled = true,
            ui_select = true,
            -- layout = {
            --     box = "vertical",
            --     backdrop = false,
            --     row = -1,
            --     width = 0,
            --     height = 0.4,
            --     border = "top",
            --     title = " {title} {live} {flags}",
            --     title_pos = "left",
            --     { win = "input", height = 1, border = "bottom" },
            --     {
            --         box = "horizontal",
            --         { win = "list", border = "none" },
            --         { win = "preview", title = "{preview}", width = 0.6, border = "left" },
            --     },
            -- },
            -- preset = "ivy",
            layout = { preset = "ivy", position = "bottom" },
        },
        quickfile = { enabled = true },
        words = { enabled = true },
    },
}
