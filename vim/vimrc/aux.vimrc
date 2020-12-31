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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                           bad spelling support :(                            "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" noreabbrev
noreabbrev Flase False
noreabbrev accross across
noreabbrev anotehr another
noreabbrev becuase because
noreabbrev corected corrected
noreabbrev fro for
noreabbrev waht what
noreabbrev healt health
noreabbrev initilise initialize
noreabbrev initilize initialize
noreabbrev lenght length
noreabbrev lenhgt length
noreabbrev mitake mistake
noreabbrev shoudl should
noreabbrev taht that
noreabbrev teh the
noreabbrev whlie while
noreabbrev yeild yield
noreabbrev yiedl yield
noreabbrev pythno python

" dang it, tmux
imap <c-b> <nop>

hi! TermCursorNC guibg=Purple guifg=white ctermbg=1 ctermfg=15
hi! trans guibg=Purple guifg=white ctermbg=1 ctermfg=15

if g:colors_name == "onehalfdark"

  hi!  Red     ctermfg=1    guifg=#e06c75
  hi!  Green   ctermfg=2    guifg=#56b6c2
  hi!  Yellow  ctermfg=3    guifg=#e5c07b
  hi!  Blue    ctermfg=4    guifg=#61afef
  hi!  Purple  ctermfg=5    guifg=#b67fd1
  hi!  Aqua    ctermfg=6    guifg=#56b6c2
  hi!  Orange  ctermfg=208  guifg=#e78a4e

  hi!  RedItalic      cterm=italic  gui=italic  ctermfg=1  guifg=#e06c75
  hi!  OrangeItalic   cterm=italic  gui=italic  ctermfg=208  guifg=#e78a4e
  hi!  YellowItalic   cterm=italic  gui=italic  ctermfg=3  guifg=#e5c07b
  hi!  GreenItalic    cterm=italic  gui=italic  ctermfg=2  guifg=#a9b665
  hi!  AquaItalic     cterm=italic  gui=italic  ctermfg=6  guifg=#7daea3
  hi!  BlueItalic     cterm=italic  gui=italic  ctermfg=4  guifg=#61afef
  hi!  PurpleItalic   cterm=italic  gui=italic  ctermfg=5  guifg=#b67fd1
  hi!  NormalItalic   cterm=italic  gui=italic  ctermfg=223  guifg=#d4be98
  hi!  CommentItalic  cterm=italic  gui=italic  ctermfg=245  guifg=#5c6370
  hi!  RedBold        cterm=bold    gui=bold    ctermfg=1  guifg=#e06c75
  hi!  OrangeBold     cterm=bold    gui=bold    ctermfg=208  guifg=#e78a4e
  hi!  YellowBold     cterm=bold    gui=bold    ctermfg=3  guifg=#d8a657
  hi!  GreenBold      cterm=bold    gui=bold    ctermfg=2  guifg=#98c379
  hi!  AquaBold       cterm=bold    gui=bold    ctermfg=6  guifg=#89b482
  hi!  BlueBold       cterm=bold    gui=bold    ctermfg=4  guifg=#61afef
  hi!  PurpleBold     cterm=bold    gui=bold    ctermfg=5  guifg=#b67fd1
  hi!  NormalBold     cterm=bold    gui=bold    ctermfg=223  guifg=#dcdfe4
  hi!  CommentBold    cterm=bold    gui=bold    ctermfg=245  guifg=#95c637

  hi!  CursorLineNr   ctermfg=246  ctermbg=NONE   guifg=#a89984  guibg=NONE
  hi!  Folded         ctermfg=245  ctermbg=NONE   guifg=#95c637  guibg=NONE
  hi!  Cursor         gui=NONE     cterm=NONE     ctermbg=208    ctermfg=1      guifg=#1d2021  guibg=#e78a4e
  hi!  MsgArea        ctermfg=246  ctermbg=NONE   guifg=#9297a1  guibg=NONE
  hi!  Pmenu          ctermbg=235  ctermfg=8      guibg=#313640  guifg=#9297a1
  hi!  PmenuSel       ctermbg=239  ctermfg=7      guibg=#313640  guifg=#9297a1  gui=reverse
  hi!  CommentNormal  ctermfg=8    guifg=#95c637
  hi!  Visual         ctermfg=234  ctermbg=5      guifg=NONE     guibg=#3e4451
  hi!  Search         ctermfg=234  ctermbg=5      guifg=NONE     guibg=#3e4451
  hi!  IncSearch      ctermfg=234  ctermbg=5      guifg=NONE     guibg=#3a5286

  " gutter
  hi!  SignColumn  ctermfg=223   ctermbg=NONE   guifg=#d4be98  guibg=NONE
  hi!  RedSign     ctermfg=1     ctermbg=NONE   guifg=#e06c75  guibg=NONE
  hi!  YellowSign  ctermbg=NONE  guifg=#e5c07b  guibg=NONE
  hi!  BlueSign    ctermfg=4     ctermbg=NONE   guifg=#61afef  guibg=NONE
  hi!  link        lineNr        Comment

  " markdown
  hi!  link  markdownH1             GreenBold
  hi!  link  markdownH2             BlueBold
  hi!  link  markdownH3             OrangeBold
  hi!  link  markdownH4             PurpleBold
  hi!  link  markdownH5             YellowBold
  hi!  link  markdownH6             RedBold
  hi!  link  markdownUrl            PurpleBold
  hi!  link  markdownCodeDelimiter  Comment
  hi!  link  VimwikiHeader1         markdownH1
  hi!  link  VimwikiHeader2         markdownH2
  hi!  link  VimwikiHeader3         markdownH3
  hi!  link  VimwikiHeader4         markdownH4
  hi!  link  VimwikiHeader5         markdownH5
  hi!  link  VimwikiHeader6         markdownH6
  hi!  link  VimwikiPre             Comment
  hi!  link  VimwikiLink            Purple
  hi!  link  ALEWarningSign         Yellow
  hi!  link  ALEErrorSign           YellowBold
  hi!  link  Repeat                 RedItalic
  hi!  link  Conditional            PurpleItalic
  hi!  link  EndOfBuffer            Comment
  hi!  VertSplit ctermbg=NONE guibg=NONE

  silent!  syn  clear  Normal
  silent!  syn  clear  Comment

  hi!  Normal   ctermbg=0  guibg=none     guifg=none
  hi!  Comment  ctermfg=8  guifg=#5c6370

endif

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

" ========== convert Strings to Hex ==========

function! StrPad(payload, n_times)
python3 << EOF_

import vim

payload = vim.eval('a:payload')
n_times = vim.eval('a:n_times')

vim.current.line = vim.current.line + payload * int(n_times)

EOF_
endfunction
command! -nargs=* JStrPad call StrPad(<f-args>)

" ========== convert Strings to Hex ==========

function! Str2Hex(payload)
python3 << EOF_

import vim

payload = vim.eval('a:payload')

if payload == "dummypayload":
  vim.current.line = vim.current.line.encode('utf-8').hex().strip()
else:
  print(payload.encode('utf-8').hex().strip())

EOF_
endfunction
command! -nargs=* -range JstrToHex call Str2Hex('dummypayload')

" ========== convert Hex to Strings ==========

function! Hex2Str(payload)
python3 << EOF_

import vim
import binascii

payload = vim.eval('a:payload')

if payload == "dummypayload":
  vim.current.line = binascii.unhexlify(vim.current.line.replace('0x',''))
else:
  print(binascii.unhexlify(payload))

EOF_
endfunction
command! -nargs=* -range Jhex2str call Hex2Str('dummypayload')

" ========== Reverse text ==========

function! Rev(size)
python3 << EOF_

import vim

print(vim.eval('a:size'))
step_size = vim.eval('a:size')

if step_size == 'default':
  vim.current.line = vim.current.line[::-1]
else:
  step_size = int(step_size)
  unpack_list = [ vim.current.line[x:x+step_size] for x in range(0, len(vim.current.line), step_size)]
  vim.current.line = "".join(unpack_list[::-1])

EOF_
endfunction
command! -nargs=1 -range JRev call Rev(<args>)

" ========== count whatever in increments of whatever ==========

function! Count(size)
python3 << EOF_

import vim

print(vim.eval('a:size'))
step_size = vim.eval('a:size')

step_size = int(step_size)
unpack_list = [ vim.current.line[x:x+step_size] for x in range(0, len(vim.current.line), step_size) if x != ""]
vim.current.line = vim.current.line + " len: " + str(len(unpack_list))

EOF_
endfunction
command! -nargs=1 -range JCount call Count(<args>)

" ========== hex math ==========
" add or subtract two hex values in one line

function! HexMath()
python3 << EOF_

import vim

def from_hex(hexdigits):
    # converts or filters string to hex
    try:
      return int(hexdigits, 16)
    except Exception as e:
      pass
    return False

array = [ x.strip() for x in vim.current.line.split() if from_hex(x)]

if '+' in vim.current.line:
  result = hex(from_hex(array[0]) + from_hex(array[1]))

if '-' in vim.current.line:
  result = hex(from_hex(array[0]) - from_hex(array[1]))

vim.current.line = vim.current.line + ' = ' + str(result).replace("0x","")

EOF_
endfunction
command! -nargs=0 -range JHexMath call HexMath()

function! Hex2dec()
python3 << EOF_
import vim

clean_line = vim.current.line.replace('0x', '')
vim.current.line = str(int(clean_line, 16))

EOF_
endfunction
command! -nargs=? -range Jhex2dec call Hex2dec()

function! Dec2hex()
python3 << EOF_
import vim

vim.current.line = hex(int(vim.current.line))

EOF_
endfunction
command! -nargs=? -range Jdec2hex call Dec2hex()

function! ToAscii()
python3 << EOF_
import vim

vim.current.line = " ".join([ str(ord(x)) for x in vim.current.line if x != '' ])

EOF_
endfunction
command! -nargs=? -range Jtoascii call ToAscii()

function! FromAscii()
python3 << EOF_
import vim
import re

l = vim.current.line.split()
vim.current.line = "".join([chr(int(x)) for x in l if x != ''])

EOF_
endfunction
command! -nargs=? -range JfromAscii call FromAscii()

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
