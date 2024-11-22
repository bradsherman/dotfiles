return {
    "romgrk/barbar.nvim",
    enabled = false,
    dependencies = {
        "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
        "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
    },
    init = function()
        vim.g.barbar_auto_setup = false
        vim.api.nvim_set_hl(0, "BufferCurrent", { bg = "#181616" })
        vim.api.nvim_set_hl(0, "BufferVisible", { bg = "#181616" })
        vim.api.nvim_set_hl(0, "BufferAlternate", { bg = "#181616" })
        vim.api.nvim_set_hl(0, "BufferInactive", { bg = "#181616" })
        vim.api.nvim_set_hl(0, "BufferInactiveSign", { bg = "#181616" })
    end,
    config = function(_, opts)
        require("barbar").setup(opts)
        vim.api.nvim_set_hl(0, "BufferCurrent", { bg = "#181616" })
        vim.api.nvim_set_hl(0, "BufferVisible", { bg = "#181616" })
        vim.api.nvim_set_hl(0, "BufferAlternate", { bg = "#181616" })
        vim.api.nvim_set_hl(0, "BufferInactive", { bg = "#181616" })
        vim.api.nvim_set_hl(0, "BufferInactiveSign", { bg = "#181616" })
    end,
    opts = {
        -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
        -- animation = true,
        -- insert_at_start = true,
        -- …etc.
        auto_hide = 1,
    },
    version = "^1.0.0", -- optional: only update when a new 1.x version is released
}
