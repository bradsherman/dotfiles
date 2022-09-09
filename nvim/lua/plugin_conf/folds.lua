local prev_status_ok, fold_preview = pcall(require, "fold-preview")
if not prev_status_ok then
    fold_preview.setup({
        default_keybindings = false,
        -- "none" | "single" | "double" | "rounded" | "solid" | "shadow" | string[]
        -- default: { ' ', '', ' ', ' ', ' ', ' ', ' ', ' ' }
        border = "rounded",
    })

    local keymap = vim.keymap
    keymap.amend = require("keymap-amend")
    local map = fold_preview.mapping
    keymap.amend("n", "h", map.show_clow_preview_open_fold)
    keymap.amend("n", "l", map.close_preview_open_fold)
end

local status_ok, pretty_fold = pcall(require, "pretty-fold")
if status_ok then
    pretty_fold.setup({
        sections = {
            left = {
                "content",
            },
            right = {
                " ",
                "number_of_folded_lines",
                ": ",
                "percentage",
                " ",
                function(config)
                    return config.fill_char:rep(3)
                end,
            },
        },
        fill_char = "•",

        remove_fold_markers = true,

        -- Keep the indentation of the content of the fold string.
        keep_indentation = true,

        -- Possible values:
        -- "delete" : Delete all comment signs from the fold string.
        -- "spaces" : Replace all comment signs with equal number of spaces.
        -- false    : Do nothing with comment signs.
        process_comment_signs = "spaces",

        -- Comment signs additional to the value of `&commentstring` option.
        comment_signs = {},

        -- List of patterns that will be removed from content foldtext section.
        stop_words = {
            "@brief%s*", -- (for C++) Remove '@brief' and all spaces after.
        },

        add_close_pattern = true, -- true, 'last_line' or false

        matchup_patterns = {
            { "{", "}" },
            { "%(", ")" }, -- % to escape lua pattern char
            { "%[", "]" }, -- % to escape lua pattern char
        },

        ft_ignore = { "neorg" },
    })
end
