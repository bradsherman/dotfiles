require('lualine').setup {
  options = {
    theme = 'solarized_light',
    section_separators = {'', ''},
    component_separators = {'', ''}
  },
  extensions = {'fzf', 'fugitive', 'nvim-tree'},
  sections = {
    lualine_a = {'mode'},
    lualine_b = {
      'branch',
      {
        'diff',
        colored = true, -- displays diff status in color if set to true
        symbols = {added = '+', modified = '~', removed = '-'} -- changes diff symbols
      }
    },
    lualine_c = {{'filename', file_status = true, path = 1}},
    lualine_x = {{'filetype', colored = true}},
    lualine_y = {'progress', 'location'},
    lualine_z = {
      {
        "diagnostics",
        sources = {"nvim_lsp"},
        sections = {'error', 'warn', 'info', 'hint'},
        -- all colors are in format #rrggbb
        color_error = '#fdf6e3', -- changes diagnostic's error foreground color
        color_warn = '#fdf6e3', -- changes diagnostic's warn foreground color
        color_info = '#fdf6e3', -- Changes diagnostic's info foreground color
        color_hint = '#fdf6e3', -- Changes diagnostic's hint foreground color
        symbols = {error = '❌ ', warn = '⚠️  ', info = 'ℹ️  ', hint = '💡 '}
      }, require 'lsp-status'.status
    }
 }
}
