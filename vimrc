set nocompatible       "Prevents changing other options as side effects"
filetype off           "required

" Set runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'scrooloose/syntastic'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe'
Plugin 'flazz/vim-colorschemes'

" All plugins must be added before the following line
call vundle#end()
filetype plugin indent on


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

set hidden

set nowrap             "don't wrap lines"
set number     				 "relative line numbers
set showmatch          "show matching parenthesis"
set history=1000       "remember more commands and search history"
set undolevels=1000    "use many more levels of undo"
set visualbell         "don't beep"
set noerrorbells       "don't beep"
set title

" Configure tab settings
set tabstop=4
set shiftwidth=4
set softtabstop=4
set noexpandtab

set autoindent
set copyindent
set shiftwidth=4
set pastetoggle=<F2>
set backspace=2        "allow going back over line breaks

" Define colorscheme
"syntax enable
"set background=dark
"colorscheme solarized
syntax on
colorscheme molokai

if (&term == "iterm") || (&term == "putty")
	set background=dark
endif

" Quickly select the text that was just pasted. This allows you to, e.g.,
" indent it after pasting.
noremap gV `[v`]
" Stay in visual mode when indenting. You will never have to run gv after
" performing an indentation.
vnoremap < <gv
vnoremap > >gv
" Swap caps and escape when entering vim, undo on exit
au VimEnter * !xmodmap -e 'clear Lock' -e 'keycode 66 = Escape'
au VimLeave * !xmodmap -e 'clear Lock' -e 'keycode 66 = Control_L'

set shortmess=a
set cmdheight=2

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

" Disable arrow keys in Normal mode
map <up> <NOP>
map <down> <NOP>
map <right> <NOP>
map <left> <NOP>

" Make status bar appear all the time
set laststatus=2

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
