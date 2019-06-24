if (exists('g:loaded_vim_smallgo') && g:loaded_vim_smallgo) 
  finish
endif
let g:loaded_vim_smallgo = 1

let s:save_cpo = &cpo
set cpo&vim

exe "command!" "-nargs=?" "-complete=file" get(g:, 'smallgo_gofmt_commandname', 'Gofmt') "call smallgo#gofmt()"


let &cpo = s:save_cpo
unlet s:save_cpo

