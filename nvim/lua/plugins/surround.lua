return {
    "kylechui/nvim-surround",
    -- event = "VeryLazy",
    tag = "v2.1.6",
    config = function(_, opts)
        require("nvim-surround").setup(opts)
    end,
}
