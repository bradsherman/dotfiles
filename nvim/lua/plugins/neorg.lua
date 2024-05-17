return {
    {
        "nvim-neorg/neorg",
        dependencies = { "luarocks.nvim", "nvim-tree/nvim-web-devicons" },
        version = "*",
        config = function()
            require("neorg").setup({
                load = {
                    ["core.defaults"] = {
                        config = {
                            disable = { "core.todo-introspector" },
                        },
                    }, -- Loads default behaviour
                    ["core.concealer"] = {
                        config = {
                            icon_preset = "basic",
                        },
                    }, -- Adds pretty icons to your documents
                    ["core.completion"] = {
                        config = {
                            engine = "nvim-cmp",
                            name = "[Neorg]",
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
                    ["core.esupports.metagen"] = {
                        config = {
                            author = "Brad Sherman",
                            type = "empty",
                        },
                    },
                    ["core.journal"] = {},
                    ["core.mode"] = {},
                    ["core.summary"] = {},
                    ["core.ui.calendar"] = {},
                    ["core.integrations.telescope"] = {},
                    ["core.integrations.treesitter"] = {},
                },
            })

            vim.wo.foldlevel = 99
            vim.wo.conceallevel = 2
        end,
    },
}
