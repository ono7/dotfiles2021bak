syn keyword luaKeywords end
syn keyword luaKeywords else
syn keyword luaKeywords elseif
syn keyword luaKeywords then
syn keyword luaKeywords do
hi! def link luaKeywords RedItalic

hi! link luaCond RedItalic
hi! link luaFunction RedItalic
hi! link luaRepeat RedItalic
hi! link luaStatement RedItalic
hi! link luaNumber Yellow
hi! link luaFunc Blue
hi! link luaTable Orange

syn match group6 /\v[\(\)]/
hi! link group6 Purple
