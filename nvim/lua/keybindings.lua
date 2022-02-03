vim.keymap.set("n", "<space>", "<nop>")
vim.g.leader = " "
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w", ":w!<cr>")
vim.keymap.set("n", "<leader>,", ":noh<cr>")

vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", ":", ";")

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set("n", "<c-j>", "<c-w><c-j>")
vim.keymap.set("n", "<c-k>", "<c-w><c-k>")
vim.keymap.set("n", "<c-l>", "<c-w><c-l>")
vim.keymap.set("n", "<c-h>", "<c-w><c-h>")

vim.keymap.set("n", "<tab>", "%")

-- Go to start or end of line easier
vim.keymap.set("n", "H", "^")
vim.keymap.set("x", "H", "^")
vim.keymap.set("n", "L", "g_")
vim.keymap.set("x", "L", "g_")

vim.keymap.set("n", "<c-up>", ":resize +2<cr>")
vim.keymap.set("n", "<c-down>", ":resize -2<cr>")
vim.keymap.set("n", "<c-left>", ":vertical resize -2<cr>")
vim.keymap.set("n", "<c-right>", ":vertical resize +2<cr>")

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://goo.gl/m1UeiT
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("v", "<A-j>", ":m .+1<cr>==")
vim.keymap.set("v", "<A-k>", ":m .-2<cr>==")
vim.keymap.set("v", "p", '"_dP')
--
-- Visual Block --
-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

vim.keymap.set("n", "<leader><tab>", ":b#<cr>")

vim.keymap.set("n", "<leader>so", ":luafile ~/.config/nvim/init.lua<cr>")
vim.keymap.set("n", "<leader>pi", ":PackerInstall<cr>")
vim.keymap.set("n", "<leader>pu", ":PackerSync<cr>")

-- zen mode
vim.keymap.set("n", "<leader>zm", ":ZenMode<cr>")

_G.stop_clients = function()
    vim.lsp.stop_client(vim.lsp.get_active_clients())
end
vim.keymap.set("n", "<leader>ll", "v:lua.stop_clients()", { expr = true })

vim.keymap.set("n", "<leader>j", ":cnext<cr>")
vim.keymap.set("n", "<leader>k", ":cprev<cr>")
vim.keymap.set("n", "<leader>cc", ":copen<cr>")
vim.keymap.set("n", "<leader>cq", ":cclose<cr>")

vim.keymap.set("n", "<leader>to", ":ToggleTerm<cr>")

vim.keymap.set("n", "<leader>tl", ":set list!<cr>")
