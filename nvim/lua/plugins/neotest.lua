return {
    { "mrcjkb/neotest-haskell" },
    "jfpedroza/neotest-elixir",
    {
        "nvim-neotest/neotest",
        dependencies = {
            "folke/neodev.nvim",
            "mrcjkb/neotest-haskell",
            "jfpedroza/neotest-elixir",
            "nvim-neotest/nvim-nio",
            "antoinemadec/FixCursorHold.nvim",
            "nvim-treesitter/nvim-treesitter",
            "nvim-lua/plenary.nvim",
            "stevearc/overseer.nvim",
        },
        config = function()
            require("neotest").setup({
                adapters = {
                    require("neotest-haskell"),
                    require("neotest-elixir"),
                    require("rustaceanvim.neotest"),
                },
                -- consumers = {
                --     overseer = require("neotest.consumers.overseer"),
                -- },
            })
        end,
    },
}
