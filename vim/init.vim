" Follow the white rabbit...
"
" ~/.fzf/install (setup keybindings)
"
" >>> for the weak vim versions <<<
"
" set nocompatible
" filetype plugin indent on
" inoremap jk <Esc>
" if has('syntax')
"   syntax on
" endif
" set number
" set magic
" set nobackup nowritebackup noswapfile
" set nowrap
" set smartcase
" set smartindent
" set smarttab
" set autoindent
" set softtabstop=2
" set tabstop=2 shiftwidth=2 expandtab
" set hlsearch
" set so=999
" nnoremap / mM/\v xnoremap / mM/\v
" nnoremap ? mM?\v
" xnoremap ? mM?\v
" nnoremap 's `S
" nnoremap 'a `A
" nnoremap 'b `B
" nnoremap 'm `M
" nnoremap 'v `V
" nnoremap ss mS
" nnoremap sa mA
" nnoremap sb mB
" nnoremap gg mMgg
" nnoremap G mMG
" nnoremap cw ciw
" nnoremap cW ciW
" nnoremap yw yiw
" nnoremap yW yiW
" xnoremap w iw
" xnoremap W iW
" nnoremap gd mMgd
" nnoremap * mM*
" nnoremap # mM#
" cmap %s %s/\v
" cmap %g %g/\v
" cmap %v %v/\v
" nnoremap cp yap<S-}>p
" nnoremap Q @q
" xnoremap Q :'<,'>norm @q<cr>
" nnoremap vp vip
" nmap k gk
" nmap j gj
" nnoremap <silent><leader>w :w<CR>
" autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" disable ex mode
nnoremap Q <Nop>
nnoremap gQ <Nop>

if has('vim_starting')
  set nocompatible
endif

let mapleader = " "

if has('nvim')
  set inccommand=nosplit
  set signcolumn=yes
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  tnoremap jk <C-\><C-n>
endif

if v:version >= 800
  set nobreakindent
endif

" performace tweaks
" let loaded_matchparen = 0
" let g:matchparen_timeout = 10
" let g:matchparen_insert_timeout = 10

filetype off

" auto install plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if !empty(glob('~/.vim/autoload/plug.vim'))

  " ondemand loading for filetypes = 'for', load on commands = 'on'
  call plug#begin('~/.config/nvim/plugged')

    " Plug 'sonph/onehalf', {'rtp': 'vim/'}
    if has('nvim')
      Plug 'bfredl/nvim-miniyank'
      Plug 'SirVer/ultisnips'
    endif

    Plug 'neoclide/coc.nvim', {'branch': 'release',
          \ 'for' : ['python', 'yaml', 'jinja', 'ansible',
          \ 'json', 'javascript', 'css', 'markdown', 'typescript',
          \ 'terraform', 'cs', 'lua', 'vimwiki']}
      let g:coc_global_extensions = ['coc-python', 'coc-json', 'coc-tsserver', 'coc-prettier', 'coc-omnisharp', 'coc-lua']
    Plug 'davidhalter/jedi-vim', { 'for' : ['python'] }
      " use all the beautiful things jedi-vim offers, but leave completion to coc
      let g:jedi#completions_enabled = 0
      let g:jedi#goto_assignments_command = ""
    Plug 'christoomey/vim-tmux-navigator'
      let g:tmux_navigator_disable_when_zoomed = 1
    Plug 'jiangmiao/auto-pairs'
      let g:AutoPairsUseInsertedCount = 0
      let g:AutoPairsFlyMode = 0
      let g:AutoPairsShortcutFastWrap='<C-e>'
      let g:AutoPairsShortcutBackInsert = '<C-b>'
    Plug 'Yggdroot/indentLine', { 'on' : ['IndentLinesToggle','IndentLinesEnable']}
    Plug 'Glench/Vim-Jinja2-Syntax', { 'for' : 'jinja' }
    if isdirectory('/usr/local/opt/fzf')
      " use Ripgrep (Rg) for best experience
      Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
    else
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
      Plug 'junegunn/fzf.vim'
    endif
    Plug 'ervandew/supertab'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-markdown', {'for' : 'markdown'}
    Plug 'scrooloose/nerdtree',{ 'on': ['NERDTreeToggle', 'NERDTree', 'NERDTreeFind', 'NERDTreeClose'] }
      " close nerdtree when opening a file
      let NERDTreeQuitOnOpen = 1
      let NERDTreeMinimalUI = 1
      let NERDTreeDirArrows = 1
      let NERDTreeIgnore = ['\.pyc$', '\.egg-info$', '__pycache__', '__pycache__']
    Plug 'dense-analysis/ale', { 'for' : ['yaml', 'python', 'javascript', 'typescript', 'json', 'ruby', 'cs'] }
    " Plug 'hashivim/vim-terraform', { 'for' : ['terraform'] }
      " let g:terraform_align=1
      " let g:terraform_fmt_on_save=1
    " Plug 'vimwiki/vimwiki', { 'for' : 'vimwiki' }
    Plug 'vimwiki/vimwiki'
      let g:vimwiki_table_mappings = 0
      let wiki = {}
      let wiki.path = 'wiki'
      let wiki.nested_syntaxes = {'python': 'python', 'cpp': 'cpp', 'php': 'php',
            \ 'javascript': 'javascript', 'bash' : 'sh', 'lua' : 'lua'}
      let g:vimwiki_list = [wiki]
  call plug#end()
endif

filetype plugin indent on

syntax on

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                  MacOS | Unix/Linux/Win32 | :h feature=list                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("mac") || has("macunix") || has("unix")

  let g:loaded_ruby_provider = 0
  let g:loaded_python_provider = 1
  let g:python3_host_prog = $HOME."/.virtualenvs/prod3/bin/python3"

  set synmaxcol=0
  syntax sync minlines=200
  syntax sync maxlines=300
  " fix syntax on large files
  let g:vimsyn_embed='0'

  if has('termguicolors')
    set termguicolors
    set background=dark
    colorscheme onehalfdark
  else
    set t_Co=256
    set background=dark
    " colorscheme gruvbox-material
    colorscheme onehalfdark
  endif
else
  set t_Co=256
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               python functions                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('nvim')

highlight! TermCursorNC guibg=Purple guifg=white ctermbg=1 ctermfg=15
highlight! trans guibg=Purple guifg=white ctermbg=1 ctermfg=15

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

endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                vim functions                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! s:commentOp(...)
  '[,']call s:toggleComment()
endfunction

function! s:toggleComment() range
    let comment = substitute(get(b:, 'commentstring', &commentstring), '\s*\(%s\)\s*', '%s', '')
    let pattern = '\V' . printf(escape(comment, '\'), '\(\s\{-}\)\s\(\S\.\{-}\)\s\=')
    let replace = '\1\2'
  if getline('.') !~ pattern
    let indent = matchstr(getline('.'), '^\s*')
    let pattern = '^' . indent . '\zs\(\s*\)\(\S.*\)'
    let replace = printf(comment, '\1 \2' . (comment =~ '%s$' ? '' : ' '))
  endif
  for lnum in range(a:firstline, a:lastline)
    call setline(lnum, substitute(getline(lnum), pattern, replace, ''))
  endfor
endfunction

" Toggle Vexplore (vanilla vim file browser)
function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        let cur_win_num = winnr()

        if expl_win_num != -1
            while expl_win_num != cur_win_num
                exec "wincmd w"
                let cur_win_num = winnr()
            endwhile
            close
        endif
        unlet t:expl_buf_num
    else
         Vexplore
         let t:expl_buf_num = bufnr("%")
    endif
endfunction

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  autogroup                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup _enter
  autocmd!
  autocmd BufEnter * silent! lcd %:p:h
  " autocmd BufEnter * :syntax sync maxlines=200
  " restore last known position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  autocmd VimEnter * command! -bang -nargs=? GFiles call fzf#vim#gitfiles(<q-args>, {'options': '--no-preview'}, <bang>0)
  autocmd VimEnter * command! -bang -nargs=? Files call fzf#vim#files(<q-args>, {'options': '--no-preview'}, <bang>0)
augroup END

augroup _writepre
  " autocmd BufEnter * silent! lcd %:p:h
  autocmd BufWritePre * silent! :call <SID>StripTrailingWhitespaces() | retab
augroup END

augroup _other
  autocmd FileType * set formatoptions-=cro fo+=j
  autocmd BufNewFile,BufRead,BufEnter *.asm,*.nasm setfiletype nasm
  autocmd BufNewFile,BufRead,BufEnter *.yml,*.yaml setfiletype ansible.yaml
  autocmd BufNewFile,BufRead,BufEnter *.wiki setfiletype vimwiki
  autocmd BufNewFile,BufRead,BufEnter *.ejs setfiletype html
augroup END

augroup _filetype
  autocmd FileType * set formatoptions-=cro fo+=j
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                shellcode goodies                             "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" remove any spaces (visual select)
xmap <silent><leader>s s/\v\s+//ge<cr>

" nnoremap <silent><leader>s ^ :s/\v\s+//ge<cr><bar> :noh<cr>

" remove any spaces and hexify (visual select)
xnoremap <silent><space>h :s/\v\s+//ge<cr><bar> :s/\v(..)/\\\x\1/ge<cr><bar> :s/\v.*/buffer \+\= b"&"/ge<cr>:noh<cr>
" nnoremap <silent><space>h :s/\v\s+//ge<cr><bar> :s/\v(..)/\\\x\1/ge<cr><bar> :s/\v.*/buffer \+\= b"&"/ge<cr>:noh<cr>

" remove any spaces and un-hexify (visual select)
xnoremap <silent>\h :s/\v\s+//ge<cr><bar> :s/\v\\x//ge<cr> :noh<cr>
" nnoremap <silent>\h :s/\v\s+//ge<cr><bar> :s/\v\\x//ge<cr> :noh<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               plugin variables                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" lua hi
let g:vimsyn_embed = 'l'

if executable('~/local/node/bin/nodenode')
  " coc.vim
  let g:coc_node_path = '~/local/node/bin/node'
endif

let g:vim_markdown_folding_disabled = 1

" Plug 'dense-analysis/ale'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '(%code%): %s'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_sign_warning = '⚠'
let g:ale_sign_error = '◎'
" let g:ale_sign_error = '✘'
" let g:ale_sign_error = '◉'
let g:ale_sign_offset = 1000000
let g:ale_virtualtext_cursor = 0
let g:ale_warn_about_trailing_blank_lines = 0
let b:ale_warn_about_trailing_whitespace = 0
let g:ale_fixers = {
      \ 'javascript': ['eslint'],
      \}
let g:ale_linters = {
      \ 'ansible.yaml' : ['yamllint', 'ansible_lint'],
      \ 'javascript' : ['eslint'],
      \ 'python' : ['pylint'],
      \}

let g:asmsyntax = 'nasm'

" Plug 'tpope/vim-markdown'
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'nasm', 'vim', 'php', 'javascript', 'lua', 'sql']

" disable system conceal
let g:markdown_syntax_conceal = 0

" 1 = show if 2 files, 2 = always, 0 = disable
let g:buftabline_show = 0

let g:SuperTabDefaultCompletionType = "<C-n>"
let g:SuperTabClosePreviewOnPopupClose = 1

" Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories=['~/.config/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion = 3

" let g:indentLine_color_term = 239
let g:indentLine_char = "‧"
let g:indentLine_color_term = 8
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 2
let g:indentLine_fileTypeExclude = ['text', 'markdown']
let g:indentLine_enabled = 0

" Plug 'junegunn/fzf.vim'
" width: float range [0 ~ 1]
" height: float range [0 ~ 1]
" Optional
"
" yoffset: float default 0.5 range [0 ~ 1]
" xoffset: float default 0.5 range [0 ~ 1]
" highlight: [string]: Highlight group for border
" border: [string default rounded]: Border style
" Avaliable Border Style -> rounded: / sharp / horizontal / vertical / top / bottom / left / right

hi! fzf_info ctermfg=6
hi! fzf_bg ctermfg=0 guifg=#282c34
hi! fzf_bg_plus ctermbg=237 guibg=#313640
hi! fzf_spinner ctermfg=6

let g:fzf_layout = { 'window': { 'width': 1, 'height': 1, 'highlight': 'Comment', 'border' : 'bottom' } }
let g:fzf_history_dir = '~/.tmp/fzf-history'
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_nvim_statusline = 1

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Comment'],
  \ 'hl':      ['fg', 'RedBold'],
  \ 'fg+':     ['fg', 'GreenBold'],
  \ 'bg+':     ['bg', 'fzf_bg_plus'],
  \ 'hl+':     ['fg', 'PurpleBold'],
  \ 'info':    ['fg', 'fzf_info'],
  \ 'prompt':  ['fg', 'BlueBold'],
  \ 'pointer': ['fg', 'RedBold'],
  \ 'gutter': ['fg', 'fzf_bg'],
  \ 'spinner': ['fg', 'fzf_spinner'] }

" better netrw view (vanilla vim file browser)
let g:netrw_list_hide = &wildignore
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split=4
let g:netrw_winsize = 20
let g:netrw_fastbrowse = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   bindings                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" nnoremap <silent><leader>gn :e notes.md<CR>
if exists("plugs")

  if has_key(plugs, 'nerdtree')
    nnoremap <silent><C-e> :call NerdTreeToggleFind()<CR>
  else
    nnoremap <silent><C-e> :call ToggleVExplorer()<CR>
  endif

  if has_key(plugs, 'fzf') && has_key(plugs, 'fzf.vim')
    nnoremap <silent><C-p> :call FZFOpen(':GFiles')<CR>
    nnoremap <silent><leader>f :call FZFOpen(':Files')<CR>
    " nnoremap <silent><C-s> :call FZFOpen(':Rg')<CR>
    " nnoremap <silent><leader>l :call FZFOpen(':Lines')<CR>
    nnoremap <silent><leader>b :call FZFOpen(':Buffers')<CR>

  else
    nnoremap <leader>f :call ToggleVExplorer()<CR>
  endif

  if has_key(plugs, 'coc.nvim')
    nmap <silent> gr <Plug>(coc-references)
    " trigger completion, manually
    inoremap <silent><expr> <C-c> coc#refresh()
  endif

  if has_key(plugs, 'vim-surround')
    nmap s  <Plug>Ysurround
    nmap S  <Plug>YSurround
    nmap sw siW
  endif

  if has_key(plugs, 'ale')
    nmap <silent> [n <Plug>(ale_next_wrap)
    nmap <silent> ]n <Plug>(ale_previous_wrap)
  endif

  if has_key(plugs, "nvim-miniyank")
    map p <Plug>(miniyank-autoput)
    map P <Plug>(miniyank-autoPut)
    let g:miniyank_filename = $HOME.'/.tmp/miniyank-shared-ring'
    let g:miniyank_maxitems = 1
  endif

endif

if &diff
    set cursorline
    map ] ]n
    map [ [n
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                core bindings                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" open todo.md
" nnoremap <silent><leader>t :!ctags -R -f ~/.tags . <CR><c-g>

" find syntax group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" diable c-z (bg)
nnoremap <c-z> <nop>

"disable ex-mode
cnoremap <c-f> <nop>

" clone paragraph
nnoremap cp yap<S-}>p

nnoremap Q @q
xnoremap Q :'<,'>norm @q<cr>

nnoremap vp vip

" create list from visual select and normal mode -> single line
" xnoremap <C-l> :s/\v\s+$//ge<cr>gv :s/\v^(.+)$/"\1",/ge<cr>gvJ :noh<cr>

nnoremap <leader>ve :e $MYVIMRC<cr>
nnoremap <leader>vr :source $MYVIMRC<cr>

inoremap jk <Esc><c-g>

" highlight last inserted text
" nnoremap gv `[v`]
nnoremap gv v`[

" move better around line wraps
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

nnoremap <silent>i :noh<cr>i
nnoremap <silent>I :noh<cr>I
nnoremap <silent>o :noh<cr>o
nnoremap <silent>O :noh<cr>O
nnoremap <silent>A :noh<cr>A
nnoremap <silent><enter> :noh<cr>

" tmux send-kyes up and enter, *repeat last command*
nnoremap <silent><leader>t :silent !tmux send-keys -t 2 c-p Enter<cr>

nnoremap H ^<c-g>
nnoremap L $<c-g>
xnoremap H ^<c-g>
xnoremap L $<c-g>

" more natural re-do command
nnoremap U <C-r>

" nnoremap <silent><C-r> :e<cr>

cnoremap w!! w !sudo tee % > /dev/null
cnoremap %s %s/\v
cnoremap %g %g/\v
cnoremap %v %v/\v

" improved workflow with marks
nnoremap / mM/\v
xnoremap / mM/\v
nnoremap ? mM?\v
xnoremap ? mM?\v
nnoremap 's `S
nnoremap 'a `A
nnoremap 'b `B
nnoremap 'm `M
nnoremap 'v `V
nnoremap ss mS
nnoremap sa mA
nnoremap sb mB
nnoremap gg mMgg<c-g>
nnoremap G mMG<c-g>

nnoremap cw ciw
nnoremap cW ciW
nnoremap yw yiw
nnoremap yW yiW
xnoremap w iw
xnoremap W iW
nnoremap gd mMgd
nnoremap * mM*
nnoremap # mM#

" speed up common buffer operations
nnoremap <silent><leader>w :w<CR>
nnoremap <silent><leader>q :q<CR>
nnoremap <silent><Tab> :bnext<CR>
nnoremap <silent><S-Tab> :bprevious<CR>

" remove any spaces/shellcode
" nnoremap <silent><leader>s ^ :s/\v\s+//ge<cr><bar> :noh<cr>
xnoremap <silent><leader>s ^ :s/\v\s+//ge<cr><bar> :noh<cr>

nnoremap Y y$

" move cursor to the end of prev changed or yanked text
" vmap y ygv<esc>

" select visualy selected text for search
xnoremap <enter> y/\V<C-r>=escape(@",'/\')<CR><CR>

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     set                                      "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoindent
set autoread
set backspace=indent,eol,start
set cmdheight=2
set complete-=i complete-=t
set completeopt-=preview
set diffopt=filler
set directory=~/.tmp
set display+=lastline
set encoding=utf-8 nobomb
set expandtab
set fileencoding=utf-8
set fillchars+=vert:│
set hidden
set history=999
set ignorecase
set incsearch
set laststatus=0
set magic
set nobackup nowritebackup noswapfile
set nojoinspaces
set nolist
set novisualbell noerrorbells
set nowrap
set nrformats-=octal
set numberwidth=3
set pastetoggle=<F2>
set ruler
set scrolloff=999
set shiftround
set shiftwidth=2
set shortmess=atIoOsT
set shortmess+=c
set showmode
set noshowcmd
set sidescrolloff=1
set smartcase
" set smartindent
set smarttab
set softtabstop=2
set tabstop=2
set spelllang=en_us
set splitbelow
set textwidth=80
set timeout timeoutlen=500 ttimeout ttimeoutlen=50
set undolevels=999
set updatetime=250
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__/*
set winaltkeys=no
set complete+=kspell

" performance settings
set lazyredraw
set matchtime=0
set nocursorcolumn
set nocursorline
set redrawtime=10000
set ttyfast
set re=1

" pmenu/transparency/items
set pumheight=12
set pumblend=5

" fixes issues with extra lines in EOF
set fixendofline

if has('folding')
  set foldlevel=1
  set foldmethod=indent
  set foldnestmax=2
  set nofoldenable
endif
set fileformats=unix

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              CLIPBOARD SUPPORT                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" requires -> export DISPLAY=:0.0 on zshrc

" if exists('$TMUX')
if has('macunix')
  let clip_copy = 'pbcopy'
  let clip_paste = 'pbpaste'
else
  let clip_copy = 'xclip -sel clip -i'
  let clip_paste= 'xclip -out -selection clipboard'
endif
let g:clipboard = {
      \   'name': 'limaClipboard',
      \   'copy': {
      \      '+': clip_copy,
      \      '*': 'tmux load-buffer -'
      \    },
      \   'paste': {
      \      '+': clip_paste,
      \      '*': 'tmux save-buffer -'
      \   },
      \   'cache_enabled': 1
      \ }
" endif

if has('unnamedplus')
  set clipboard=unnamed
  set clipboard+=unnamedplus
else
  set clipboard=unnamed
endif

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

if g:colors_name == "onehalfdark"

  hi!  Red     ctermfg=167  guifg=#e06c75
  hi!  Orange  ctermfg=208  guifg=#e78a4e
  hi!  Yellow  ctermfg=214  guifg=#e5c07b
  hi!  Blue    ctermfg=109  guifg=#61afef
  hi!  Purple  ctermfg=175  guifg=#b67fd1
  hi!  Aqua    guifg=#56b6c2

  hi!  RedItalic      cterm=italic  gui=italic  ctermfg=167  guifg=#e06c75
  hi!  OrangeItalic   cterm=italic  gui=italic  ctermfg=208  guifg=#e78a4e
  hi!  YellowItalic   cterm=italic  gui=italic  ctermfg=214  guifg=#e5c07b
  hi!  GreenItalic    cterm=italic  gui=italic  ctermfg=142  guifg=#a9b665
  hi!  AquaItalic     cterm=italic  gui=italic  ctermfg=108  guifg=#7daea3
  hi!  BlueItalic     cterm=italic  gui=italic  ctermfg=109  guifg=#61afef
  hi!  PurpleItalic   cterm=italic  gui=italic  ctermfg=175  guifg=#b67fd1
  hi!  NormalItalic   cterm=italic  gui=italic  ctermfg=223  guifg=#d4be98
  hi!  CommentItalic  cterm=italic  gui=italic  ctermfg=245  guifg=#5c6370
  hi!  RedBold        cterm=bold    gui=bold    ctermfg=167  guifg=#e06c75
  hi!  OrangeBold     cterm=bold    gui=bold    ctermfg=208  guifg=#e78a4e
  hi!  YellowBold     cterm=bold    gui=bold    ctermfg=214  guifg=#d8a657
  hi!  GreenBold      cterm=bold    gui=bold    ctermfg=142  guifg=#98c379
  hi!  AquaBold       cterm=bold    gui=bold    ctermfg=108  guifg=#89b482
  hi!  BlueBold       cterm=bold    gui=bold    ctermfg=109  guifg=#61afef
  hi!  PurpleBold     cterm=bold    gui=bold    ctermfg=175  guifg=#b67fd1
  hi!  NormalBold     cterm=bold    gui=bold    ctermfg=223  guifg=#dcdfe4
  hi!  CommentBold    cterm=bold    gui=bold    ctermfg=245  guifg=#95c637

  hi!  CursorLineNr   ctermfg=246  ctermbg=NONE   guifg=#a89984  guibg=NONE
  hi!  Folded         ctermfg=245  ctermbg=NONE   guifg=#95c637  guibg=NONE
  hi!  Cursor         gui=NONE     cterm=NONE     ctermbg=208    ctermfg=167    guifg=#1d2021  guibg=#e78a4e
  hi!  MsgArea        ctermfg=246  ctermbg=NONE   guifg=#9297a1  guibg=NONE
  " hi!  Pmenu guifg=#9297a1 guibg=#282c34
  " hi!  PmenuSel guifg=#9297a1 ctermbg=237 guibg=#313640
  hi!  Pmenu          ctermbg=237  guibg=#313640  guifg=#9297a1
  hi!  PmenuSel       ctermbg=220  guibg=#313640  guifg=#9297a1  gui=reverse
  hi!  CommentNormal  ctermfg=8    guifg=#95c637
  hi!  Visual         ctermfg=234  ctermbg=142    guifg=#1d2021  guibg=#98c379
  hi!  Search         ctermfg=234  ctermbg=5      guifg=#1d2021  guibg=#de9df1
  " gutter
  hi!  SignColumn  ctermfg=223   ctermbg=NONE   guifg=#d4be98  guibg=NONE
  hi!  RedSign     ctermfg=167   ctermbg=NONE   guifg=#e06c75  guibg=NONE
  hi!  YellowSign  ctermbg=NONE  guifg=#e5c07b  guibg=NONE
  hi!  BlueSign    ctermfg=109   ctermbg=NONE   guifg=#61afef  guibg=NONE
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
  hi!  link  Repeat                 RedItalic
  hi!  link  Conditional            PurpleItalic
  hi!  link  EndOfBuffer            Comment
  silent!  syn      clear      Normal
  silent!  syn      clear      Comment
  hi!      Normal   ctermbg=0  guibg=none     guifg=none
  hi!      Comment  ctermfg=8  guifg=#5c6370

endif

source ~/.dotfiles/vim/vimrc/shellcode.vimrc
