local create_augroup = require 'utils'.create_augroup

create_augroup({
  { 'BufNewFile,BufRead', '*.md', 'set', 'ft=markdown' },
  { 'BufNewFile,BufRead', '*.md', 'set', 'wrap' },
  { 'FileType', 'markdown', 'set', 'conceallevel=2' },
  { 'FileType', 'markdown', 'setlocal', 'spell', 'spelllang=en' },
  { 'FileType', 'markdown', 'setlocal', 'spell', 'textwidth=90' }
}, 'Markdown')

-- Trim whitespace on save
create_augroup({
  { 'BufWritePre', '*', '%s/\\s\\+$//e' },
}, 'TrimWhitespace')

-- Return to last edit position when opening a file
create_augroup({
  { 'BufReadPost', '*', 'if line(\"\'\\\"\") > 1 && line(\"\'\\\"\") <= line(\"$\") && &ft !~# \'gitcommit\' | execute \"normal! g`\\\"\" | endif' },
}, 'ResumeEditPosition')


create_augroup({
  { 'Filetype', 'gitcommit', 'setlocal', 'spell', 'textwidth=72' }
}, 'CommitMsg')

-- auto format on save
create_augroup({
  { 'BufWritePre', '*', 'lua vim.lsp.buf.formatting_sync(nil, 1000)' }
}, 'FormatOnSave')

-- illuminate
create_augroup({
  {'VimEnter', '*', 'highlight Comment cterm=italic gui=italic'},
  {'VimEnter', '*', 'highlight Normal guibg=none'},
  {'VimEnter', '*', 'highlight link illuminatedWord CursorLine'},
  {'VimEnter', '*', 'highlight illuminatedCurWord cterm=italic gui=italic'},
  {'VimEnter', '*', 'highlight def link LspReferenceText CursorLine'},
  {'VimEnter', '*', 'highlight def link LspReferenceWrite CursorLine'},
  {'VimEnter', '*', 'highlight def link LspReferenceRead CursorLine'}
}, 'Illuminate')

create_augroup({
  {'FileType', 'haskell', 'setlocal tabstop=4'},
  {'FileType', 'haskell', 'setlocal softtabstop=4'},
  {'FileType', 'haskell', 'setlocal shiftwidth=4'}
}, 'HaskellTabs')
