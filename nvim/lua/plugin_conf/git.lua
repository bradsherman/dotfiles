local map = require("utils").map

require("octo").setup()

-- Fugitive
map("n", "<leader>gs", ":G<cr>", { silent = true, noremap = true })
map("n", "<leader>gpp", ":Git push origin ")
map("n", "<leader>gpu", ":Git pull origin ")

-- Telescope
map("n", "<leader>gc", ":Telescope git_branches<cr>", { silent = true, noremap = true })

-- Neogit
map("n", "<leader>gg", ":Neogit<cr>", { silent = true, noremap = true })

-- Blamer
vim.g.blamer_enabled = 1
vim.g.blamer_date_format = "%m/%d/%y"
vim.g.blamer_relative_time = 1
vim.g.blamer_show_in_visual_modes = 0
vim.g.blamer_prefix = " > "
