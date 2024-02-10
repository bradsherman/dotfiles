return {
    "NeogitOrg/neogit",
    opts = {
        disable_hint = true,
        disable_context_highlighting = false,
        disable_signs = false,
        graph_style = "unicode",
        disable_commit_confirmation = true,
        -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
        -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
        auto_refresh = true,
        disable_builtin_notifications = true,
        use_magit_keybindings = false,
        console_timeout = 3000,
        auto_show_console = false,
        -- Change the default way of opening neogit
        kind = "tab",
        -- Change the default way of opening the commit popup
        commit_popup = {
            kind = "split_above",
        },
        -- Change the default way of opening popups
        popup = {
            kind = "split_above",
        },
        -- customize displayed signs
        signs = {
            -- { CLOSED, OPENED }
            -- section = { ">", "v" },
            -- item = { ">", "v" },
            -- hunk = { "", "" },
            section = { " ", " " },
            item = { " ", " " },
            hunk = { "", "" },
        },
        integrations = {
            -- If enabled, use telescope for menu selection rather than vim.ui.select.
            -- Allows multi-select and some things that vim.ui.select doesn't.
            telescope = false,
            -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
            -- The diffview integration enables the diff popup, which is a wrapper around `sindrets/diffview.nvim`.
            --
            -- Requires you to have `sindrets/diffview.nvim` installed.
            -- use {
            --   'TimUntersberger/neogit',
            --   requires = {
            --     'nvim-lua/plenary.nvim',
            --     'sindrets/diffview.nvim'
            --   }
            -- }
            --
            diffview = true,
        },
        sections = {
            sequencer = {
                folded = true,
                hidden = false,
            },
            untracked = {
                folded = false,
                hidden = false,
            },
            unstaged = {
                folded = false,
                hidden = false,
            },
            staged = {
                folded = false,
                hidden = false,
            },
            stashes = {
                folded = true,
                hidden = false,
            },
            unpulled_upstream = {
                folded = true,
                hidden = false,
            },
            unmerged_upstream = {
                folded = true,
                hidden = false,
            },
            unpulled_pushRemote = {
                folded = true,
                hidden = false,
            },
            unmerged_pushRemote = {
                folded = true,
                hidden = false,
            },
            recent = {
                folded = false,
                hidden = false,
            },
            rebase = {
                folded = true,
                hidden = false,
            },
        },
    },
}
