require("neorg").setup({
        load = {
            ["core.defaults"] = {}, -- Loads default behaviour
            ["core.concealer"] = {
                config = {
                    icon_preset = "diamond",
                },
            }, -- Adds pretty icons to your documents
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp",
                },
            },
            ["core.dirman"] = { -- Manages Neorg workspaces
                config = {
                    workspaces = {
                        home = "~/neorg/home",
                        work = "~/neorg/work",
                    },
                    default_workspace = "work",
                },
            },
            ["core.journal"] = {},
            ["core.summary"] = {},
            ["core.ui.calendar"] = {},
            --["core.integrations.telescope"] = {},
            ["core.integrations.treesitter"] = {},
        },
})
