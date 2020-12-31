""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               python functions                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! StrList()
python3 << EOF_
import vim
array = ", ".join([ '"' + x.strip() + '"' for x in vim.current.line.split() if x != '"' ])
vim.current.line = '[ ' + array + ' ]'
EOF_
endfunction
command! -nargs=0 -range Jlist call StrList()

function! StrListFromComma()
python3 << EOF_
import vim
array = ",".join([ '"' + x.strip() + '"' for x in vim.current.line.split(',') if x != '"' if x != "" ])
vim.current.line = '[ ' + array + ' ]'
EOF_
endfunction
command! -nargs=0 -range Jlistfromcomma call StrListFromComma()
