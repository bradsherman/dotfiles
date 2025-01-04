return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = true,
    opts = {
        strategies = {
            chat = {
                adapter = "anthropic",
            },
            inline = {
                adapter = "anthropic",
            },
        },
        adapters = {
            anthropic = function()
                return require("codecompanion.adapters").extend("anthropic", {
                    env = {
                        api_key = 'cmd:op item get "Anthropic API KEY - Personal" --fields "notesPlain"',
                    },
                })
            end,
        },
    },
}
