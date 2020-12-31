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
    Plug 'dense-analysis/ale', { 'for' : ['yaml', 'python', 'javascript', 'typescript', 'json', 'ruby', 'cs', 'lua'] }
    Plug 'vimwiki/vimwiki'
    Plug 'neoclide/coc.nvim', {'branch': 'release',
          \ 'for' : [
          \ 'python', 'yaml', 'jinja', 'ansible',
          \ 'json', 'javascript', 'css', 'markdown', 'typescript',
          \ 'terraform', 'cs', 'lua', 'vimwiki']}
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
      end_pattern = "^}}}$"
    },
    {
      cmd = {"luafmt -i 2 -w replace"},
      start_pattern = "^{{{lua$",
      end_pattern = "^}}}$"
    },
    {
      cmd = {"black"},
      start_pattern = "^{{{python$",
      end_pattern = "^}}}$"
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
      end_pattern = "^```$"
      -- target = "current"
    }
  }
}
EOF


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                vim functions                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

source ~/.dotfiles/vim/vimrc/vim.vimrc

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
"                               plugin bindings                                "
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
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
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

" source ~/.dotfiles/vim/vimrc/python.vimrc
source ~/.dotfiles/vim/vimrc/aux.vimrc
