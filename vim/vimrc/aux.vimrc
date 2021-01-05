""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                shellcode goodies                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" " remove spaces
" xmap <silent><leader>s s/\v\s+//ge<cr>

" remove any spaces and hexify (visual select)
xnoremap <silent><space>h :s/\v\s+//ge<cr><bar> :s/\v(..)/\\\x\1/ge<cr><bar> :s/\v.*/buffer \+\= b"&"/ge<cr>:noh<cr>

" remove any spaces and un-hexify (visual select)
xnoremap <silent>\h :s/\v\s+//ge<cr><bar> :s/\v\\x//ge<cr> :noh<cr>

" remove any spaces/shellcode
" nnoremap <silent><leader>s ^ :s/\v\s+//ge<cr><bar> :noh<cr>
xnoremap <silent><leader>s ^ :s/\v\s+//ge<cr><bar> :noh<cr>

" move to next missed spelled word and choose first suggesting
nnoremap <leader>s ]s1z=

cnoreabbrev Q! q!
cnoreabbrev Q1 q!
cnoreabbrev Q qall!
cnoreabbrev Qall qall
cnoreabbrev Qall! qall!
cnoreabbrev W w
cnoreabbrev W! w!
cnoreabbrev WQ wq
cnoreabbrev Wa wa
cnoreabbrev Wq wq
cnoreabbrev X! x!
cnoreabbrev X1 x!
cnoreabbrev bd1 bd!
cnoreabbrev Bd bd
cnoreabbrev q1 q!
cnoreabbrev qall1 qall!
cnoreabbrev qq q!
cnoreabbrev w1 w!
cnoreabbrev wQ wq

" dang it, tmux
imap <c-b> <nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              function mappings                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  " remove any spaces (visual select)
  " vnoremap <silent><leader>s ^ :s/\v\s+//ge<cr><bar> :noh<cr>

  " nnoremap <silent><leader>s ^ :s/\v\s+//ge<cr><bar> :noh<cr>

  " remove any spaces and hexify (visual select)
  " vnoremap <silent><leader>h :s/\v\s+//ge<cr><bar> :s/\v(..)/\\\x\1/ge<cr><bar> :s/\v.*/buffer \+\= b"&"/ge<cr>:noh<cr>
  " nnoremap <silent><leader>h :s/\v\s+//ge<cr><bar> :s/\v(..)/\\\x\1/ge<cr><bar> :s/\v.*/buffer \+\= b"&"/ge<cr>:noh<cr>

  " remove any spaces and un-hexify (visual select)
  " vnoremap <silent>\h :s/\v\s+//ge<cr><bar> :s/\v\\x//ge<cr> :noh<cr>
  " nnoremap <silent>\h :s/\v\s+//ge<cr><bar> :s/\v\\x//ge<cr> :noh<cr>


" attemp to throw away this bindings..
nmap \wa <Plug>Vimwiki2HTMLBrowse
nmap \wb <Plug>VimwikiRenameFile
nmap \wc <Plug>VimwikiDiaryIndex
nmap \wd <Plug>VimwikiDeleteFile
nmap \we <Plug>VimwikiTabIndex
nmap \wf <Plug>VimwikiUISelect
nmap \wg <Plug>VimwikiIndex
nmap \wh <Plug>Vimwiki2HTML
nmap \wj <Plug>VimwikiMakeYesterdayDiaryNote
nmap \wk <Plug>VimwikiMakeTomorrowDiaryNote
nmap \wl <Plug>VimwikiDiaryGenerateLinks
nmap \wm <Plug>VimwikiTabMakeDiaryNote
nmap \wn <Plug>VimwikiMakeDiaryNote
