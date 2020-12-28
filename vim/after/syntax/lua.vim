syn keyword luaKeywords end
syn keyword luaKeywords else
syn keyword luaKeywords elseif
syn keyword luaKeywords then
syn keyword luaKeywords do
syn keyword luaKeywords and
syn keyword luaKeywords or
hi! def link luaKeywords PurpleItalic

syn keyword luaKeywords1 self
hi! def link luaKeywords1 Red

syn keyword luaKeywords2 local
hi! def link luaKeywords2 Aqua



hi! link luaCond PurpleItalic
hi! link luaFunction PurpleItalic
hi! link luaFunctionBlock Blue
hi! link luaRepeat PurpleItalic
hi! link luaStatement PurpleItalic
hi! link luaNumber Yellow
hi! link luaFunc Blue
hi! link luaTable Orange

syn match group6 /\v[\(\)]/
hi! link group6 Purple

syn match luaMathOp /\v[\/\%\^\&\$\\|\{\}]/
hi! link luaMathOp Orange

syn match luaCompOp /\v[<>~]/
hi! link luaCompOp NormalBold

syn match luaCompOp1 /\v[=~.+/%*#]/
hi! link luaCompOp1 Purple

syn match luaCompOp3 /\v[,]/
hi! link luaCompOp3 Normal

syn match luaCompOp4 /\v[!]/
hi! link luaCompOp4 RedBold
