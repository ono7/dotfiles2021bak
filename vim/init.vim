" Follow the white rabbit...

nnoremap Q <Nop>
nnoremap gQ <Nop>

let mapleader = " "

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

    Plug 'bfredl/nvim-miniyank'
    Plug 'SirVer/ultisnips'
    Plug 'lukas-reineke/format.nvim'
    Plug 'neoclide/coc.nvim', {'branch': 'release',
          \ 'for' : [
          \ 'python', 'yaml', 'jinja', 'ansible',
          \ 'json', 'javascript', 'css', 'markdown', 'typescript',
          \ 'terraform', 'cs', 'lua', 'vimwiki']}
      let g:coc_global_extensions = ['coc-python', 'coc-json', 'coc-tsserver', 'coc-prettier', 'coc-omnisharp', 'coc-lua' ]
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
    " Plug 'Yggdroot/indentLine', { 'on' : ['IndentLinesToggle','IndentLinesEnable']}
    Plug 'Glench/Vim-Jinja2-Syntax', { 'for' : 'jinja' }
    if isdirectory('/usr/local/opt/fzf')
      " use Ripgrep (Rg) for best experience
      " ~/.fzf/install (setup keybindings)
      Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
    else
      Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
      Plug 'junegunn/fzf.vim'
    endif
    Plug 'ervandew/supertab'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-eunuch'
    " Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-markdown', {'for' : 'markdown'}
    Plug 'scrooloose/nerdtree',{ 'on': ['NERDTreeToggle', 'NERDTree', 'NERDTreeFind', 'NERDTreeClose'] }
      " close nerdtree when opening a file
      let NERDTreeQuitOnOpen = 0
      let NERDTreeMinimalUI = 1
      let g:NERDTreeWinSize=25
      " let NERDTreeDirArrows = 1
      let NERDTreeIgnore = ['\.pyc$', '\.egg-info$', '__pycache__', '__pycache__']
    Plug 'dense-analysis/ale', { 'for' : ['yaml', 'python', 'javascript', 'typescript', 'json', 'ruby', 'cs', 'lua'] }
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

lua << EOF
require "format".setup {
  -- https://github.com/lukas-reineke/format.nvim
  -- TODO: resolve black apple m1 arch issues

  -- npm install lua-fmt -g
  -- pip install black

  vim = {
    {
      cmd = {"luafmt -i 2 -w replace"},
      start_pattern = "^lua << EOF$",
      end_pattern = "^EOF$"
    }
  },
  lua = {
    {
      cmd = {
        function(file)
          return string.format("luafmt -i 2 -l %s -w replace %s", vim.bo.textwidth, file)
        end
      }
    }
  },
  python = {
    {
      cmd = {
        "black"
      }
    }
  }
}
EOF

let g:loaded_ruby_provider = 0
let g:loaded_python_provider = 1
let g:python3_host_prog = $HOME."/.virtualenvs/prod3/bin/python3"

set synmaxcol=0
syntax sync minlines=256
syntax sync maxlines=300

" fix syntax on large files
let g:vimsyn_embed='0'

set termguicolors
set background=dark
colorscheme onehalfdark

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  autogroup                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

augroup _enter
  autocmd!
  autocmd BufEnter * silent! lcd %:p:h
  " restore last known position
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  autocmd VimEnter * command! -bang -nargs=? GFiles call fzf#vim#gitfiles(<q-args>, {'options': '--no-preview'}, <bang>0)
  autocmd VimEnter * command! -bang -nargs=? Files call fzf#vim#files(<q-args>, {'options': '--no-preview'}, <bang>0)
augroup END

augroup _write
  autocmd!
  autocmd BufWritePre * silent! :call <SID>StripTrailingWhitespaces() | retab
  " Plug 'lukas-reineke/format.nvim'
  autocmd BufWritePost * FormatWrite
augroup END

augroup _setft
  autocmd!
  autocmd BufNewFile,BufRead,BufEnter *.asm,*.nasm setfiletype nasm
  autocmd BufNewFile,BufRead,BufEnter *.yml,*.yaml setfiletype ansible.yaml
  autocmd BufNewFile,BufRead,BufEnter *.wiki setfiletype vimwiki
  autocmd BufNewFile,BufRead,BufEnter *.ejs setfiletype html
augroup END

augroup _filetype
  autocmd!
  autocmd FileType * set formatoptions-=cro fo+=j
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               plugin variables                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" lua hi
let g:vimsyn_embed = 'l'

" coc.vim
if executable('~/local/node/bin/node')
  let g:coc_node_path = '~/local/node/bin/node'
endif

let g:vim_markdown_folding_disabled = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '(%code%): %s'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'always'
let g:ale_sign_warning = '⚠'
let g:ale_sign_error = '•'
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
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh', 'nasm', 'vim', 'php', 'javascript', 'lua', 'sql']
let g:markdown_syntax_conceal = 0
" 1 = show if 2 files, 2 = always, 0 = disable
let g:buftabline_show = 0
let g:SuperTabDefaultCompletionType = "<C-n>"
let g:SuperTabClosePreviewOnPopupClose = 1
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories=['~/.config/nvim/UltiSnips', 'UltiSnips']
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsUsePythonVersion = 3
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                   bindings                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !empty(glob('~/.vim/autoload/plug.vim'))

  nnoremap <silent><C-e> :call NerdTreeToggleFind()<CR>

  nnoremap <silent><C-p> :call FZFOpen(':GFiles')<CR>
  nnoremap <silent><leader>f :call FZFOpen(':Files')<CR>
  nnoremap <silent><leader>b :call FZFOpen(':Buffers')<CR>

  nmap s  <Plug>Ysurround
  nmap S  <Plug>YSurround
  nmap sw siW

  nmap <silent> [n <Plug>(ale_next_wrap)
  nmap <silent> ]n <Plug>(ale_previous_wrap)

  map p <Plug>(miniyank-autoput)
  map P <Plug>(miniyank-autoPut)
  let g:miniyank_filename = $HOME.'/.tmp/miniyank-shared-ring'
  let g:miniyank_maxitems = 1

  nmap <silent> gr <Plug>(coc-references)
  " trigger completion, manually
  inoremap <silent><expr> <C-c> coc#refresh()

endif

if &diff
    set cursorline
    map ] ]n
    map [ [n
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                core bindings                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" find syntax group
map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" diable c-z (bg)
nnoremap <c-z> <nop>
cnoremap <c-f> <nop>
nnoremap cp yap<S-}>p

" macros
nnoremap Q @q
xnoremap Q :'<,'>norm @q<cr>

" create list from visual select and normal mode -> single line
" xnoremap <C-l> :s/\v\s+$//ge<cr>gv :s/\v^(.+)$/"\1",/ge<cr>gvJ :noh<cr>

nnoremap <leader>ve :e $MYVIMRC<cr>
nnoremap <leader>vr :source $MYVIMRC<cr>

inoremap jk <Esc>:noh<cr><c-g>

" move better around line wraps
nnoremap <expr> k v:count == 0 ? 'gk' : 'k'
nnoremap <expr> j v:count == 0 ? 'gj' : 'j'

" tmux send-kyes up and enter, *repeat last command*
nnoremap <silent><leader>t :silent !tmux send-keys -t 2 c-p Enter<cr>
nnoremap H ^<c-g>
nnoremap L $<c-g>
vnoremap H ^<c-g>
vnoremap L $<c-g>

" more natural re-do command
nnoremap U <C-r>

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

nnoremap Y y$

" mark and return to mark after yank
vnoremap y mxy`x
nnoremap yp mxyap`x

" select visualy selected text for search
xnoremap <enter> y/\V<C-r>=escape(@",'/\')<CR><CR>

set autoindent
set autoread
set backspace=indent,eol,start
set cmdheight=2
set complete+=kspell
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
set mouse=a
set nobackup nowritebackup noswapfile
set nojoinspaces
set nolist
set noshowcmd
set novisualbell noerrorbells
set nowrap
set nrformats-=octal
set number
set numberwidth=3
set pastetoggle=<F2>
set ruler
set scrolloff=2
set shiftround
set shiftwidth=2
set shortmess+=c
set shortmess=atIoOsT
set showmode
set sidescrolloff=1
set smartcase smarttab
set softtabstop=2
set spelllang=en_us
set splitbelow
set tabstop=2
set textwidth=80
set timeout timeoutlen=500 ttimeout ttimeoutlen=50
set undolevels=999
set updatetime=250
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__/*
set winaltkeys=no

" performance settings
set lazyredraw
set matchtime=0
set nocursorcolumn nocursorline
set re=1
set redrawtime=10000
set ttyfast

set inccommand=nosplit
try
  set signcolumn=number
catch
  set signcolumn=yes
endtry

" pmenu/transparency/items
set pumheight=10
set pumblend=0
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
tnoremap jk <C-\><C-n>

" fixes issues with extra lines in EOF
set fileformats=unix,dos
set fixendofline
set foldlevel=1
set foldmethod=indent
set foldnestmax=2
set nofoldenable

" requires -> export DISPLAY=:0.0 on zshrc
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

set clipboard=unnamed
set clipboard+=unnamedplus

source ~/.dotfiles/vim/vimrc/aux.vimrc
