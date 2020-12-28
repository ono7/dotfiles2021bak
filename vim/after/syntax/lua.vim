syn keyword luaKeywords end
syn keyword luaKeywords else
syn keyword luaKeywords elseif
syn keyword luaKeywords then
syn keyword luaKeywords do
hi! def link luaKeywords RedItalic

hi! link luaCond RedItalic
hi! link luaFunction RedItalic
hi! link luaFunctionBlock Blue
hi! link luaRepeat RedItalic
hi! link luaStatement RedItalic
hi! link luaNumber Yellow
hi! link luaFunc Blue
hi! link luaTable Orange

syn match group6 /\v[\(\)]/
hi! link group6 Purple

syn match luaMathOp /\v[\/\%\^\&\$\\|\{\}]/
hi! link luaMathOp Orange

syn match luaCompOp /\v[<>~]/
hi! link luaCompOp NormalBold

syn match luaCompOp1 /\v[=~.+-/%*]/
hi! link luaCompOp1 Purple

syn match luaCompOp3 /\v[,]/
hi! link luaCompOp3 Normal

syn match luaCompOp4 /\v[!]/
hi! link luaCompOp4 RedBold

syn match luaCompOp5 /\v[#]/
hi! link luaCompOp5 Aqua
