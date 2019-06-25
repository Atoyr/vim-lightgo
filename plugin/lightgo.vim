if (exists('g:loaded_vim_smallgo') && g:loaded_vim_smallgo) 
  finish
endif
let g:loaded_vim_smallgo = 1

let s:save_cpo = &cpo
set cpo&vim

exe "command!" "-nargs=0" get(g:, 'smallgo_gofmt_commandname', 'Gofmt') "call smallgo#format(-1)"
exe "command!" "-nargs=0" get(g:, 'smallgo_goimports_commandname', 'GoImports') "call smallgo#fotmat(1)"


let &cpo = s:save_cpo
unlet s:save_cpo

