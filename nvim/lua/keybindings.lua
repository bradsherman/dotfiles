local map = require 'utils'.map

map('n', '<space>', '', {})
vim.g.leader = ' '
vim.g.mapleader = ' '

map('n', '<leader>w', ':w!<cr>')
map('n', '<leader>,', ':noh<cr>')

map('i', 'jk', '<esc>')
map('n', ';', ':')
map('n', ':', ';')

map('n', 'j', 'gj')
map('n', 'k', 'gk')

map('n', '<c-j>', '<c-w><c-j>')
map('n', '<c-k>', '<c-w><c-k>')
map('n', '<c-l>', '<c-w><c-l>')
map('n', '<c-h>', '<c-w><c-h>')

map('n', '<tab>', '%')

-- Go to start or end of line easier
map('n', 'H', '^')
map('x', 'H', '^')
map('n', 'L', 'g_')
map('x', 'L', 'g_')


-- Continuous visual shifting (does not exit Visual mode), `gv` means
-- to reselect previous visual area, see https://goo.gl/m1UeiT
map('x', '<', '<gv')
map('x', '>', '>gv')

map('n', '<leader><tab>', ':b#<cr>')

map('n', '<leader>so', ':so ~/.config/nvim/init.vim<cr>', {silent=true, noremap=true})
map('n', '<leader>pi', ':PackerInstall<cr>', {silent=true, noremap=true})
map('n', '<leader>pu', ':PackerSync<cr>', {silent=true, noremap=true})
