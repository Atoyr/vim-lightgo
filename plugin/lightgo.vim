if (exists('g:loaded_vim_lightgo') && g:loaded_vim_lightgo) 
  finish
endif
let g:loaded_vim_lightgo = 1

let s:save_cpo = &cpo
set cpo&vim

exe "command!" "-nargs=0" get(g:, 'lightgo_gofmt_commandname', 'Gofmt') "call lightgo#fmt(-1)"
exe "command!" "-nargs=0" get(g:, 'lightgo_goimports_commandname', 'GoImports') "call lightgo#fmt(1)"


let &cpo = s:save_cpo
unlet s:save_cpo

