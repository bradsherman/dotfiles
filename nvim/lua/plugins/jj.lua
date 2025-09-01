return {
    "nicolasgb/jj.nvim",
    -- "bradsherman/jj.nvim",
    -- branch = "push-rvrkxyyzrynl",
    -- "jj.nvim",
    -- dir = "/home/bsherman/code/jj.nvim",
    config = function()
        require("jj").setup({})
        local cmd = require("jj.cmd")
        vim.keymap.set("n", "<leader>jd", cmd.describe, { desc = "JJ describe" })
        vim.keymap.set("n", "<leader>jl", cmd.log, { desc = "JJ log" })
        vim.keymap.set("n", "<leader>je", cmd.edit, { desc = "JJ edit" })
        vim.keymap.set("n", "<leader>jn", cmd.new, { desc = "JJ new" })
        vim.keymap.set("n", "<leader>js", cmd.status, { desc = "JJ status" })
        vim.keymap.set("n", "<leader>dj", cmd.diff, { desc = "JJ diff" })
        vim.keymap.set("n", "<leader>sj", cmd.squash, { desc = "JJ squash" })
        vim.keymap.set("n", "<leader>gj", function()
            require("jj.picker").status()
        end, { desc = "JJ Picker status" })

        -- Some functions like `describe` or `log` can take parameters
        vim.keymap.set("n", "<leader>jl", function()
            cmd.log({
                revisions = "all()",
            })
        end, { desc = "JJ log" })

        -- This is an alias i use for moving bookmarks its so good
        vim.keymap.set("n", "<leader>jt", function()
            cmd.j("tug")
            cmd.log({})
        end, { desc = "JJ tug" })
    end,
}
