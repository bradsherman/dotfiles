local map = require 'utils'.map

require ('plugin_conf.nvim_tree')
require ('plugin_conf.neogit')
require ('plugin_conf.neoscroll')
require ('plugin_conf.todo')
require ('plugin_conf.lualine')
require ('plugin_conf.telescope')
require ('plugin_conf.trouble')
require ('plugin_conf.treesitter')
require ('plugin_conf.lsp')
-- require ('plugin_conf.compe')
require ('plugin_conf.cmp')
require ('plugin_conf.git')
require ('plugin_conf.neoterm')
-- require ('plugin_conf.indent_blankline')

-- easy installs
require'nvim-web-devicons'.setup { default = true }
require('gitsigns').setup ()
require('zen-mode').setup {}
require('colorizer').setup ()

vim.g.sql_type_default = 'pgsql'

map('n', '<leader>tm', ':TableModeToggle<cr>', {silent=true, noremap=true})
map('n', '<leader>dfo', ':DiffviewOpen<cr>', {silent=true, noremap=true})
map('n', '<leader>dfc', ':DiffviewClose<cr>', {silent=true, noremap=true})
