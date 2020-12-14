
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                               color overrides                                "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"simple, uses 16 color pallet derrived from terminal colors... runs on dim.vim


" backups
" hi  blue_1     ctermfg=4
" hi  blue_2     ctermfg=12
" hi  cyan_1     ctermfg=6
" hi  green_1    ctermfg=2
" hi  green_2    ctermfg=10
" hi  magenta_1  ctermfg=5
" hi  magenta_2  ctermfg=13
" hi  red_1      ctermfg=1
" hi  red_2      ctermfg=9
" hi  white_1    ctermfg=7
" hi  white_2    ctermfg=15
" hi  yellow_1   ctermfg=3
" hi  yellow_2  ctermfg=11
" hi  black_2   ctermfg=8
" if has('nvim')
"   " use italics if we are running neovim
"   hi  blue_1_bold       cterm=bold    ctermfg=4
"   hi  blue_1_italic     cterm=italic  ctermfg=4
"   hi  blue_2_bold       cterm=bold    ctermfg=12
"   hi  blue_2_italic     cterm=italic  ctermfg=12
"   hi  cyan_1_bold       cterm=bold    ctermfg=6
"   hi  cyan_1_italic     cterm=italic  ctermfg=6
"   hi  green_1_bold      cterm=bold    ctermfg=2
"   hi  green_1_italic    cterm=italic  ctermfg=2
"   hi  green_2_bold      cterm=bold    ctermfg=10
"   hi  green_2_italic    cterm=italic  ctermfg=10
"   hi  magenta_1_bold    cterm=bold    ctermfg=5
"   hi  magenta_1_italic  cterm=italic  ctermfg=5
"   hi  red_1_bold        cterm=bold    ctermfg=1
"   hi  red_1_italic      cterm=italic  ctermfg=1
"   hi  red_2_bold        cterm=bold    ctermfg=9
"   hi  red_2_italic      cterm=italic  ctermfg=9
"   hi  white_2_bold      cterm=bold    ctermfg=15
"   hi  white_2_italic    cterm=italic  ctermfg=15
"   hi  yellow_1_bold     cterm=bold    ctermfg=3
"   hi  yellow_1_italic   cterm=italic  ctermfg=3
"   hi  yellow_2_bold     cterm=bold    ctermfg=11
"   hi  yellow_2_italic   cterm=italic  ctermfg=11
"   hi  black_2_italic    cterm=italic  ctermfg=8
" else
    " create alternate mappings for vim
  " hi  link  blue_1_bold       blue_1
  " hi  link  blue_1_italic     blue_1
  " hi  link  blue_2_bold       blue_2
  " hi  link  blue_2_italic     blue_2
  " hi  link  cyan_1_bold       cyan_1
  " hi  link  cyan_1_italic     cyan_1
  " hi  link  green_1_bold      green_1
  " hi  link  green_1_italic    green_1
  " hi  link  green_2_bold      green_2
  " hi  link  green_2_italic    green_2
  " hi  link  magenta_1_bold    magenta_1
  " hi  link  magenta_1_italic  magenta_1
  " hi  link  red_1_bold        red_1
  " hi  link  red_1_italic      red_1
  " hi  link  red_2_bold        red_2
  " hi  link  red_2_italic      red_2
  " hi  link  white_2_bold      white_2
  " hi  link  white_2_italic    white_2
  " hi  link  yellow_1_bold     yellow_1
  " hi  link  yellow_1_italic   yellow_1
  " hi  link  yellow_2_bold     yellow_2
  " hi  link  yellow_2_italic   yellow_2
  " hi  link  black_2_italic    black_2
" endif

" ========== mappings to gruvbox-material ==========
" Fg             xxx ctermfg=223 guifg=#d4be98
" Orange         xxx ctermfg=208 guifg=#e78a4e
" Aqua           xxx ctermfg=108 guifg=#89b482
" Blue           xxx ctermfg=109 guifg=#7daea3
" Purple         xxx ctermfg=175 guifg=#d3869b
" RedItalic      xxx ctermfg=167 guifg=#ea6962
" OrangeItalic   xxx ctermfg=208 guifg=#e78a4e
" YellowItalic   xxx ctermfg=214 guifg=#d8a657
" GreenItalic    xxx ctermfg=142 guifg=#a9b665
" AquaItalic     xxx ctermfg=108 guifg=#89b482
" BlueItalic     xxx ctermfg=109 guifg=#7daea3
" PurpleItalic   xxx ctermfg=175 guifg=#d3869b
" RedBold        xxx ctermfg=167 guifg=#ea6962
" OrangeBold     xxx ctermfg=208 guifg=#e78a4e
" YellowBold     xxx ctermfg=214 guifg=#d8a657
" GreenBold      xxx ctermfg=142 guifg=#a9b665
" AquaBold       xxx ctermfg=108 guifg=#89b482
" BlueBold       xxx ctermfg=109 guifg=#7daea3
" PurpleBold     xxx ctermfg=175 guifg=#d3869b

hi  link blue_1     Blue
hi  link blue_2     Blue
hi  link cyan_1     Aqua
hi  link green_1    Green
hi  link green_2    Green
hi  link magenta_1  Purple
hi  link magenta_2  Purple
hi  link red_1      Red
hi  link red_2      Red
hi  link white_1    Fg
hi  link white_2    Fg
hi  link yellow_1   Yellow
hi  link yellow_2  Orange
" hi  link black_2   ctermfg=8

hi  link  blue_1_bold       BlueBold
hi  link  blue_1_italic     BlueItalic
hi  link  blue_2_bold       BlueBold
hi  link  blue_2_italic     BlueItalic
hi  link  cyan_1_bold       AquaBold
hi  link  cyan_1_italic     AquaItalic
hi  link  green_1_bold      GreenBold
hi  link  green_1_italic    GreenItalic
hi  link  green_2_bold      GreenBold
hi  link  green_2_italic    GreenItalic
hi  link  magenta_1_bold    PurpleBold
hi  link  magenta_1_italic  PurpleItalic
hi  link  red_1_bold        RedBold
hi  link  red_1_italic      RedItalic
hi  link  red_2_bold        RedBold
hi  link  red_2_italic      RedItalic
hi  link  white_2_bold      Comment
hi  link  white_2_italic    Comment
hi  link  yellow_1_bold     YellowBold
hi  link  yellow_1_italic   YellowItalic
hi  link  yellow_2_bold     YellowBold
hi  link  yellow_2_italic   YellowItalic
hi  link  black_2_italic    Fg

" ========== other color overrides ==========

" if, else
" hi  Conditional  ctermfg=1

" " repeat = for,while
" hi  repeat  ctermfg=1

" " def, return, break
" hi  Statement  ctermfg=5
" hi  Define     ctermfg=5  cterm=bold
" hi  Exception  ctermfg=5

" " Numbers
" hi  Number  ctermfg=1
" hi  Float   ctermfg=1

" hi MoreMsg  ctermfg=8

" insert | visual
" hi ModeMsg  ctermfg=8

" command status
" hi MsgArea  ctermfg=8

" my setup
" hi  Normal     ctermfg=7
" hi  IncSearch  ctermfg=3  ctermbg=0

" hi  Comment    ctermfg=8
hi Comment  cterm=italic ctermfg=8 gui=italic guifg=#928374

" Normal - just plain text
" hi  Normal     ctermfg=7
" hi  Function   ctermfg=4
" hi  IncSearch  ctermfg=0  ctermbg=3
" hi  Comment    ctermfg=8

" IndentLineToggle uses Conceal
" hi  Conceal    ctermfg=8
" hi Folded ctermfg=8 ctermbg=NONE guifg=NONE guibg=None
" hi PmenuSbar ctermfg=8 ctermbg=NONE guifg=NONE guibg=None
" hi  String     ctermfg=2

" status line
" hi  StatusLine    ctermbg=NONE  ctermfg=247
" hi  StatusLineNC  ctermbg=NONE  ctermfg=244

" " visual select
" hi  Visual  ctermfg=0  ctermbg=10

" " Other
" hi  Search   ctermfg=0     ctermbg=13
" hi  NonText  ctermfg=8
" hi  LineNr   ctermbg=NONE  ctermfg=8

" " Menu drop down/selection
" hi  Pmenusel  ctermfg=0  ctermbg=7
" hi  Pmenu     ctermfg=7  ctermbg=0

" " Override vertical split colors
" hi  VertSplit  ctermfg=8  ctermbg=NONE

" hi  Special       ctermfg=3
" hi  Error         ctermfg=1   ctermbg=NONE
" hi CursorColumn   ctermfg=8 ctermbg=NONE guifg=NONE guibg=None
" hi CursorLine    ctermfg=8 ctermbg=NONE guifg=NONE guibg=None

" hi  fzf1       ctermfg=4   ctermbg=0
" hi  fzf2       ctermfg=4   ctermbg=0
" hi  fzf3       ctermfg=4   ctermbg=0
" hi  my_fzf_0   ctermbg=0
" hi  my_fzf_1   ctermbg=1
" hi  my_fzf_2   ctermbg=2
" hi  my_fzf_3   ctermbg=3
" hi  my_fzf_4   ctermbg=4
" hi  my_fzf_5   ctermbg=5
" hi  my_fzf_7   ctermbg=7
" hi  my_fzf_8   ctermbg=8
" hi  my_fzf_15  ctermbg=15

" " fzf uses Tabline
" hi  TabLine  ctermbg=0  ctermfg=2
