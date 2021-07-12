require('lualine').setup {
 options = {
   theme = 'solarized',
 },
 extensions = {'fzf', 'fugitive'},--, 'nerdtree'},
 sections = {
   lualine_a = {'mode'},
   lualine_b = {'branch'},
   lualine_c = {'filename'},
   lualine_x = {'filetype'},
   lualine_y = {'progress', 'location'},
   lualine_z = {'LspError', 'LspWarning', 'LspHints', 'LspStatus'}
 }
}

