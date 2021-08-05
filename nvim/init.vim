" use luafile to make sure sourcing init.vim takes updates
luafile ~/.config/nvim/lua/keybindings.lua
luafile ~/.config/nvim/lua/colorschemes.lua
luafile ~/.config/nvim/lua/options.lua
luafile ~/.config/nvim/lua/plugins.lua
luafile ~/.config/nvim/lua/plugin_conf/init.lua
luafile ~/.config/nvim/lua/autocommands.lua


highlight Comment cterm=italic gui=italic
highlight Normal guibg=none

hi link illuminatedWord Visual

" Expand
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

" Expand or jump
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

nnoremap <silent> <leader>zm <cmd>execute luaeval("require('zen-mode').toggle({ window = { width = .85 }})")<cr>


function! _refreshTags()
    execute "!fast-tags -R " . finddir('.git/..', expand('%:p:h').';')
endfunction
nnoremap <silent> <leader>rt :call _refreshTags()<cr>


function RestartLSP()
    lua vim.lsp.stop_client(vim.lsp.get_active_clients())
    edit
endfunction
nnoremap <leader>rl :call RestartLSP()<cr>


function! PushHead()
  let h = execute(":echon FugitiveHead()")
  if confirm('Push ' . h . '?', "&Yes\n&No", 1)==1
    return execute("Git push origin " . h)
  endif
endfunction
nnoremap <leader>gp  <cmd>eval PushHead()<cr>

