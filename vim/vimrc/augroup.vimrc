" manual groups... this was the old way

" augroup _python
"   autocmd!
"   autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4
"         \ softtabstop=4 textwidth=0 nowrap
"   if has('nvim') && isdirectory(expand('~/.config/nvim/plugged'))
"     autocmd BufWritePre *.py silent! | retab | Neoformat
"   else
"     autocmd BufWritePre *.py silent! | retab
"   endif
"   " extra syntax rules in .dotfiles/vim_syntax
" augroup END

" augroup _set_lcd
"   " set local current directory per file as we enter the buffer
"   autocmd!
"   autocmd BufRead *
"       \ let s:tempPath=escape(escape(expand("%:p:h"), ' '), '\ ') |
"       \ exec "set path+=".s:tempPath
" augroup END

" augroup _cursor_last_position
"   " restore cursor position when entering file
"   autocmd!
"   autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
" augroup END

" augroup _remove_trailing_whitespace
"   autocmd!
"   autocmd BufWritePre * silent! :call <SID>StripTrailingWhitespaces()
" augroup END

" augroup _vim
"   autocmd!
"   autocmd FileType vim setlocal expandtab shiftwidth=2 tabstop=2
"         \ softtabstop=4 nowrap
"   autocmd BufWritePre *.vimrc,*.vim silent! | retab
" augroup END

" augroup _network_configs
"   autocmd!
"   autocmd BufNewFile,BufReadPost *.conf, *.config,*.cfg.bak,*.cfg.ori
"         \ set filetype=config
"   autocmd FileType config setlocal fo-=o
"   autocmd BufWritePre *.md silent! | retab
" augroup END

" augroup _assembly
"   autocmd!
"   autocmd filetypedetect BufNewFile,BufRead,BufEnter *.asm,*.nasm setfiletype nasm
"   autocmd FileType asm,nasm setlocal
"         \ nowrap commentstring=;\ %s
"   autocmd BufWritePre *.asm,*.nasm silent! | retab
" augroup END

" augroup _c_files
"   autocmd!
"   autocmd FileType c,c++ setlocal ai ts=4 sw=4 softtabstop=4 et fo+=c
"   autocmd BufWritePre *.cpp,*.h,*.c silent! | retab
" augroup END

" augroup _ansible
"   autocmd!
"   autocmd FileType yaml,yml,ansible setlocal ai ts=2 sw=2 et fo+=c
"   autocmd BufWritePre *.yml silent! | retab
" augroup END

" augroup _markdown
"   autocmd!
"   autocmd filetypedetect BufNewFile,BufRead,BufEnter *.md setfiletype markdown
"   autocmd filetype markdown setlocal ai ts=2 sw=2 et commentstring=###\ %s
"   autocmd BufNewFile,BufRead *.md set fo-=t textwidth=0
"   autocmd BufWritePre *.md silent! | retab
" augroup END


" augroup _ruby
"   autocmd!
"   autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2
"     \ softtabstop=2 nowrap re=1
" augroup END

" " run me last
" augroup _format_options_for_all_files
"   autocmd!
"   autocmd BufEnter * set fo-=c fo-=r fo-=o
" augroup END

