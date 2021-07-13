lua require('keybindings')
lua require('options')
lua require('colorschemes')
lua require('plugins')
lua require('plugin_conf')
lua require('autocommands')


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

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction
function! LspHints() abort
  let sl = ''
  if luaeval ('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
    let sl.= '💡 '
    let sl.= luaeval('vim.lsp.diagnostic.get_count(0, [[Hint]])')
  else
    let sl.=''
  endif
  return sl
endfunction
function! LspWarning() abort
  let sl = ''
  if luaeval ('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
    let sl.= '⚠️  '
    let sl.= luaeval('vim.lsp.diagnostic.get_count(0, [[Warning]])')
  else
    let sl.=''
  endif
  return sl
endfunction
function! LspError() abort
  let sl = ''
  if luaeval ('not vim.tbl_isempty(vim.lsp.buf_get_clients(0))')
    let sl.= '❌ '
    let sl.= luaeval('vim.lsp.diagnostic.get_count(0, [[Error]])')
  else
    let sl.=''
  endif
  return sl
endfunction


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

