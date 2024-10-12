return {
    "rcarriga/nvim-notify",
    config = function(_, opts)
        local notify = require("notify")
        notify.setup(opts)

        vim.keymap.set("n", "<leader>nc", function()
            notify.dismiss({ pending = true })
        end)
        vim.notify = notify
    end,
    opts = {
        render = "default",
        stages = "fade_in_slide_out",
        top_down = false,
        -- timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.20)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.25)
        end,
    },
}
