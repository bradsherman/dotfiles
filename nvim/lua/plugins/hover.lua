return {
    {
        "lewis6991/hover.nvim",
        config = function()
            require("hover").config({
                providers = {
                    "hover.providers.diagnostic",
                    -- "hover.providers.lsp",
                    {
                        module = "hover.providers.lsp",
                        priority = 2000,
                        name = "LSP",
                    },
                    "hover.providers.dap",
                    "hover.providers.man",
                    -- "hover.providers.dictionary",
                    -- Optional, disabled by default:
                    -- 'hover.providers.gh',
                    -- 'hover.providers.gh_user',
                    -- 'hover.providers.jira',
                    -- 'hover.providers.fold_preview',
                    -- 'hover.providers.highlight',

                    -- -- Require providers
                    -- require("hover.providers.diagnostic")
                    -- require("hover.providers.lsp")
                    -- require("hover.providers.fold_preview")
                    -- require("hover.providers.gh")
                    -- -- require('hover.providers.gh_user')
                    -- -- require('hover.providers.jira')
                    -- require("hover.providers.man")
                    -- -- require('hover.providers.dictionary')
                },
                preview_opts = {
                    border = "single",
                },
                -- Whether the contents of a currently open hover window should be moved
                -- to a :h preview-window when pressing the hover keymap.
                preview_window = false,
                title = true,
                mouse_providers = {
                    "LSP",
                },
                mouse_delay = 1000,
            })

            -- Setup keymaps
            vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
            vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })

            -- Mouse support
            -- vim.keymap.set("n", "<MouseMove>", require("hover").hover_mouse, { desc = "hover.nvim (mouse)" })
            -- vim.o.mousemoveevent = true
        end,
    },
}
