vim.g.leader = " "
vim.g.mapleader = " "
vim.g.localleader = ","
vim.g.maplocalleader = ","

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "+", "<C-a>")
keymap.set("n", "_", "<C-x>")

keymap.set("n", "<C-a>", "gg<S-v>G")

keymap.set("n", "<leader>w", ":w<cr>", opts)
keymap.set("n", "<leader>x", ":q<cr>", opts)
keymap.set("n", "<leader>,", "<cmd>noh<cr>", opts)
-- keymap.set("n", "<leader>,", "<cmd>nohlsearch|diffupdate|normal! <C-l><cr>")

keymap.set("n", "te", ":tabedit", opts)
keymap.set("n", "<tab>", ":tabnext<cr>", opts)
keymap.set("n", "<s-tab>", ":tabprev<cr>", opts)
keymap.set("n", "tw", ":tabclose<cr>", opts)

keymap.set("n", "ss", ":split<cr>", opts)
keymap.set("n", "sv", ":vsplit<cr>", opts)

keymap.set("i", "jk", "<esc>")
-- keymap.set("v", "jk", "<esc>")
keymap.set("n", ";", ":")
keymap.set("n", ":", ";")

keymap.set("n", "j", "gj")
keymap.set("n", "k", "gk")

keymap.set("n", "gf", "gF", { silent = true })

keymap.set("n", "<c-j>", "<c-w><c-j>")
keymap.set("n", "<c-k>", "<c-w><c-k>")
keymap.set("n", "<c-l>", "<c-w><c-l>")
keymap.set("n", "<c-h>", "<c-w><c-h>")

-- keymap.set("n", "<tab>", "%")

-- Go to start or end of line easier
keymap.set("n", "H", "^")
keymap.set("x", "H", "^")
keymap.set("n", "L", "g_")
keymap.set("x", "L", "g_")

keymap.set("n", "<c-up>", ":resize +2<cr>")
keymap.set("n", "<c-down>", ":resize -2<cr>")
keymap.set("n", "<c-left>", ":vertical resize -2<cr>")
keymap.set("n", "<c-right>", ":vertical resize +2<cr>")

-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://goo.gl/m1UeiT
keymap.set("v", "<", "<gv")
keymap.set("v", ">", ">gv")

keymap.set("v", "<A-j>", ":m .+1<cr>==")
keymap.set("v", "<A-k>", ":m .-2<cr>==")
keymap.set("v", "p", '"_dP')

keymap.set("n", "<A-o>", "O<esc>")
keymap.set("n", "<A-n>", "$a<cr><esc>")

-- Visual Block --
-- Move text up and down
keymap.set("x", "J", ":move '>+1<CR>gv-gv")
keymap.set("x", "K", ":move '<-2<CR>gv-gv")
keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv")
keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- copy line and comment out original
keymap.set("n", "ycc", "yygccp", { remap = true })

-- keep line in place when joining lines
keymap.set("n", "J", "mzJ`z:delmarks z<cr>")
