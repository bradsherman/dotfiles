" Plugins {{{

filetype off
if !has('nvim')
    set encoding=utf-8     "enable unicode
endif

function! Cond(cond, ...)
    let opts = get(a:000, 0, {})
    return a:cond ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

" automatically install vim-plug if it doesn't exist
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" GENERAL
" tpope is the real MVP
" vim git interface
Plug 'tpope/vim-fugitive'
" make surrounding easy
Plug 'tpope/vim-surround'
" easy Repeat
Plug 'tpope/vim-repeat'
" substitution will never be the same
Plug 'tpope/vim-abolish'
" amazing Mappings
Plug 'tpope/vim-unimpaired'
" comment all the things
Plug 'tpope/vim-commentary'
" parenthesis/quote matcher
Plug 'raimondi/delimitmate'
" help with go dev
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
" help with rust dev
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
" fuzzy file searcher
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }
" git-diff in gutter
Plug 'airblade/vim-gitgutter'
" snippets
Plug 'SirVer/ultisnips'   " snippets engine
Plug 'honza/vim-snippets' " actual snippets
" interactive scratch pad
Plug 'metakirby5/codi.vim'

" SYNTAX
" asynchronous syntax checker
Plug 'neomake/neomake'
" python syntax checker
Plug 'nvie/vim-flake8', { 'for': 'python', 'on': '<Plug>Neomake' }
" more c++ syntax
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp' }
" Golang syntax
Plug 'golang/lint', { 'for': 'go', 'on': '<Plug>Neomake' }
" markdown syntax
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" COMPLETION
" asynchronous auto-completion
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" rust code completion
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
" python code completion
Plug 'zchee/deoplete-jedi', { 'for': 'python' }
" html completion
Plug 'mattn/emmet-vim', { 'for': 'html' }
" c/c++/C# completion
Plug 'zchee/deoplete-clang', { 'for': ['c', 'cpp'] }
" go code completion
Plug 'zchee/deoplete-go', { 'do': 'make' }
" clojure completion
" plug 'SevereOverfl0w/vim-clj/async', { 'for': 'clojure' }
" javascript completion
Plug 'carlitux/deoplete-ternjs', { 'for': 'javascript' }
" vimscript completion
Plug 'Shougo/neco-vim', { 'for': 'vim' }
" java completion
Plug 'artur-shaik/vim-javacomplete2', { 'for': 'java' }
" Syntax checker for bash
Plug 'koalaman/shellcheck', { 'for': 'sh', 'on': '<Plug>Neomake' }

" COLORSCHEMES
" more colorschemes
Plug 'flazz/vim-colorschemes'
" beautiful status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Apprentice colorscheme
Plug 'romainl/Apprentice'
" Gruvbox
Plug 'morhetz/gruvbox'
" facebook colors
Plug 'farfanoide/vim-facebook'
" pencil colors
Plug 'reedes/vim-colors-pencil'
" one dark colors
Plug 'joshdick/onedark.vim'
" seti
Plug 'trusktr/seti.vim'
" show me the colors!!
Plug 'gko/vim-coloresque'
" vice
Plug 'bcicen/vim-vice'
" badwolf
Plug 'sjl/badwolf'
" two firewatch
Plug 'rakr/vim-two-firewatch'
" material
Plug 'jdkanani/vim-material-theme'

call plug#end()


command! PU PlugUpdate | PlugUpgrade
command! PI PlugInstall

" }}}

" General Config {{{

filetype plugin indent on
set hidden             "hide buffers

set history=1000       "remember more commands and search history"
set undolevels=1000    "use many more levels of undo"
set novisualbell       "don't beep"
set noerrorbells       "don't beep"
set autoread           "Auto read when a file is changed from the outside
" set autowrite          "automatically write buffer when changing files
set timeoutlen=500     "don't wait so long for mapped sequences to complete
set mouse=""           "turn off mouse

" Configure indentation settings
let tabsize = 4        "easily change tabsize
" Number of visual spaces per TAB
execute "set tabstop=".tabsize
" Number of spaces in tab when editing
execute "set softtabstop=".tabsize
" Number of spaces to use for autoindenting
execute "set shiftwidth=".tabsize
set autoindent           "retain indentation from previous line
set smartindent          "turn on autoindenting of blocks
set copyindent           "copy previous indentation
set expandtab            "turn tabs into spaces
set shiftround           "use multiple of shiftwidth when indenting with < and >
"match angle brackets
autocmd FileType html set matchpairs+=<:>

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
iabbrev tdate <c-r>=strftime("%Y-%m-%d")<cr>
iabbrev pritn print
iabbrev retrun return
iabbrev reutrn return
iabbrev liek like

augroup Abolish-Commands
    autocmd!
    autocmd VimEnter * execute ":Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or} {despe,sepa}rat{}"
augroup END

" Useful mappings
" Use enter to create newlines in normal mode
nnoremap <cr> o<esc>
" These commands fix issues with the above mapping
" in the quickfix window
autocmd CmdwinEnter * nnoremap <cr> <cr>
autocmd BufReadPost quickfix nnoremap <cr> <cr>

" Make comma the map leader
let mapleader = ","
let g:mapleader = ","

" Quick access to terminal
if has('nvim')
    nnoremap <leader>t :terminal<cr>
endif

" Fast saving and quitting
nnoremap <leader>w :w!<cr>
nnoremap <leader>wq :wq<cr>
nnoremap ; :
nnoremap : ;

" Save files with sudo if you forget
cnoremap w!! w !sudo tee % >/dev/null

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
    autocmd!
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

" Yank to end of line instead of entire line (yy)
nnoremap Y y$
vnoremap Y y$

" Easy access to file searching
nnoremap <leader>s :CtrlP

augroup General-Autocommands
    autocmd!
    autocmd FocusLost,WinLeave * :silent! wa
    autocmd BufWritePre * %s/\s\+$//e

    " When editing a file, always jump to the last known cursor position.
    " Don't do it for commit messages, when the position is invalid, or when
    " inside an event handler (happens when dropping a file on gvim).
    autocmd BufReadPost *
                \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
                \   exe "normal g`\"" |
                \ endif

    " Enable spellchecking for Markdown
    autocmd FileType markdown setlocal spell

    " Automatically wrap at 100 characters and spell check git commit messages
    autocmd FileType gitcommit setlocal textwidth=100
    autocmd FileType gitcommit setlocal spell
augroup END

" }}}

" UI Config {{{

set nowrap                      "don't wrap lines by default"
augroup wraps
    autocmd!
    autocmd FileType c,cpp,java               set wrap
    autocmd FileType rust,go,clojure,python   set wrap
augroup END

set scrolloff=7                "Keep 7 lines above/below the cursor
set sidescrolloff=15            "Keep 15 chars to the right of the cursor
set textwidth=80                "make lines wrap after 79 characters
set colorcolumn=+1              "vertical ruler one column after textwidth
set number                      "line numbers
set showmatch                   "show matching parenthesis"
set splitright                  "open new splits to the right
set title                       "set our title
set pastetoggle=<F2>            "easily switch to paste mode
set backspace=2                 "allow going back over line breaks
set backspace=eol,start,indent  "make backspace act as it should
set whichwrap=<,>,h,l           "allow moving up and down lines at the end
set updatetime=250              "vim update time = 250ms
set showcmd                     "display incomplete command
set cursorline                  "highlight current line
set wildmenu                    "graphical menu for commands
set lazyredraw                  "don't redraw for commands we didn't type
set shortmess=a                 "avoid all the 'hit-enter' prompts
set cmdheight=2                 "statusline height
set clipboard=unnamed           "allow copy/paste from anywhere (system register)

" Auto resize Vim splits to active splits
set winwidth=104
set winheight=5
set winminheight=5
set winheight=999

" Show extra whitespace, with exceptions
set list listchars=tab:»·,trail:·,nbsp:·
augroup List-Options
    autocmd!
    autocmd FileType html,markdown set nolist
augroup END

" Do not add comment after newline
augroup Format-Options
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

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

" make space useful
nnoremap <space> <PageDown>
vnoremap <space> <PageDown>

" Easy way to move between panes
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Resize panes
nnoremap <silent> <Right> :vertical resize +5<cr>
nnoremap <silent> <Left> :vertical resize -5<cr>
nnoremap <silent> <Up> :horizontal resize +5<cr>
nnoremap <silent> <Down> :horizontal resize -5<cr>
" }}}

" Searching {{{
set incsearch
set hlsearch
set ignorecase
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Search and replace
nnoremap S :%s//g<left><left>

" }}}

" Colors and syntax {{{

" Use 24-bit (true color) when in vim/neovim outside tmux
if (empty($TMUX))
    if (has("nvim"))
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif

    if (has("termguicolors"))
        set termguicolors
    endif
endif

syntax on
" colorscheme molokai
" colorscheme PaperColor
" colorscheme skittles_berry
" colorscheme apprentice
" colorscheme facebook
" colorscheme pencil | set background=dark
" colorscheme seti
colorscheme badwolf
" colorscheme onedark

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
" Make caps lock another control
augroup swapcaps
    autocmd!
    au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Control_L'
augroup END
" Make an easier way to escape
inoremap jk <esc>
" vnoremap jk <esc>

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

" Quickly edit vimrc
nnoremap <silent> <leader>ev :vsplit $MYVIMRC<CR>
" Quickly source vimrc
nnoremap <silent> <leader>sv :source $MYVIMRC<CR>
" }}}

" Macros {{{

" to specify a macro, use something like below
" let @a='0fa'

" }}}

" Plugin config {{{

" Airline config
" let g:airline_theme='molokai'
" let g:airline_theme='behelit'
" let g:airline_theme='base16_google'
" let g:airline_theme='base16_isotope'
" let g:airline_theme='pencil'
let g:airline_theme='badwolf'
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

" Custom statusline function
function! AirlineInit()
    let g:airline_section_a = airline#section#create_left(['mode', 'branch'])
    let g:airline_section_b = airline#section#create_left(['%f'])
    let g:airline_section_c = airline#section#create(['filetype'])
    let g:airline_section_x = '%{strftime("%c")}'
    let g:airline_section_y = airline#section#create(['linenr','/%L'])
    let g:airline_section_z = airline#section#create_right(['%P','%c'])
endfunction

" Call custom statusline after airline init
" autocmd User AirlineAfterInit call AirlineInit()

" Ctrlp Config

" Search by filename instead of full path
" let g:ctrlp_by_filename = 0
" Try to jump to open instance if possible
" let g:ctrlp_switch_buffer = 'Et'
" Scan for dotfiles and dotdirs
let g:ctrlp_show_hidden = 1
" Follow symlinks
let g:ctrlp_follow_symlinks = 1
" Set working directory
let g:ctrlp_working_path_mode = 'ra'

" Deoplete config
if has('nvim')
    let g:deoplete#enable_at_startup = 1
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    "   Ignore case unless a capital letter is included
    let g:deoplete#enable_smart_case = 1
    "   Max number of suggestions
    let g:deoplete#max_list = 25
    " Decide how to complete, leave autocomplete for now
    " so we can use tab for snippets
    let g:deoplete#disable_auto_complete = 1
    " inoremap <silent><expr><C-n> deoplete#mappings#manual_complete()
    inoremap <silent><expr> <C-n>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<C-n>" :
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
    let g:neomake_go_enabled_markers = ['golint']
    let g:neomake_sh_enabled_markers = ['shellcheck']
    let g:neomake_java_enabled_markers = ['javac']
    let g:neomake_rust_enabled_markers = ['rustc']
    let g:neomake_c_enabled_makers = ['gcc']
    let g:neomake_cpp_gcc_maker = {
                \ 'args': ['-std=c++11']
                \}
    let g:neomake_cpp_enabled_makers = ['gcc']

    " Clojure completion
    " let g:deoplete#keyword_patterns = {}
    " let g:deoplete#keyword_patterns.clojure = '[\w!$%&*+/:<=>?@\^_~\-\.]*'

    " Clang completion
    let g:deoplete#sources#clang#libclang_path='/usr/lib/x86_64-linux-gnu/libclang.so'
    let g:deoplete#sources#clang#clang_header='/usr/lib/clang'

    " Rust completion
    let g:racer_cmd="/home/bradsherman/.cargo/bin/racer"
    let $RUST_SRC_PATH="~/.cargo/registry/src/github.com-1ecc6299db9ec823/racer-1.2.10/src/"

    " Java completion
    autocmd FileType java setlocal omnifunc=javacomplete#Complete
endif

" Git Gutter config
" highlight changed lines by default
" let g:gitgutter_highlight_lines = 1

" Markdown config
let g:vim_markdown_folding_disabled = 1

" Cpp highlight config
let c_no_curly_error = 1

" Snippets config
" Trigger config
let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Fugitive config
" Don't let fugitive make tons of buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" Codi config
let g:codi#interpreters = {
    \ 'sh': {
        \ 'bin': 'bash',
        \ 'prompt': '^$',
        \ },
    \ }
" }}}

" Make vim fold {{{
augroup Vim-Folds
    autocmd!
    " enable folding
    autocmd FileType vim set foldenable
    " open most folds by default
    autocmd FileType vim set foldlevelstart=10
    " 10 nested fold max
    autocmd FileType vim set foldnestmax=10
    " autocmd FileType vim set foldmethod=marker
    " autocmd FileType vim set foldlevel=0
    autocmd FileType vim set modelines=1
augroup END
" }}}
" Remove 'x' to enable folding
" xvim:foldmethod=marker:foldlevel=0
