return {
    "tpope/vim-fugitive",
    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
        "FabijanZulj/blame.nvim",
        config = function()
            require("blame").setup()
        end,
    },
}
