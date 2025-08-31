return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        enabled = true,
        event = "VeryLazy",
        priority = 10000,
        config = function()
            require("tiny-inline-diagnostic").setup({
                preset = "modern",
                options = {
                    show_all_diags_on_cursorline = true,
                },
            })
        end,
    },
}
