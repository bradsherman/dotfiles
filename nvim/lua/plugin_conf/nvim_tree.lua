local map = require 'utils'.map

vim.g.nvim_tree_side = 'right'
vim.g.nvim_tree_ignore = { '.git', '*.hie' }
vim.g.nvim_tree_quit_on_open = 1
map('n', '<c-e>', ':NvimTreeToggle<cr>')
map('n', '<leader>e', ':NvimTreeFindFile<cr>')

