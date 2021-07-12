local map = require 'utils'.map
local actions = require('telescope.actions')

require('telescope').setup{
  defaults = {
    layout = {prompt_position = "bottom"},
    file_sorter =  require'telescope.sorters'.get_fzy_sorter,
    mappings = {
      i = {
          ["<c-j>"] = actions.move_selection_next,
          ["<c-k>"] = actions.move_selection_previous,
      }
    }
  },
  extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
      fzf = {
        override_generic_sorter = false,
        override_file_sorter = true,
        case_mode = 'smart_case'
      }
  }
}
require('telescope').load_extension('fzf')


map('n', '<c-f>', '<cmd>Telescope find_files<cr>', {silent = true, noremap = true})
map('n', '<c-g>', '<cmd>Telescope live_grep<cr>', {silent = true, noremap = true})
map('n', '<c-t>', '<cmd>Telescope tags<cr>', {silent = true, noremap = true})
map('n', '<c-b>', '<cmd>Telescope buffers<cr>', {silent = true, noremap = true})
map('n', '<leader>fe', '<cmd>Telescope file_browser<cr>', {silent = true, noremap = true})

