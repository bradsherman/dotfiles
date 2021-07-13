local map = require 'utils'.map

vim.g.neoterm_default_mod='botright'
vim.g.neoterm_autoinsert=1
map('n', '<leader>t', ':Ttoggle<cr>', {silent=true, noremap=true})
map('n', '<leader>tr', ':T ghci<cr>', {silent=true, noremap=true})
map('n', '<leader>trf', ':TREPLSendFile<cr>', {silent=true, noremap=true})
-- map('n', '<leader>tc', ':Tclose<cr>', {silent=true, noremap=true})
map('n', '<leader>tca', ':TcloseAll<cr>', {silent=true, noremap=true})
