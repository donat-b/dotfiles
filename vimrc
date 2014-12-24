"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Highlight trailing whitespaces
match ErrorMsg '\s\+$'
