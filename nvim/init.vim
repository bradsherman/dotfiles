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
" Plug 'terryma/vim-multiple-cursors'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug '~/.fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'lilydjwg/colorizer'
Plug 'luochen1990/rainbow'
Plug 'RRethy/vim-illuminate'
Plug 'terryma/vim-smooth-scroll'
Plug 'inside/vim-search-pulse'
Plug 'preservim/nerdtree'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'altercation/vim-colors-solarized'
Plug 'arcticicestudio/nord-vim'

Plug 'folke/lsp-colors.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update
Plug 'nvim-treesitter/playground'

Plug 'lifepillar/pgsql.vim'

Plug 'kassio/neoterm'

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
" let maplocalleader=",,"
" let g:maplocalleader=",,"
nnoremap <leader>w :w!<cr>
nnoremap <leader><space> :noh<cr>

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
set cmdheight=2
set clipboard=unnamed
set undofile

set laststatus=2
nnoremap j gj
nnoremap k gk

set incsearch
set hlsearch
set ignorecase


" let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
" let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" let g:solarized_termcolors=256
set background=light
" if has('termguicolors')
"   set termguicolors
" endif
" colorscheme nord
colorscheme solarized
let g:airline_theme='solarized'

hi link illuminatedWord Visual

nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll, 5, 2)<cr>
nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll, 5, 2)<cr>

nnoremap <c-e> :NERDTreeToggle<cr>
nnoremap <leader>e :NERDTreeFind<cr>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
let g:NERDTreeWinPos="right"

nnoremap <silent> <leader>so :so ~/.config/nvim/init.vim<cr>

nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>

set grepprg=rg\ --vimgrep\ --smart-case\ --follow
nnoremap <leader><tab> :b#<cr>

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

nvim_lsp.rust_analyzer.setup({
  capabilities = lsp_status.capabilities
})
nvim_lsp.hls.setup{
    settings = {
      languageServerHaskell = {
        formattingProvider = "fourmolu"
      }
    },
    on_attach = on_attach,
    capabilities = lsp_status.capabilities
}

require'nvim-treesitter.configs'.setup {
  -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = { haskell,json,javascript,yaml,bash,typescript,html,clojure,rust,lua,python },
  highlight = { enable = true }
}

require'nvim-web-devicons'.setup {}
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
      }
  }
}
require('telescope').load_extension('fzy_native')

EOF
luafile ~/.config/nvim/lua/compe-config.lua

" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>Telescope lsp_defintions<cr>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<cr>
nnoremap <silent> gr <cmd>Telescope lsp_references<cr>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<cr>
nnoremap <silent> <leader>dd <cmd>Telescope lsp_document_diagnostics<cr>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<cr>
nnoremap <silent> <c-x> <cmd>lua vim.lsp.diagnostic.set_loclist()<cr>
nnoremap <silent> <c-p> <cmd>lua vim.lsp.diagnostic.goto_prev()<cr>
nnoremap <silent> <c-n> <cmd>lua vim.lsp.diagnostic.goto_next()<cr>
autocmd BufWritePre * lua vim.lsp.buf.formatting_sync(nil, 100)
" autocmd BufWritePre * lua vim.lsp.diagnostic.set_loclist()
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

function RestartLSP()
    lua vim.lsp.stop_client(vim.lsp.get_active_clients())
    edit
endfunction
nnoremap <leader>rl :call RestartLSP()<cr>

function! LspStatus() abort
  let status = luaeval('require("lsp-status").status()')
  return trim(status)
endfunction
call airline#parts#define_function('lsp_status', 'LspStatus')
call airline#parts#define_condition('lsp_status', 'luaeval("#vim.lsp.buf_get_clients() > 0")')
let g:airline_powerline_fonts = 1
let g:airline#extensions#nvimlsp#enabled = 0
let g:airline_section_warning = airline#section#create_right(['lsp_status'])


" let $FZF_DEFAULT_OPTS="--reverse"
" nnoremap <silent> <c-f> :Files<cr>
" " nnoremap <silent> <c-p> :Files<cr>
" nnoremap <silent> <c-g> :Rg<cr>
" nnoremap <silent> <c-t> :Tags<cr>
" nnoremap <silent> <leader>b :Buffers<cr>
" nnoremap <silent> <leader>g :Commits<cr>
" nnoremap <silent> <Leader>/ :BLines<CR>
" nnoremap <silent> <Leader>' :Marks<CR>
" nnoremap <silent> <Leader>H :Helptags<CR>
" nnoremap <silent> <Leader>hh :History<CR>
" nnoremap <silent> <Leader>h: :History:<CR>
" nnoremap <silent> <Leader>h/ :History/<CR>
function! _refreshTags()
    execute "!fast-tags -R " . finddir('.git/..', expand('%:p:h').';')
endfunction
nnoremap <silent> <leader>rt :call _refreshTags()<cr>

nnoremap <silent> <c-f> <cmd>Telescope find_files<cr>
nnoremap <silent> <c-g> <cmd>Telescope live_grep<cr>
nnoremap <silent> <c-t> <cmd>Telescope tags<cr>
nnoremap <silent> <c-b> <cmd>Telescope buffers<cr>
" nnoremap <silent> <c-h> <cmd>Telescope help_tags<cr>
nnoremap <silent> <leader>fe <cmd>Telescope file_browser<cr>




" fugitive
" helpful commands to remember
" :Gcommit, :Gpush
" cc is also an easy way to commit
" :Git merge <branch>
" to resolve conflict press 'dv'
" in the diff editor <leader>gj will grab from the right side, <leader>gf will
" grab from the left
" ctrl+w,ctrl+o to close diff editor
nnoremap <leader>gj :diffget //3<cr>
nnoremap <leader>gf :diffget //2<cr>
nnoremap <leader>gc :GBranches<cr>
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gs :G<cr>

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
autocmd BufWritePre * %s/\s\+$//e


let g:neoterm_default_mod='botright'
let g:neoterm_autoinsert=1
nnoremap <silent> <leader>t :Ttoggle<cr>
nnoremap <silent> <leader>tr :T ghci<cr>
nnoremap <silent> <leader>trf :TREPLSendFile<cr>
" nnoremap <silent> <leader>tc :Tclose<cr>
nnoremap <silent> <leader>tca :TcloseAll<cr>

