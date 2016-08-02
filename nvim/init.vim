" Plugins {{{
set nocompatible       "Prevents changing other options as side effects"
filetype off           "required

" Set runtime path to include Vundle and initialize
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin("~/.config/nvim/bundle")

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'neomake/neomake'
Plugin 'Raimondi/delimitMate'
Plugin 'flazz/vim-colorschemes'
Plugin 'fatih/vim-go'
Plugin 'rust-lang/rust.vim'
Plugin 'Shougo/deoplete.nvim'
Plugin 'ctrlpvim/ctrlp.vim'

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
" Remember to use right control since left control is escape in insert mode
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

" auto brackets
nnoremap { <esc>a{<cr><cr>}<esc>ki<tab>
" surround word with "
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
" surround word with '
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
" comment and uncomment blocks
augroup comments
    autocmd FileType c,cpp,java,scala    let b:comment_leader = '\/\/'
    autocmd FileType javascript,rust     let b:comment_leader = '\/\/'
    autocmd FileType sh,ruby,python      let b:comment_leader = '#'
    autocmd FileType conf,fstab          let b:comment_leader = '#'
    autocmd FileType tex                 let b:comment_leader = '%'
    autocmd FileType vim                 let b:comment_leader = '"'
augroup END

function! CommentLine()
    echo b:comment_leader
    execute ':silent! s/^\(.*\)/' . b:comment_leader . ' \1/g'
endfunction

function! UncommentLine()
    execute ':silent! s/^' . b:comment_leader . ' //g'
endfunction

noremap <leader>c :call CommentLine()<cr>
noremap <leader>C :call UncommentLine()<cr>

nnoremap <leader>s :CtrlP
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
augroup swapcaps
    au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
    au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Control_L'
augroup END

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
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0

" Airline config
let g:airline_section_b = '%{strftime("%c")}'
" let g:airline_theme='molokai'
let g:airline_theme='behelit'

" Do not create a separator for empty sections
let g:airline_skip_empty_sections = 1
" Do not keep track of whitespace
let g:airline#extensions#whitespace#enabled = 0
" Enable powerline fonts, and populate dict if it doesn't exist
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" Enable enhanced tabline
" has('tablineat') = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#excludes = []
let g:airline#extensions#tabline#show_buffers = 1
" Configure how tabs are separated
let g:airline#extensions#tabline#tab_nr_type = 1 
" Min number of buffers needed to show tabline
let g:airline#extensions#tabline#buffer_min_count = 2
" Remove closed buffers from tabline
autocmd BufLeave,BufAdd,BufUnload * call airline#extensions#tabline#buflist#invalidate()

" Custom statusline function
function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode',' ', 'branch'])
    let g:airline_section_b = airline#section#create(['%f'])
    let g:airline_section_c = airline#section#create(['filetype'])
    let g:airline_section_x = airline#section#create(['%P'])
    let g:airline_section_y = airline#section#create(['%l/%L'])
    let g:airline_section_z = airline#section#create(['%c c'])
endfunction
" Call custom statusline after airline init
autocmd User AirlineAfterInit call AirlineInit()

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Ctrlp Config

" Search by filename instead of full path
let g:ctrlp_by_filename = 0
" Try to jump to open instance if possible
let g:ctrlp_switch_buffer = 'Et'
" Scan for dotfiles and dotdirs
let g:ctrlp_show_hidden = 1
" Open new file in a tab
let g:ctrlp_open_new_file = 't'
" Follow symlinks
let g:ctrlp_follow_symlinks = 1

" Deoplete config
let g:deoplete#enable_at_startup = 1

" Neomake config
autocmd! BufWritePost,BufEnter * Neomake
" let g:neomake_open_list = 2
" }}}

" Make vim fold {{{
set foldenable         "enable folding
set foldlevelstart=10  "open most folds by default
set foldnestmax=10     "10 nested fold max
set foldmethod=marker
set foldlevel=0
set modelines=1
" }}}
" Remove 'x' to enable folding
" xvim:foldmethod=marker:foldlevel=0
