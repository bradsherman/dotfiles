vim.g.leader = " "
vim.g.mapleader = " "
vim.g.localleader = ","
vim.g.maplocalleader = ","

vim.keymap.set("n", "<leader>w", ":w<cr>")
vim.keymap.set("n", "<leader>,", "<cmd>noh<cr>")
-- vim.keymap.set("n", "<leader>,", "<cmd>nohlsearch|diffupdate|normal! <C-l><cr>")

vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", ":", ";")

vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

vim.keymap.set("n", "gf", "gF", { silent = true })

vim.keymap.set("n", "<leader>o", "o<esc>k")
vim.keymap.set("n", "<leader>O", "O<esc>j")

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

vim.keymap.set("n", "<A-o>", "O<esc>")
vim.keymap.set("n", "<A-n>", "$a<cr><esc>")

-- Visual Block --
-- Move text up and down
vim.keymap.set("x", "J", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "K", ":move '<-2<CR>gv-gv")
vim.keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
vim.keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- vim-cutlass
-- vim.keymap.set("n", "x", "d")
-- vim.keymap.set("x", "x", "d")
-- vim.keymap.set("n", "xx", "dd")
-- vim.keymap.set("n", "X", "D")

-- omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
-- vnoremap <silent> m :lua require('tsht').nodes()<CR>
-- vim.keymap.set("o", "m", ":<C-U>lua require('tsht').nodes()<cr>", { silent = true, remap = true })
-- vim.keymap.set("v", "m", ":lua require('tsht').nodes()<cr>", { silent = true })
