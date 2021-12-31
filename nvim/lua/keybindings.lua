local map = require("utils").map

local opts = { noremap = true, silent = true }

map("n", "<space>", "<nop>", opts)
vim.g.leader = " "
vim.g.mapleader = " "

map("n", "<leader>w", ":w!<cr>")
map("n", "<leader>,", ":noh<cr>")

map("i", "jk", "<esc>")
map("n", ";", ":")
map("n", ":", ";")

map("n", "j", "gj")
map("n", "k", "gk")

map("n", "<c-j>", "<c-w><c-j>")
map("n", "<c-k>", "<c-w><c-k>")
map("n", "<c-l>", "<c-w><c-l>")
map("n", "<c-h>", "<c-w><c-h>")

map("n", "<tab>", "%")

-- Go to start or end of line easier
map("n", "H", "^")
map("x", "H", "^")
map("n", "L", "g_")
map("x", "L", "g_")

map("n", "<c-up>", ":resize +2<cr>", opts)
map("n", "<c-down>", ":resize -2<cr>", opts)
map("n", "<c-left>", ":vertical resize -2<cr>", opts)
map("n", "<c-right>", ":vertical resize +2<cr>", opts)

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://goo.gl/m1UeiT
map("v", "<", "<gv")
map("v", ">", ">gv")

map("v", "<A-j>", ":m .+1<cr>==", opts)
map("v", "<A-k>", ":m .-2<cr>==", opts)
map("v", "p", '"_dP', opts)
--
-- Visual Block --
-- Move text up and down
map("x", "J", ":move '>+1<CR>gv-gv", opts)
map("x", "K", ":move '<-2<CR>gv-gv", opts)
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

map("n", "<leader><tab>", ":b#<cr>")

map("n", "<leader>so", ":luafile ~/.config/nvim/init.lua<cr>", opts)
map("n", "<leader>pi", ":PackerInstall<cr>", opts)
map("n", "<leader>pu", ":PackerSync<cr>", opts)

-- zen mode
map("n", "<leader>zm", ":ZenMode<cr>", opts)

_G.stop_clients = function()
	vim.lsp.stop_client(vim.lsp.get_active_clients())
end
map("n", "<leader>ll", "v:lua.stop_clients()", { expr = true })

map("n", "<leader>j", ":cnext<cr>", opts)
map("n", "<leader>k", ":cprev<cr>", opts)
map("n", "<leader>cc", ":copen<cr>", opts)
map("n", "<leader>cq", ":cclose<cr>", opts)

map("n", "<leader>to", ":ToggleTerm<cr>", opts)
