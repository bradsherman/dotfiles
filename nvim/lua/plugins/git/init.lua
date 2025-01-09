return {
    "tpope/vim-fugitive",
    {
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            -- OR 'ibhagwan/fzf-lua',
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            vim.treesitter.language.register("markdown", "octo")
            require("octo").setup({
                use_local_fs = true,
                picker = "fzf-lua",
                suppress_missing_scope = {
                    projects_v2 = true,
                },
                -- kanagawa colors
                colors = { -- used for highlight groups (see Colors section below)
                    white = "#DCD7BA",
                    grey = "#363646",
                    black = "#1F1F28",
                    red = "#E46876",
                    dark_red = "#C34043",
                    green = "#98BB6C",
                    dark_green = "#76946A",
                    yellow = "#E6C384",
                    dark_yellow = "#FF9E3B",
                    blue = "#658594",
                    dark_blue = "#2D4F67",
                    purple = "#938AA9",
                },
            })
        end,
    },
    {
        "petertriho/cmp-git",
        enabled = false,
        dependencies = { "hrsh7th/nvim-cmp" },
        opts = {
            -- options go here
        },
        init = function()
            table.insert(require("cmp").get_config().sources, { name = "git" })
        end,
    },
}
