let s:save_cpo = &cpo
set cpo&vim

function! lightgo#format()
  let l:curw = winsaveview()
  silent execute "0,$! gofmt"
  try | silent undojoin | catch | endtry
  call winrestview(l:curw)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

