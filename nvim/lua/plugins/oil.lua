return {
    "stevearc/oil.nvim",
    lazy = false,
    keys = {
        { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
        { "<c-e>", "<cmd>Oil<cr>", desc = "Open parent directory" },
        { "<leader>e", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
        -- Skip the confirmation popup for simple operations
        skip_confirm_for_simple_edits = true,
        -- Selecting a new/moved/renamed file or directory will prompt you to save changes first
        prompt_save_on_select_new_entry = true,
        -- Keymaps in oil buffer. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", mode = "n" })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("oil.actions").<name>
        -- Set to `false` to remove a keymap
        -- See :help oil-actions for a list of all available actions
        keymaps = {
            ["l"] = "actions.select",

            ["<C-s>"] = false,
            ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },

            ["<C-h>"] = {
                "actions.select",
                opts = { horizontal = true },
                desc = "Open the entry in a horizontal split",
            },
            ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },

            ["<C-l>"] = false,
            ["<C-r>"] = "actions.refresh",

            ["h"] = "actions.parent",
        },
        view_options = {
            -- Show files and directories that start with "."
            show_hidden = true,
            -- This function defines what will never be shown, even when `show_hidden` is set
            is_always_hidden = function(name, bufnr)
                return vim.endswith(name, ".hie") or name == ".." or name == ".git"
            end,
        },
    },
}
