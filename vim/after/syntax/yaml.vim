silent! syn clear yamlSingleEscape
silent! syn clear yamlFlowString
silent! syn clear yamlPlainScalar

syn match Group1 /\v[']/
syn match Group1 /\v["]/
hi! link Group1 Green

hi! link yamlFlowIndicator Purple

hi! link yamlNodeTag Red
