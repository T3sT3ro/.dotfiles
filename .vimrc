
" ================================================================== Vundle

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line

Plugin 'mtdl9/vim-log-highlighting'
Plugin 'andreshazard/vim-logreview'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'preservim/nerdtree'
Plugin 'udalov/kotlin-vim'

call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ================================================================== Config

let g:airline_theme='lucius'

" displaying line numbers
set nu

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" highlighting searches
set hlsearch

" tabs to spaces
set shiftwidth=4
set tabstop=4
set expandtab

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
au FileType make set noexpandtab shiftwidth=8 softtabstop=0

" ensure normal tabs in assembly files
" and set to NASM syntax highlighting
au FileType asm set noexpandtab shiftwidth=8 softtabstop=0 syntax=nasm
au BufRead,BufNewFile *.g4 set syntax=antlr4

" set colors that look good on dark
set  background=dark

" darcula theme setup
syntax enable
colorscheme darcula


" set mouse mode by default, and fix it for tmux session to make panes
" draggable
set mouse+=a
if &term =~ '^screen'
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
endif

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

let g:NERDTreeWinPos = "right"


map <F2> :ls<CR>:e
nnoremap <A-S-Down> :m .+1<CR>==
nnoremap <A-S-Up> :m .-2<CR>==
inoremap <A-S-Down> <Esc>:m .+1<CR>==gi
inoremap <A-S-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-S-Down> :m '>+1<CR>gv=gv
vnoremap <A-S-Up> :m '<-2<CR>gv=gv
