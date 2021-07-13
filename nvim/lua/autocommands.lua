local create_augroup = require 'utils'.create_augroup

create_augroup({
  { 'BufNewFile,BufRead', '*.md', 'set', 'ft=markdown' },
  { 'BufNewFile,BufRead', '*.md', 'set', 'wrap' },
  { 'FileType', 'markdown', 'set', 'conceallevel=2' },
  { 'FileType', 'markdown', 'setlocal', 'spell', 'spelllang=en' }
}, 'Markdown')

-- Trim whitespace on save
create_augroup({
  { 'BufWritePre', '*', '%s/\\s\\+$//e' },
}, 'TrimWhitespace')

-- Return to last edit position when opening a file
create_augroup({
  { 'BufReadPost', '*', 'if line(\"\'\\\"\") > 1 && line(\"\'\\\"\") <= line(\"$\") && &ft !~# \'gitcommit\' | execute \"normal! g`\\\"\" | endif' },
}, 'ResumeEditPosition')


-- Send Diagnostics to loc list
create_augroup({
  { 'BufWrite,BufEnter,InsertLeave', '*', 'lua vim.lsp.diagnostic.set_loclist({open_loclist = false})' }
}, 'LSP')

create_augroup({
  { 'Filetype', 'gitcommit', 'setlocal', 'spell', 'textwidth=72' }
}, 'CommitMsg')

-- auto format on save
create_augroup({
  { 'BufWritePre', '*', 'lua vim.lsp.buf.formatting_sync(nil, 100)' }
}, 'FormatOnSave')
