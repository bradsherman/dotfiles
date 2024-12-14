return {
    {
        "nvim-neorg/neorg",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        version = "*",
        lazy = false,
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
                    -- ["core.completion"] = {
                    --     config = {
                    --         engine = "nvim-cmp",
                    --         name = "[Neorg]",
                    --     },
                    -- },
                    ["core.completion"] = {
                        config = { engine = { module_name = "external.lsp-completion" } },
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
                    ["core.summary"] = {},
                    ["core.ui.calendar"] = {},
                    ["core.integrations.telescope"] = {},
                    ["core.integrations.treesitter"] = {},
                    ["external.interim-ls"] = {
                        config = {
                            -- default config shown
                            completion_provider = {
                                -- enable/disable the completion provider. On by default.
                                enable = true,

                                -- show file contents as documentation when you complete a file name
                                documentation = true,

                                -- Try to complete categories. Requires benlubas/neorg-se
                                categories = false,
                            },
                        },
                    },
                },
            })

            vim.wo.foldlevel = 99
            vim.wo.conceallevel = 2
        end,
    },
}
