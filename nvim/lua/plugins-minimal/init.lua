return {
    {
        "sindrets/diffview.nvim",
        opts = {
            -- enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
            use_icons = false,
            file_panel = {
                win_config = {
                    type = "split",
                    posiiton = "right",
                    width = 50,
                },
            },
            -- view = {
            --     default = {
            --         winbar_info = true,
            --     },
            --     merge_tool = {
            --         layout = "diff3_mixed",
            --     },
            -- },
            -- default_args = { -- Default args prepended to the arg-list for the listed commands
            --     DiffviewOpen = { "--imply-local" },
            --     DiffviewFileHistory = {},
            -- },
        },
    },
}
