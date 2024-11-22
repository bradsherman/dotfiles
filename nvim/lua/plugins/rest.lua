return {
    {
        "vhyrro/luarocks.nvim",
        priority = 3000,
        opts = {
            "lua-utils",
        },
    },
    {
        "rest-nvim/rest.nvim",
        -- ft = "http",
        enabled = false,
        dependencies = { "luarocks.nvim" },
        lazy = false,
        config = function()
            require("rest-nvim").setup()
        end,
        keys = {
            { "<leader>rr", "<cmd>Rest run<cr>", desc = "Run REST request" },
        },
    },
}
