lua require('keybindings')
lua require('options')
lua require('colorschemes')
lua require('plugins')
lua require('plugin_conf')


if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

highlight Comment cterm=italic gui=italic
highlight Normal guibg=none

hi link illuminatedWord Visual

augroup Markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd FileType markdown set conceallevel=2
  autocmd FileType markdown setlocal spell spelllang=en
  autocmd BufNewFile,BufRead *.md set wrap
augroup END


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

autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 100)

function! _refreshTags()
    execute "!fast-tags -R " . finddir('.git/..', expand('%:p:h').';')
endfunction
nnoremap <silent> <leader>rt :call _refreshTags()<cr>


function RestartLSP()
    lua vim.lsp.stop_client(vim.lsp.get_active_clients())
    edit
endfunction
nnoremap <leader>rl :call RestartLSP()<cr>


" fugitive
" helpful commands to remember
" :Gcommit, :Gpush
" cc is also an easy way to commit
nnoremap <silent> <leader>gc :Telescope git_branches<cr>
nnoremap <silent> <leader>gs :G<cr>
nnoremap <leader>gpp :Git push origin
nnoremap <leader>gp  <cmd>eval PushHead()<cr>
nnoremap <leader>gpu :Git pull origin
nnoremap <silent> <leader>gg :Neogit kind=split<cr>

function! PushHead()
  let h = execute(":echon FugitiveHead()")
  if confirm('Push ' . h . '?', "&Yes\n&No", 1)==1
    return execute("Git push origin " . h)
  endif
endfunction



let g:sql_type_default = 'pgsql'

" Return to last edit position when opening a file
augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END
augroup accurate_syn_highlight
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
augroup END

" auto trim whitespace
augroup TripWhitespace
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
augroup END


let g:neoterm_default_mod='botright'
let g:neoterm_autoinsert=1
nnoremap <silent> <leader>t :Ttoggle<cr>
nnoremap <silent> <leader>tr :T ghci<cr>
nnoremap <silent> <leader>trf :TREPLSendFile<cr>
" nnoremap <silent> <leader>tc :Tclose<cr>
nnoremap <silent> <leader>tca :TcloseAll<cr>

let g:blamer_enabled = 1
let g:blamer_date_format = '%m/%d/%y'
let g:blamer_relative_time = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_prefix = ' > '


nnoremap <silent> <leader>tm :TableModeToggle<cr>
nnoremap <silent> <leader>dfo :DiffviewOpen<cr>
nnoremap <silent> <leader>dfc :DiffviewClose<cr>


function! LspLocationList()
  lua vim.lsp.diagnostic.set_loclist({open_loclist = false})
endfunction

augroup LSP
  autocmd!
  autocmd! BufWrite,BufEnter,InsertLeave * :call LspLocationList()
augroup END

augroup CommitMsg
  autocmd!
  autocmd! Filetype gitcommit setlocal spell textwidth=72
augroup END

