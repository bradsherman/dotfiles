" Plugins {{{
set nocompatible       "Prevents changing other options as side effects"
filetype off           "required

" Set runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe'
Plugin 'flazz/vim-colorschemes'
Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'

" All plugins must be added before the following line
call vundle#end()
filetype plugin on
filetype indent on


" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

" Useful commands
" :PluginList          - lists configured plugins
" :PluginInstall       - installs plugins; append '!' to update or just  :PluginUpdate
" :PluginSearch foo    - searches for foo; append '!' to refresh local cache
" :PluginClean         - confirms removal of unused plugins; append '!' to auto-approve removal
" }}}

" General Config {{{

set hidden             "hide buffers

set history=1000       "remember more commands and search history"
set undolevels=1000    "use many more levels of undo"
set novisualbell       "don't beep"
set noerrorbells       "don't beep"
set t_vb=

" Auto read when a file is changed from the outside
set autoread

" Make comma the map leader
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Keep 7 lines for the cursor
set scrolloff=7

" Configure indentation settings
set tabstop=4          "number of visual spaces per TAB
set softtabstop=4      "number of spaces in tab when editing
set shiftwidth=4       "number of spaces to use for autoindenting
set autoindent         "autoindenting on
set smartindent        "smart tab on
set copyindent         "copy previous indentation
set expandtab          "turn tabs into spaces
set shiftround         "use multiple of shiftwidth when indenting with < and >

" Configure tab settings
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>tb :tabn<cr>
map <leader>tp :tabp<cr>
map <leader>tf :tabfirst<cr>
map <leader>tl :tablast<cr>
" }}}

" UI Config {{{

set wrap               "don't wrap lines"
set textwidth=79       "make lines wrap after 79 characters
set colorcolumn=+1     "vertical ruler one column after textwidth 
set relativenumber     "relative line numbers
set showmatch          "show matching parenthesis"
set title

set pastetoggle=<F2>
set backspace=2                 "allow going back over line breaks
set backspace=eol,start,indent  "make backspace act as it should
set whichwrap=<,>,h,l

set showcmd
set cursorline
set wildmenu
set lazyredraw

set shortmess=a
set cmdheight=2

" Make status bar appear all the time
set laststatus=2
" }}}

" Movement {{{

" Disable arrow keys in Normal mode
map <up> <NOP>
map <down> <NOP>
map <right> <NOP>
map <left> <NOP>

" move vertically by visual line
nnoremap j gj
nnoremap k gk
" }}} 

" Searching {{{
set incsearch
set hlsearch
set ignorecase
" }}}

" Colors and syntax {{{

" Define colorscheme
"syntax enable
"set background=dark
"colorscheme solarized
syntax on
colorscheme molokai

if (&term == "iterm") || (&term == "putty")
	set background=dark
endif
" }}}

" Custom config {{{
" Quickly select the text that was just pasted. This allows you to, e.g.,
" indent it after pasting.
noremap gV `[v`]
" Stay in visual mode when indenting. You will never have to run gv after
" performing an indentation.
vnoremap < <gv
vnoremap > >gv
" Swap caps and escape when entering vim, undo on exit
au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Control_L'

" NumberToggle toggles between relative and absolute line numbers
function! NumberToggle()
  if(&relativenumber == 1)
  	set number
  	set norelativenumber
  else
  	set number
  	set relativenumber
  endif
endfunc

nnoremap <C-n> :call NumberToggle()<cr>

nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>
" }}}

" Plugin config {{{

" Syntastic config
set statusline+=%#warningmsg#
set statusline+=${SyntasticStatusLineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Airline config
let g:airline_section_b = '%{strftime("%c")}'
let g:airline#themes#molokai#palette = {}

" }}}

" Make vim fold {{{
"set foldenable         "enable folding
"set foldlevelstart=10  "open most folds by default
"set foldnestmax=10     "10 nested fold max
"set foldmethod=marker
"set foldlevel=0
"set modelines=1
" }}}
" Remove 'x' to enable folding
" xvim:foldmethod=marker:foldlevel=0
