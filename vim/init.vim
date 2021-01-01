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
    Plug 'davidhalter/jedi-vim', { 'for' : ['python'] }
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'jiangmiao/auto-pairs'
    Plug 'Glench/Vim-Jinja2-Syntax', { 'for' : 'jinja' }
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
    Plug 'ervandew/supertab'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-eunuch'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-markdown', {'for' : 'markdown'}
    Plug 'scrooloose/nerdtree',{ 'on': ['NERDTreeToggle', 'NERDTree', 'NERDTreeFind', 'NERDTreeClose'] }
    Plug 'dense-analysis/ale', { 'for' : ['yaml', 'python', 'javascript', 'typescript', 'json', 'ruby', 'cs', 'lua' ] }
    Plug 'vimwiki/vimwiki'
    Plug 'neoclide/coc.nvim', {'branch': 'release',
          \ 'for' : [
          \ 'python', 'jinja',
          \ 'json', 'javascript', 'css', 'typescript',
          \ 'terraform', 'cs', 'lua' ]}
    " Plug 'Yggdroot/indentLine', { 'on' : ['IndentLinesToggle','IndentLinesEnable']}
  call plug#end()
endif

filetype plugin indent on

syntax on

" lua hi
let g:vimsyn_embed = 'l'

set synmaxcol=0
syntax sync minlines=256
syntax sync maxlines=300

set termguicolors
set background=dark
colorscheme onehalfdark

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

source ~/.dotfiles/vim/vimrc/vars.vimrc

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              if plug is loaded                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if !empty(glob('~/.vim/autoload/plug.vim'))

" lukas-reineke/format.nvim
lua << EOF
require "format".setup {
  -- https://github.com/lukas-reineke/format.nvim
  -- :h format.txt

  -- TODO: resolve black apple m1 arch issues

  -- npm install lua-fmt prettier -g
  -- pip install black
  -- autocmd BufWritePost * FormatWrite

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
  },
  vimwiki = {
    {
      cmd = {"prettier -w --parser babel"},
      start_pattern = "^{{{javascript$",
      end_pattern = "^}}}$",
      target = "current"
    },
    {
      cmd = {"luafmt -i 2 -w replace"},
      start_pattern = "^{{{lua$",
      end_pattern = "^}}}$",
      target = "current"
    },
    {
      cmd = {"black"},
      start_pattern = "^{{{python$",
      end_pattern = "^}}}$",
      target = "current"
    }
  },
  javascript = {
    {cmd = {"prettier -w", "eslint --fix"}}
  },
  markdown = {
    {cmd = {"prettier -w"}},
    {
      cmd = {"luafmt -i 2 -w replace"},
      start_pattern = "^```lua$",
      end_pattern = "^```$",
      -- current only format where cursor is
      target = "current"
    }
  }
}
EOF

  nnoremap <silent><C-e> :call NerdTreeToggleFind()<CR>

  nnoremap <silent><C-p> :call FZFOpen(':GFiles')<CR>
  nnoremap <silent><leader>f :call FZFOpen(':Files')<CR>
  nnoremap <silent><leader>b :call FZFOpen(':Buffers')<CR>

  " nmap s  <Plug>Ysurround

  nmap <silent> [n <Plug>(ale_next_wrap)
  nmap <silent> ]n <Plug>(ale_previous_wrap)

  nmap p <Plug>(miniyank-autoput)
  nmap P <Plug>(miniyank-autoPut)
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
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $

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
set clipboard=unnamed
set clipboard+=unnamedplus
set diffopt=filler
set directory=~/.tmp
set display+=lastline
set encoding=utf-8 nobomb
set fileencoding=utf-8
set fillchars+=vert:│
set hidden
set history=999
set ignorecase
set inccommand=nosplit
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
" inc/dec letters with c-a/x
set nrformats+=alpha
set number numberwidth=3
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
set spelllang=en_us
set splitbelow
set softtabstop=2 tabstop=2 textwidth=80 expandtab
set timeout timeoutlen=500 ttimeout ttimeoutlen=50
set undolevels=999
set updatetime=250
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__/*
set winaltkeys=no

" performance settings
set lazyredraw
set matchtime=0
set nocursorcolumn nocursorline
" set re=1
set redrawtime=10000
set ttyfast

try
  set signcolumn=number
catch
  set signcolumn=yes
endtry

" pmenu/transparency/items
set pumheight=10 pumblend=0
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
tnoremap jk <C-\><C-n>

" fixes issues with extra lines in EOF
set fileformats=unix,dos
set fixendofline
set foldlevel=1 foldmethod=indent foldnestmax=2 nofoldenable

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

hi! TermCursorNC guibg=Purple guifg=white ctermbg=1 ctermfg=15
hi! trans guibg=Purple guifg=white ctermbg=1 ctermfg=15

source ~/.dotfiles/vim/vimrc/aux.vimrc
" source ~/.dotfiles/vim/vimrc/python.vimrc
