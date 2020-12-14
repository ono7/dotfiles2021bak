""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                   disabled code goes here for later review                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" function! GetSelectedText()
"   normal gv"xy
"   let result = getreg("x")
"   normal gv
"   return result
" endfunction

" ignore a couple of extensions...
" set wildignore+=*.a,*.o,*.pdf,*.avi,*.ttf,*.rst,*.otf,*.doc,*.docx
" set wildignore+=*.bmp,*.jpg,*.png,*.gif,*.m4a,*.db,*.snagproj
" set wildignore+=*.swp,*.mp4,*.mp3,*.avi,*.gz,*.tar,*.tgz,*.zip
" set wildignore+=*.swp,*.MP4,*.MP3,*.avi,*.JPG,*.xls,*.xlsx,*.pptx
" set wildignore+=*.dmg,*.vsd,*.vsdm,*.jar,*.cap,*.pcap,*.numbers,*.xmls
" set wildignore+=*.ppt,*.vss,*.plist,*.bz2,*.docx,*.DOC,*.data,*.dat
" set wildignore+=*.appcapture,*.cache,*.binarycookies,*.lock,*.cookies,*.collection
" set wildignore+=*.crash,*.wav,*.bin,*.svg
" set wildignore+=tmp/**,~/.tmp/**,*/Library/*


let s:hidden_all = 1
function! ToggleHiddenAll()
  " focus mode, hide almost everything
  if s:hidden_all  == 0
    let s:hidden_all = 1
    " set noshowmode
    set noruler
    " set nonumber
    set laststatus=0
    " set noshowcmd
  else
    let s:hidden_all = 0
    " set showmode
    set ruler
    " set number
    set laststatus=2
    " set showcmd
  endif
endfunction


" focus mode
nnoremap <silent><leader>h :call ToggleHiddenAll()<CR>



" if exists("plugs") && has_key(plugs, 'vim-commentary')
"   nnoremap <silent>gcc :<c-u>.,.+<c-r>=v:count<cr>call <SID>toggleComment()<cr>
"   nnoremap gc :<c-u>set opfunc=<SID>commentOp<cr>g@
"   xnoremap gc :call <SID>toggleComment()<cr>
" endif

  " Plug 'scrooloose/nerdtree',{ 'on': ['NERDTreeToggle', 'NERDTree', 'NERDTreeFind', 'NERDTreeClose'] }
  "    " close nerdtree when opening a file
  "    let NERDTreeQuitOnOpen = 1
  "    let NERDTreeMinimalUI = 1
  "    let NERDTreeDirArrows = 1
  "    let NERDTreeIgnore = ['\.pyc$', '\.egg-info$', '__pycache__', '__pycache__']
