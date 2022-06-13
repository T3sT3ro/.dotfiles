
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

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" in makefiles, don't expand tabs to spaces, since actual tab characters are
" needed, and have indentation at 8 chars to be sure that all indents are tabs
" (despite the mappings later):
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

" ensure normal tabs in assembly files
" and set to NASM syntax highlighting
autocmd FileType asm set noexpandtab shiftwidth=8 softtabstop=0 syntax=nasm
au BufRead,BufNewFile *.g4 set syntax=antlr4


set statusline=
set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\ 

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
