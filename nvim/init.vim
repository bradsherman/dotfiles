" Plugins {{{
filetype off
set encoding=utf-8     "enable unicode

" Automatically install vim-plug if it doesn't exist
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" Vim git interface
Plug 'tpope/vim-fugitive'
" beautiful status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" asynchronous syntax checker
Plug 'neomake/neomake'
" parenthesis/quote matcher
Plug 'raimondi/delimitmate'
" more colorschemes
Plug 'flazz/vim-colorschemes'
" help with go dev
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
" help with rust dev
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" asynchronous auto-completion
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" fuzzy file searcher
Plug 'ctrlpvim/ctrlp.vim'
" python syntax checker
Plug 'nvie/vim-flake8', { 'for': 'python' }
" rust code completion
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
" python code completion
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" Html completion
Plug 'mattn/emmet-vim', { 'for': 'html' }
" C/C++/C# completion
Plug 'zchee/deoplete-clang', { 'for': ['c', 'cpp'] }
" Go code completion
Plug 'zchee/deoplete-go', { 'do': 'make' }
" Clojure completion
" Plug 'SevereOverfl0w/vim-clj/async', { 'for': 'clojure' }
" Javascript completion
Plug 'carlitux/deoplete-ternjs'
" Vimscript completion
Plug 'Shougo/neco-vim'
" Java completion
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
" Git-diff in gutter
Plug 'airblade/vim-gitgutter'
" Markdown syntax
Plug 'plasticboy/vim-markdown'
call plug#end()


" }}}

" General Config {{{

filetype plugin indent on
set hidden             "hide buffers

set history=1000       "remember more commands and search history"
set undolevels=1000    "use many more levels of undo"
set novisualbell       "don't beep"
set noerrorbells       "don't beep"

" Auto read when a file is changed from the outside
set autoread

" Make comma the noremap leader
let mapleader = ","
let g:mapleader = ","
nnoremap ; :

" Quick access to terminal
nnoremap <leader>t :terminal<cr>

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
iabbrev taht that
iabbrev icnlude include
iabbrev #i #include
iabbrev #d #define
iabbrev ustd using namespace std;
iabbrev teh the
iabbrev Teh The
iabbrev Seperate Separate
iabbrev seperate separate
iabbrev tdate <c-r>=strftime("%Y-%m-%d")<cr>

" Useful mappings

" Automatically make something uppercase
" Remember to use right control since left control is escape in insert mode
inoremap <c-u> <esc>viwU 
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
    autocmd FileType conf,fstab,bash     let b:comment_leader = '#'
    autocmd FileType tex                 let b:comment_leader = '%'
    autocmd FileType vim                 let b:comment_leader = '"'
augroup END

function! CommentLine()
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

set nowrap             "don't wrap lines by default"
augroup wraps
    autocmd FileType c,cpp,java,javascript,    set wrap
    autocmd FileType rust,go,clojure, python   set wrap
augroup END
set textwidth=80       "make lines wrap after 79 characters
set colorcolumn=+1     "vertical ruler one column after textwidth 
set number             "line numbers
set showmatch          "show matching parenthesis"
set title

set pastetoggle=<F2>
set backspace=2                 "allow going back over line breaks
set backspace=eol,start,indent  "make backspace act as it should
set whichwrap=<,>,h,l           "allow moving up and down lines at the end
set updatetime=250              "vim update time = 250ms

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
" Make the dot work in visual mode as well
vnoremap . :norm.<cr>
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

" We started with regular numbers but now switch to relative 
" so that the current line number is displayed instead of 0
call NumberToggle()

nnoremap <C-n> :call NumberToggle()<cr>

nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>
" }}}

" Plugin config {{{

" Airline config
" let g:airline_theme='molokai'
let g:airline_theme='behelit'
" refresh airline after autocomplete
nnoremap <leader>ar :execute ":AirlineRefresh"<CR>
" Do not create a separator for empty sections
let g:airline_skip_empty_sections = 1
" Do not keep track of whitespace
let g:airline#extensions#whitespace#enabled = 0
" Enable powerline fonts, and populate dict if it doesn't exist
let g:airline_powerline_fonts = 1
" Show tabs instead of buffers
let g:airline#extensions#tabline#show_buffers = 0
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" Enable enhanced tabline
" has('tablineat') = 1
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#excludes = []
let g:airline#extensions#tabline#show_buffers = 1
" Configure how tabs are separated
let g:airline#extensions#tabline#tab_nr_type = 1 
" Min number of buffers needed to show tabline
let g:airline#extensions#tabline#buffer_min_count = 2
" Only show filename, not full path
let g:airline#extensions#tabline#fnamemod = ':t'
" Remove closed buffers from tabline
autocmd BufLeave,BufAdd,BufUnload * call airline#extensions#tabline#buflist#invalidate()

" Custom statusline function
function! AirlineInit()
    let g:airline_section_a = airline#section#create_left(['mode', 'branch'])
    let g:airline_section_b = airline#section#create_left(['%f'])
    let g:airline_section_c = airline#section#create(['filetype'])
    let g:airline_section_x = airline#section#create(['%P'])
    let g:airline_section_z = airline#section#create_right(['%l/%L','%c c'])
"     let g:airline_section_z = airline#section#create_right([''])
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
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Ignore case unless a capital letter is included
let g:deoplete#enable_smart_case = 1
" Max number of suggestions
let g:deoplete#max_list = 25
" Decide how to complete
let g:deoplete#disable_auto_complete = 1
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort 
    let col = col('.') - 1
    return !col || getline('.')[col-1] =~ '\s'
endfunction
" Neomake config
" Run neomake after a save
autocmd! BufWritePost,BufEnter * Neomake
autocmd! VimEnter * let g:neomake_verbose = 0
" let g:neomake_open_list = 2
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_c_enabled_makers = ['gcc']
let g:neomake_cpp_gcc_maker = {
    \ 'args': ['-std=c++11']
    \}
let g:neomake_cpp_enabled_makers = ['gcc']

" Clojure completion
let g:deoplete#keyword_patterns = {}
let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.]*'

" Clang completion
let g:deoplete#sources#clang#libclang_path = '/usr/lib/x86_64-linux-gnu/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/lib/clang'

" Rust completion
let g:racer_cmd = "/home/bradsherman/.cargo/registry/src/github.com-1ecc6299db9ec823/racer-1.2.9/src/racer"
let $RUST_SRC_PATH="/usr/local/lib/rustlib/"

" Java completion
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Git Gutter config
let g:gitgutter_highlight_lines = 1

" Markdown config
let g:vim_markdown_folding_disabled = 1
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
" im:foldmethod=marker:foldlevel=0
