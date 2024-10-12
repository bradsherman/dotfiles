local o = vim.opt
local bo = vim.bo
local wo = vim.wo

o.compatible = false
vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")
o.hidden = true
o.visualbell = false
o.errorbells = false
o.timeoutlen = 500
o.encoding = "UTF-8"
o.fillchars:append("fold:•")
o.foldcolumn = "0"
o.foldlevel = 99
o.foldlevelstart = 99
o.foldmethod = "expr"
-- wo.foldexpr = "nvim_treesitter#foldexpr()"
o.foldenable = true
o.tags = "./tags"
o.completeopt = "menu,menuone,noselect"

local tabsize = 2
o.tabstop = tabsize
o.softtabstop = tabsize
o.shiftwidth = tabsize

o.autoindent = true
o.autoread = true
o.smartindent = true
o.copyindent = true
o.expandtab = true
bo.expandtab = true
o.shiftround = true
o.updatetime = 200

o.mouse = "a"
o.shortmess:append("c")
o.ruler = false
wo.wrap = false
o.scrolloff = 5
o.sidescrolloff = 20
wo.number = true
wo.relativenumber = true
o.showmatch = true
o.splitright = true
o.splitbelow = true
o.splitkeep = "screen"
o.backspace = "eol,indent,start"
o.showcmd = false
o.showmode = false
wo.cursorline = false
o.wildmenu = true
o.cmdheight = 1
o.clipboard:append("unnamedplus")
-- wo.colorcolumn = "120"
wo.signcolumn = "yes"
vim.go.laststatus = 3

o.incsearch = true
o.hlsearch = false
o.ignorecase = true
o.smartcase = true
o.inccommand = "split"

o.termguicolors = true

bo.swapfile = false
o.backup = false
local undo_dir = os.getenv("HOME") .. "/.vim/undodir"
os.execute("mkdir -p " .. undo_dir)
o.undodir = { undo_dir }
vim.cmd([[set viewoptions-=curdir]])
vim.opt.undofile = true
local keyset = vim.keymap.set
keyset("i", ",", ",<C-g>U")
keyset("i", ".", ".<C-g>U")
keyset("i", "!", "!<C-g>U")
keyset("i", "?", "?<C-g>U")

o.grepprg = "rg --vimgrep --smart-case --follow --hidden"
-- o.grepprg = "rg --vimgrep"
o.grepformat = "%f:%l:%c:%m"
-- other useful chars: eol:↲,nbsp:␣
-- o.showbreak = "↪ "
o.showbreak = "↲"
-- o.listchars="eol:$,tab:→,nbsp:␣,trail:~,extends:⟩,precedes:⟨,space:·"
-- o.listchars = "eol:$,tab:▶·,nbsp:␣,trail:~,extends:⟩,precedes:⟨,space:·"
o.listchars = { eol = "$", tab = "▶·", nbsp = "␣", trail = "~", extends = "⟩", precedes = "⟨", space = "·" }

--[[ o.winbar = "%=%m %f" ]]

vim.cmd("set whichwrap+=<,>,[,],h,l")
-- This removes some auto-formatting for comments
-- see `:help fo-table` for more info
-- vim.cmd([[au BufEnter * set fo-=c fo-=r fo-=o]])

o.diffopt:append("linematch:50")

vim.on_key(function(char)
    if vim.fn.mode() == "n" then
        local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
        if vim.opt.hlsearch ~= new_hlsearch then
            vim.opt.hlsearch = new_hlsearch
        end
    end
end, vim.api.nvim_create_namespace("auto_hlsearch"))
