local map = require("utils").map

local impatient = require("impatient")
impatient.enable_profile()

require("plugin_conf.nvim_tree")
require("plugin_conf.neogit")
require("plugin_conf.neoscroll")
require("plugin_conf.todo")
require("plugin_conf.lualine")
require("plugin_conf.telescope")
require("plugin_conf.trouble")
require("plugin_conf.treesitter")
require("plugin_conf.lsp")
require("plugin_conf.cmp")
require("plugin_conf.git")
require("plugin_conf.gitsigns")
require("plugin_conf.neorg")
require("plugin_conf.indent_blankline")
require("plugin_conf.which_key")
require("plugin_conf.bufferline")
require("plugin_conf.comment")
require("plugin_conf.toggleterm")
require("plugin_conf.zen")
require("plugin_conf.autopairs")
-- require("plugin_conf.alpha")

-- easy installs
require("nvim-web-devicons").setup({ default = true })
require("colorizer").setup()
require("stabilize").setup()
require("renamer").setup({})
require("nvim-ts-autotag").setup()
require("treesitter-context").setup({})

-- vim.g.sql_type_default = 'pgsql'

vim.ui.select = require("popui.ui-overrider")
vim.g.popui_border_style = "double"

vim.g.do_filetype_lua = 1

local opts = { silent = true, noremap = true }
map("n", "<leader>tm", ":TableModeToggle<cr>", opts)
map("n", "<leader>dfo", ":DiffviewOpen<cr>", opts)
map("n", "<leader>dfc", ":DiffviewClose<cr>", opts)
map("n", "<leader>hw", ":HopWord<cr>", opts)
