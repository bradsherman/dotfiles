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

" Automatically make something uppercase
" Remember to use right control since left control is escape in vim
inoremap <c-u> <esc>viwU 

" Auto read when a file is changed from the outside
set autoread

" Make comma the noremap leader
let mapleader = ","
let g:mapleader = ","
nnoremap ; :

" Fast saving and quitting
nnoremap <leader>w :w!<cr>
nnoremap <leader>wq :wq<cr>

" Save files with sudo if you forget
cnoremap w!! w !sudo tee % >/dev/null

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
noremap <leader>tn :tabnew<cr>
noremap <leader>to :tabonly<cr>
noremap <leader>tc :tabclose<cr>
noremap <leader>tm :tabmove
" next tab
noremap <leader>tb :tabn<cr>
" previous tab
noremap <leader>tp :tabp<cr>
noremap <leader>tf :tabfirst<cr>
noremap <leader>tl :tablast<cr>

" Useful abbreviations
iabbrev adn and
iabbrev waht what
iabbrev tehn then

" Useful mappings

" surround word with "
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
" surround word with '
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
" }}}

" UI Config {{{

set wrap               "don't wrap lines"
set textwidth=80       "make lines wrap after 79 characters
set colorcolumn=+1     "vertical ruler one column after textwidth 
set relativenumber     "relative line numbers
set showmatch          "show matching parenthesis"
set title

set pastetoggle=<F2>
set backspace=2                 "allow going back over line breaks
set backspace=eol,start,indent  "make backspace act as it should
set whichwrap=<,>,h,l           "allow moving up and down lines at the end

set showcmd
set cursorline                  "highlight current line
set wildmenu                    "graphical menu for commands
set lazyredraw

set shortmess=a
set cmdheight=2

" Make status bar appear all the time
set laststatus=2
" }}}

" Movement {{{

" Disable arrow keys in Normal mode
noremap <up> <NOP>
noremap <down> <NOP>
noremap <right> <NOP>
noremap <left> <NOP>

" Easy way to get to beginning and end of line
nnoremap H ^
nnoremap L $

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Easy way to move between panes
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" }}} 

" Searching {{{
set incsearch
set hlsearch
set ignorecase
nnoremap <silent> <leader>/ :nohlsearch<CR>
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

nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>
" }}}

" AutoCommands {{{

" augroup my_autocommands
"   the line below clears all previous autocommands 
"   autocmd!
"   put autocommands in here
" augroup END
"}}}

" Plugin config {{{

" Syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
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

