""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                vim functions                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! NerdTreeToggleFind()
  if exists("g:NERDTree") && g:NERDTree.IsOpen()
    NERDTreeClose
  elseif filereadable(expand('%'))
    NERDTreeFind
  else
    NERDTree
  endif
endfunction

function! FZFOpen(command_str)
  " prevents nerdtree window from being used when opening files through fzf search
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
    setlocal noincsearch
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  %s#\($\n\s*\)\+\%$##e
  call cursor(l, c)
endfunction
command! RemoveTrailingWhiteSpaces call <SID>StripTrailingWhitespaces()

function! CopyMatches(reg)
  " copy matches to main clipboard :CopyMatches *
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/gne
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register JcopyMatches call CopyMatches(<q-reg>)
