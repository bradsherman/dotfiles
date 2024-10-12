return {
    "sindrets/diffview.nvim",
    opts = {
        enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
        file_panel = {
            listing_style = "tree",
            win_config = { -- See |diffview-config-win_config|
                position = "bottom",
                width = 35,
                height = 15,
            },
        },
        view = {
            default = {
                winbar_info = true,
            },
            merge_tool = {
                layout = "diff3_mixed",
            },
        },
        default_args = { -- Default args prepended to the arg-list for the listed commands
            DiffviewOpen = { "--imply-local" },
            DiffviewFileHistory = {},
        },
    },
}
