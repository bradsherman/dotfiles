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
        timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
    },
}
