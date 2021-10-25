
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

" status line
set laststatus=2
set statusline+=%F

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

map <F2> :ls<CR>:e
nnoremap <A-S-Down> :m .+1<CR>==
nnoremap <A-S-Up> :m .-2<CR>==
inoremap <A-S-Down> <Esc>:m .+1<CR>==gi
inoremap <A-S-Up> <Esc>:m .-2<CR>==gi
vnoremap <A-S-Down> :m '>+1<CR>gv=gv
vnoremap <A-S-Up> :m '<-2<CR>gv=gv
