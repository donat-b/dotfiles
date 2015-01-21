""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
scriptencoding utf-8
set encoding=utf-8

" No compatability with vi
set nocompatible
" Enable syntax highlighting
syntax on
" Required by vundle
filetype off
" Set color scheme
colorscheme elflord
" Auto indent on a new line
set autoindent
" Tabs are expanded to spaces
set expandtab
set shiftwidth=2
set softtabstop=2

" Show extra whitespace
set list listchars=tab:>-

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Enable file-type specific plugins
filetype plugin on
" Enable file-type specific indenting
filetype indent on

Bundle 'tpope/vim-sensible'
Bundle 'vim-ruby/vim-ruby'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" F2 saves a file if necessary
nmap <F2> :update<CR>
vmap <F2> <Esc><F2>gv
imap <F2> <c-o><F2>

" Movement keys for dvorak
" qjkx
nnoremap q h
nnoremap Q H
nnoremap h x
nnoremap H X
nnoremap x l
nnoremap X L
nnoremap l q
nnoremap L Q

" Remove trailing whitespaces
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Run current script in shell
command R !./%

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight trailing whitespaces
match ErrorMsg '\s\+$'

" Leave insert mode on idle
au CursorHoldI * stopinsert
"au InsertEnter * let updaterestore=&updatetime | set updatetime=10000
"au InsertEnter * let &updatetime=updaterestore
