set nocompatible
filetype off

call plug#begin(stdpath('data') . '/plugged')

Plug 'ntpeters/vim-better-whitespace'

Plug 'mhinz/vim-signify'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'flazz/vim-colorschemes'

Plug 'jiangmiao/auto-pairs'

Plug 'APZelos/blamer.nvim'

Plug 'hoob3rt/lualine.nvim'

Plug '~/.fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'lewis6991/gitsigns.nvim'

Plug 'lilydjwg/colorizer'
Plug 'luochen1990/rainbow'
Plug 'RRethy/vim-illuminate'
Plug 'karb94/neoscroll.nvim'
Plug 'inside/vim-search-pulse'
Plug 'preservim/nerdtree'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'ryanoasis/vim-devicons'
Plug 'ishan9299/nvim-solarized-lua'
Plug 'arcticicestudio/nord-vim'


Plug 'folke/lsp-colors.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'rafamadriz/friendly-snippets'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'
Plug 'folke/trouble.nvim'

Plug 'lifepillar/pgsql.vim'
Plug 'dhruvasagar/vim-table-mode'

Plug 'kassio/neoterm'

Plug 'easymotion/vim-easymotion'
Plug 'vmchale/dhall-vim'
Plug 'Yggdroot/indentLine'
Plug 'christoomey/vim-tmux-navigator'

Plug 'folke/todo-comments.nvim'
Plug 'sindrets/diffview.nvim'
Plug 'folke/zen-mode.nvim'

call plug#end()

syntax enable
filetype plugin indent on
set hidden
set novisualbell
set noerrorbells
set timeoutlen=500
set encoding=UTF-8

let tabsize=2
execute "set tabstop=".tabsize
execute "set softtabstop=".tabsize
execute "set shiftwidth=".tabsize

set autoindent
set autoread
set smartindent
set copyindent
set expandtab
set shiftround
set updatetime=300

let mapleader="\<space>"
let g:mapleader="\<space>"
nnoremap <leader>w :w!<cr>
nnoremap <leader>, :noh<cr>

inoremap jk <esc>
nnoremap : ;
nnoremap ; :

set mouse=a
set shortmess+=c
set noruler
set nowrap
set scrolloff=7
set sidescrolloff=15
set number
set relativenumber
set showmatch
set splitright
set splitbelow
set title
set backspace=eol,indent,start
set whichwrap=<,>,h,l
set noshowcmd
set noshowmode
set cursorline
set wildmenu
set cmdheight=1
set clipboard=unnamed
set colorcolumn=80
set signcolumn=yes

set laststatus=2
nnoremap j gj
nnoremap k gk

set incsearch
set nohlsearch
set ignorecase
set smartcase

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile


set background=light
" if has('termguicolors')
"   set termguicolors
" endif
" colorscheme nord
colorscheme solarized
highlight Comment cterm=italic gui=italic
highlight Normal guibg=none

hi link illuminatedWord Visual

nnoremap <c-e> :NERDTreeToggle<cr>
nnoremap <leader>e :NERDTreeFind<cr>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let g:NERDTreeWinPos="right"

nnoremap <silent> <leader>so :so ~/.config/nvim/init.vim<cr>
nnoremap <silent> <leader>pi :PlugInstall<cr>
nnoremap <silent> <leader>pu :PlugUpdate<cr>


nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>

set grepprg=rg\ --vimgrep\ --smart-case\ --follow
nnoremap <leader><tab> :b#<cr>

" Auto resize Vim splits to active splits
" set winwidth=104
" set winheight=5
" set winminheight=5
" set winheight=999

augroup Markdown
  autocmd!
  autocmd BufNewFile,BufRead *.md set filetype=markdown
  autocmd FileType markdown set conceallevel=2
  autocmd FileType markdown setlocal spell spelllang=en
  autocmd BufNewFile,BufRead *.md set wrap
augroup END

lua << EOF
local nvim_lsp = require('lspconfig')
local lsp_status = require('lsp-status')
lsp_status.register_progress()
local kind_labels_mt = {__index = function(_, k) return k end}
local kind_labels = {}
setmetatable(kind_labels, kind_labels_mt)
lsp_status.config({
  kind_labels = kind_labels,
  indicator_errors = "×",
  indicator_warnings = "!",
  indicator_info = "i",
  indicator_hint = "›",
})

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  buf_set_keymap('n', '<leader>h', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<space>ce', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap("n", "<leader>cf", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    buf_set_keymap("v", "<leader>cf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end
  lsp_status.on_attach(client, bufnr)
end

-- loop over default servers
local servers_default = {
  "rust_analyzer",
  "tsserver",
  "bashls",
  "dockerls",
  "graphql",
  "dhall_lsp_server",
  "jsonls",
  "julials",
  -- need to do special setup
  --"sqlls",
  "terraformls",
  "vimls"
}
lsp_status.capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp_status.capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  }
}
for _, lsp in ipairs(servers_default) do
  nvim_lsp[lsp].setup { on_attach = on_attach, capabilities = lsp_status.capabilities }
end

-- special setup for haskell & lua
nvim_lsp.hls.setup{
    settings = {
      languageServerHaskell = {
        formattingProvider = "fourmolu"
      }
    },
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
}

nvim_lsp.sumneko_lua.setup {
  cmd = {"/home/bsherman/code/lua-language-server/bin/Linux/lua-language-server", "-E", "/home/bsherman/code/lua-language-server/main.lua"},
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ';')
      },
      diagnostics = {
        globals = {'vim'}
      }
    }
  },
  on_attach = on_attach,
  capabilities = lsp_status.capabilities
}

require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { haskell,graphql,json,javascript,yaml,bash,typescript,html,clojure,rust,lua,python },
  highlight = { enable = true },
  indent = { enable = true }
}

require'nvim-web-devicons'.setup { default = true }

require('trouble').setup {
  auto_close = true,
  signs = {
    error = "❌",
    warning = "⚠️ ",
    hint = "💡",
    information = "ℹ️ ",
    other = "✔️ "
  }
}
require('gitsigns').setup()

local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    prompt_position = "bottom",
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

require('lualine').setup {
 options = {
   theme = 'solarized_light',
 },
 extensions = {'fzf', 'fugitive', 'nerdtree'},
 sections = {
   lualine_a = {'mode'},
   lualine_b = {'branch'},
   lualine_c = {'filename'},
   lualine_x = {'filetype'},
   lualine_y = {'progress', 'location'},
   lualine_z = {'LspError', 'LspWarning', 'LspHints', 'LspStatus'}
 }
}


require('todo-comments').setup {
  signs = true,
  keywords = {
    FIX = {
      icon = " ", -- icon used for the sign, and in search results
      color = "#DC2626", -- can be a hex color, or a named color (see below)
      alt = { "FIXME", "BUG", "FIXIT", "FIX", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
      -- signs = false, -- configure signs for some keywords individually
    },
    TODO = { icon = " ", color = "#2563EB" },
    HACK = { icon = " ", color = "#FBBF24" },
    WARN = { icon = " ", color = "#FBBF24", alt = { "WARNING", "XXX" } },
    PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
    NOTE = { icon = " ", color = "#10B981", alt = { "INFO" } },
  },
  highlight = {
    before = "", -- "fg" or "bg" or empty
    keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
    after = "", -- "fg" or "bg" or empty
    pattern = [[.*<(KEYWORDS)\s*:]], -- pattern used for highlightng (vim regex)
    comments_only = false, -- uses treesitter to match keywords in comments only
  },
  colors = {
    --error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
    error = { "#DC2626" },
    --warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
    warning = { "#FBBF24" },
    --info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
    info = { "#2563EB" },
    --hint = { "LspDiagnosticsDefaultHint", "#10B981" },
    hint = { "#10B981" },
    -- default = { "Identifier", "#7C3AED" },
    default = { "#7C3AED" },
  },
  }

require('neoscroll').setup({
  mappings = {'<C-u>', '<C-d>'}
    -- Set any other options as needed
})
local easing2 = [[function(x) return math.pow(x, 4) end]]
local t = {}
t['<C-u>'] = {'scroll', {'-vim.wo.scroll', 'true', '5', '20', easing2}}
t['<C-d>'] = {'scroll', { 'vim.wo.scroll', 'true', '5', '20', easing2}}
require('neoscroll.config').set_mappings(t)

require("zen-mode").setup {}

EOF
luafile ~/.config/nvim/lua/compe-config.lua
inoremap <silent><expr> <C-Space> compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')

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


" LSP config (the mappings used in the default file don't quite work right)
" nnoremap <silent> <leader>dd <cmd>Telescope lsp_document_diagnostics<cr>
nnoremap <silent> gr <cmd>Telescope lsp_references<cr>
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
" nnoremap <silent> gd <cmd>Telescope lsp_definitions<cr>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> <c-m> <cmd>Telescope lsp_document_symbols<cr>
nnoremap <silent> <leader>lt <cmd>:LspTroubleToggle<cr>
nnoremap <silent> <leader>ltr <cmd>:LspTroubleRefresh<cr>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <c-x> <cmd>lua vim.lsp.diagnostic.set_loclist({open_loclist = true})<cr>
nnoremap <silent> <c-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap <silent> <c-n> <cmd>lua vim.lsp.diagnostic.goto_next()<cr>
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 100)


" let $FZF_DEFAULT_OPTS="--reverse"
" nnoremap <silent> <c-f> :Files<cr>
" nnoremap <silent> <c-g> :Rg<cr>
" nnoremap <silent> <c-t> :Tags<cr>
" nnoremap <silent> <c-b> :Buffers<cr>
nnoremap <silent> <leader>g :Commits<cr>
nnoremap <silent> <Leader>/ :BLines<CR>
nnoremap <silent> <Leader>' :Marks<CR>
nnoremap <silent> <Leader>H :Helptags<CR>
nnoremap <silent> <Leader>hh :History<CR>
nnoremap <silent> <Leader>h: :History:<CR>
nnoremap <silent> <Leader>h/ :History/<CR>
function! _refreshTags()
    execute "!fast-tags -R " . finddir('.git/..', expand('%:p:h').';')
endfunction
nnoremap <silent> <leader>rt :call _refreshTags()<cr>

nnoremap <silent> <c-f> <cmd>Telescope find_files<cr>
nnoremap <silent> <c-g> <cmd>Telescope live_grep<cr>
nnoremap <silent> <c-t> <cmd>Telescope tags<cr>
nnoremap <silent> <c-b> <cmd>Telescope buffers<cr>
" nnoremap <silent> <c-m> <cmd>Telescope current_buffer_tags<cr>
nnoremap <silent> <leader>fe <cmd>Telescope file_browser<cr>

function RestartLSP()
    lua vim.lsp.stop_client(vim.lsp.get_active_clients())
    edit
endfunction
nnoremap <leader>rl :call RestartLSP()<cr>


" fugitive
" helpful commands to remember
" :Gcommit, :Gpush
" cc is also an easy way to commit
" :Git merge <branch>
" to resolve conflict press 'dv'
" in the diff editor <leader>gj will grab from the right side, <leader>gf will
" grab from the left
" ctrl+w,ctrl+o to close diff editor
nnoremap <silent> <leader>gj :diffget //3<cr>
nnoremap <silent> <leader>gf :diffget //2<cr>
nnoremap <silent> <leader>gc :Telescope git_branches<cr>
nnoremap <silent> <leader>gb :Git blame<cr>
nnoremap <silent> <leader>gs :G<cr>
nnoremap <leader>gp :Git push origin
nnoremap <leader>gpu :Git pull origin

" jump to matching pairs
nnoremap <tab> %

" Go to start or end of line easier
nnoremap H ^
xnoremap H ^
nnoremap L g_
xnoremap L g_

" Continuous visual shifting (does not exit Visual mode), `gv` means
" to reselect previous visual area, see https://goo.gl/m1UeiT
xnoremap < <gv
xnoremap > >gv


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

let NERDTreeIgnore = ['\.hie$']

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
