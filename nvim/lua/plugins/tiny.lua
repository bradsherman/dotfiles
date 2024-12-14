return {
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        -- enabled = false,
        event = "VeryLazy",
        priority = 10000,
        config = function()
            require("tiny-inline-diagnostic").setup({
                options = {
                    show_all_diags_on_cursorline = true,
                },
            })
        end,
    },
}
