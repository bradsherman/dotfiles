return {
    "olimorris/codecompanion.nvim",
    enabled = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- "ravitemer/mcphub.nvim",
    },
    config = true,
    opts = {
        strategies = {
            chat = {
                adapter = "claude_code",
                -- tools = {
                --     ["mcp"] = {
                --         -- calling it in a function would prevent mcphub from being loaded before it's needed
                --         callback = function()
                --             return require("mcphub.extensions.codecompanion")
                --         end,
                --         description = "Call tools and resources from the MCP Servers",
                --     },
                -- },
            },
            inline = {
                adapter = "claude_code",
            },
        },
        adapters = {
            acp = {
                claude_code = function()
                    return require("codecompanion.adapters").extend("claude_code", {
                        env = {
                            CLAUDE_CODE_OAUTH_TOKEN = 'cmd:op item get "Anthropic API KEY - Personal" --fields "notesPlain"',
                        },
                    })
                end,
            },
            -- http = {
            --     anthropic = function()
            --         return require("codecompanion.adapters").extend("anthropic", {
            --             env = { api_key = 'cmd:op item get "Anthropic API KEY - Personal" --fields "notesPlain"' },
            --         })
            --     end,
            -- },
        },
    },
}
