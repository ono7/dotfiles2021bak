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
" noreabbrev Flase False
" noreabbrev accross across
" noreabbrev anotehr another
" noreabbrev becuase because
" noreabbrev corected corrected
" noreabbrev fro for
" noreabbrev waht what
" noreabbrev healt health
" noreabbrev initilise initialize
" noreabbrev initilize initialize
" noreabbrev lenght length
" noreabbrev lenhgt length
" noreabbrev mitake mistake
" noreabbrev shoudl should
" noreabbrev taht that
" noreabbrev teh the
" noreabbrev whlie while
" noreabbrev yeild yield
" noreabbrev yiedl yield
" noreabbrev pythno python

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
