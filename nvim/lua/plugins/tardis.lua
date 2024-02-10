return {
    "FredeEB/tardis.nvim",
    opts = {
        keymap = {
            next = "<C-j>", -- next entry in log (older)
            prev = "<C-k>", -- previous entry in log (newer)
            quit = "q", -- quit all
            commit_message = "m", -- show commit message for current commit in buffer
        },
        commits = 32, -- max number of commits to read
    },
}
