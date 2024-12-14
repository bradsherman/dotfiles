return {
    "kylechui/nvim-surround",
    enabled = false,
    -- event = "VeryLazy",
    tag = "v2.1.6",
    config = function(_, opts)
        require("nvim-surround").setup(opts)
    end,
}
