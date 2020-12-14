hi! link javaScriptBraces Orange
hi! link javaScriptFunction RedItalic
hi! link javaScriptParens Purple
hi! link javaScriptIdentifier Red
hi! link javaScriptConditional RedItalic
hi! link javaScriptBranch RedItalic
hi! link javaScriptRepeat RedItalic
hi! link javaScriptStatement RedItalic
hi! link javaScriptException RedItalic
hi! link javaScriptReserved RedItalic
hi! link javaScriptBoolean Yellow
hi! link javaScriptNumber Yellow

syn keyword myKeyWords of
hi! def link myKeyWords RedItalic

syn keyword group5 this
syn keyword group5 get
syn keyword group5 set
syn keyword group5 module
hi! def link group5 BlueItalic

syn keyword group6 console
hi! def link group6 Blue

syn match CompOp /\v[=!<>~+-]/
hi! link CompOp NormalBold
