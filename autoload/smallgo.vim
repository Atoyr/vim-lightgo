let s:save_cpo = &cpo
set cpo&vim

function! smallgo#fommat(withGoimport) abort
  let l:curw = winsaveview()
  let l:tmpname = tempname() . '.go'
  call writefile(smallgo#util#GetLines(), l:tmpname)
  if smallgo#util#IsWin()
    let l:tmpname = tr(l:tmpname, '\','/')
  endif
  let bin_name = smallgo#config#FmtCommand()
  if a:withGoimport == 1
    let bin_name = "goimports"
  endif

  silent execute "0,$! gofmt"
  try | silent undojoin | catch | endtry
  call winrestview(l:curw)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

