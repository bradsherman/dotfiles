vim.g.mapleader = " "
vim.g.maplocalleader = ","

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", { desc = "Toggle Markdown preview" })

keymap.set("n", "+", "<C-a>")
keymap.set("n", "_", "<C-x>")

keymap.set("n", "<C-a>", "gg<S-v>G")

keymap.set("n", "<leader>w", ":w<cr>", { noremap = true, silent = true, desc = "Write buffer" })
keymap.set("n", "<leader>x", ":q<cr>", { noremap = true, silent = true, desc = "Quit window" })
keymap.set("n", "<leader>,", "<cmd>noh<cr>", { noremap = true, silent = true, desc = "Clear search highlight" })

-- Open the Neojj (Jujutsu) UI.
keymap.set("n", "<leader>jj", "<cmd>Neojj<cr>", { noremap = true, silent = true, desc = "Open Neojj UI" })

-- Format current buffer via conform (falls back to LSP formatting).
keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })

-- Toggle LSP inlay hints for the current buffer.
keymap.set("n", "<leader>th", function()
	local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
	vim.lsp.inlay_hint.enable(not enabled, { bufnr = 0 })
end, { desc = "Toggle inlay hints" })

-- Update all plugins that vim.pack manages. This opens a confirmation buffer
-- in a new tabpage. Read the pending changes there, then :write to apply them
-- or :quit to discard them. Nothing changes on disk until you :write.
-- After you apply, :restart to load the new code. Treesitter parsers are
-- separate artifacts, so run :TSUpdate after a treesitter bump.
keymap.set("n", "<leader>pu", function()
	vim.pack.update()
end, { desc = "Update plugins (vim.pack)" })
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


keymap.set("n", "-", "<cmd>Oil<cr>")
keymap.set("n", "<c-e>", "<cmd>Oil<cr>")
keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open Oil file explorer" })

keymap.set("n", "<c-f>", "<cmd>FzfLua files<cr>")
keymap.set("n", "<c-g>", "<cmd>FzfLua live_grep<cr>")
keymap.set("n", "<c-b>", "<cmd>FzfLua buffers<cr>")
keymap.set("n", "<c-t>", "<cmd>FzfLua tags<cr>")
