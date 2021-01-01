""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                     vars                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" neovim providers
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 1
let g:python3_host_prog = $HOME."/.virtualenvs/prod3/bin/python3"

" coc.vim
if executable('~/local/node/bin/node')
  let g:coc_node_path = '~/local/node/bin/node'
endif

let g:coc_global_extensions = ['coc-python', 'coc-json', 'coc-tsserver', 'coc-prettier', 'coc-omnisharp', 'coc-lua' ]

let g:tmux_navigator_disable_when_zoomed = 1

" use all the beautiful things jedi-vim offers, but leave completion to coc
let g:jedi#completions_enabled = 0
let g:jedi#goto_assignments_command = ""

let g:AutoPairsUseInsertedCount = 0
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutFastWrap='<C-e>'
let g:AutoPairsShortcutBackInsert = '<C-b>'

" close nerdtree when opening a file
let NERDTreeQuitOnOpen = 0
let NERDTreeMinimalUI = 1
let g:NERDTreeWinSize=25
" let NERDTreeDirArrows = 1
let NERDTreeIgnore = ['\.pyc$', '\.egg-info$', '__pycache__', '__pycache__']

let g:vimwiki_global_ext = 0
let g:vimwiki_table_mappings = 0
let g:wiki = {}
let g:wiki.path = 'wiki'
let g:wiki.nested_syntaxes = {}
let g:wiki.nested_syntaxes.python = 'python'
let g:wiki.nested_syntaxes.cpp = 'cpp'
let g:wiki.nested_syntaxes.php = 'php'
let g:wiki.nested_syntaxes.javascript = 'javascript'
let g:wiki.nested_syntaxes.bash = 'sh'
let g:wiki.nested_syntaxes.lua = 'lua'
let g:vimwiki_list = [wiki]
let g:vim_markdown_folding_disabled = 1

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_format = '(%code%): %s'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'always'
" let g:ale_sign_warning = '⚠'
let g:ale_sign_error = '•'
let g:ale_sign_warning = '•'
let g:ale_sign_offset = 1000000
let g:ale_virtualtext_cursor = 0
let g:ale_warn_about_trailing_blank_lines = 0
let g:ale_warn_about_trailing_whitespace = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_fixers = {}
let g:ale_fix_on_save = 0
let g:ale_linters = {}
let g:ale_linters['ansible.yaml'] = ['yamllint', 'ansible_lint']
let g:ale_linters['javascript'] = ['eslint']
let g:ale_linters['python'] = ['pylint']
let g:ale_linters_explicit = 1

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

let g:fzf_layout = { 'window': { 'width': 1, 'height': 1, 'highlight': 'Comment', 'border' : 'bottom' } }
let g:fzf_history_dir = '~/.tmp/fzf-history'
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let g:fzf_nvim_statusline = 1

let g:fzf_colors = {}
let g:fzf_colors.fg = ['fg', 'Comment']
let g:fzf_colors.hl = ['fg', 'RedBold']
let g:fzf_colors['fg+'] = ['fg', 'GreenBold']
let g:fzf_colors['bg+']= ['bg', 'fzf_bg_plus']
let g:fzf_colors['hl+']= ['fg', 'PurpleBold']
let g:fzf_colors.info = ['fg', 'fzf_info']
let g:fzf_colors.prompt = ['fg', 'BlueBold']
let g:fzf_colors.pointer = ['fg', 'RedBold']
let g:fzf_colors.gutter = ['fg', 'fzf_bg']
let g:fzf_colors.spinner = ['fg', 'fzf_spinner']
