
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                my status line                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set statusline=

" git status
" set statusline+=%1*%{_gitstatus()}
" set statusline+=%<\ %*
set statusline+=%<%*

" show file path
set statusline+=%{expand('%:h')}/

" and add file name
set statusline+=%*\%t

" file status, RO, RW
set statusline+=\ %m

" status line separator
" set statusline+=%1*%=
set statusline+=%<%=

" file encoding
" set statusline+=\ %{(&fenc!=''?&fenc:&enc)}

" filetype
set statusline+=%1*\〈\ %Y

" CurrentLine/TotalLines
set statusline+=\〈\ %2l/%L
set statusline+=:

" Column number
set statusline+=%2c

" file percentage
set statusline+=\ %P%*

" hi User1 ctermbg=NONE ctermfg=8 guibg=NONE guifg=#5c6370 gui=BOLD
" hi User2 ctermbg=NONE ctermfg=244 guibg=NONE guifg=#5c6370
