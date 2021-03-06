local o = vim.opt
local bo = vim.bo
local wo = vim.wo

o.compatible = false
vim.cmd('filetype plugin indent on')
vim.cmd('syntax enable')
o.hidden = true
o.visualbell = false
o.errorbells = false
o.timeoutlen=500
o.encoding='UTF-8'

local tabsize=2
o.tabstop = tabsize
o.softtabstop = tabsize
o.shiftwidth = tabsize

bo.autoindent = true
bo.autoread = true
bo.smartindent = true
bo.copyindent = true
o.expandtab = true
o.shiftround = true
o.updatetime=300

o.mouse='a'
-- o.shortmess = o.shortmess + { "c" }
o.ruler = false
wo.wrap = false
o.scrolloff = 7
o.sidescrolloff = 15
wo.number = true
wo.relativenumber = true
o.showmatch = true
o.splitright = true
o.splitbelow = true
o.backspace = 'eol,indent,start'
o.whichwrap = '<,>,h,l'
o.showcmd = false
o.showmode = false
wo.cursorline = true
o.wildmenu = true
o.cmdheight = 1
o.clipboard = 'unnamedplus'
wo.colorcolumn = '120'
wo.signcolumn = 'yes'
o.laststatus = 2

o.incsearch = true
o.hlsearch = false
o.ignorecase = true
o.smartcase = true

bo.swapfile = false
o.backup = false
local undo_dir = os.getenv("HOME") .. '/.vim/undodir'
os.execute("mkdir -p " .. undo_dir)
o.undodir = undo_dir
bo.undofile = true

o.grepprg = 'rg --vimgrep --smart-case --follow'
