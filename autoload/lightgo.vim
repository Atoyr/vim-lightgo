let s:save_cpo = &cpo
set cpo&vim

function! lightgo#fmt(withGoimport)
  let l:curw = winsaveview()
  let l:tmpname = tempname() . '.go'
  call writefile(lightgo#util#GetLines(), l:tmpname)
  if lightgo#util#IsWin()
    let l:tmpname = tr(l:tmpname, '\', '/')
  endif

  let bin_name = lightgo#config#FmtCommand()
  if a:withGoimport == 1
    let bin_name = "goimports"
  endif

  let current_col = col('.')
  let [l:out, l:err] = lightgo#fmt#run(bin_name, l:tmpname, expand('%'))
  let diff_offset = len(readfile(l:tmpname)) - line('$')

  if l:err == 0
    call lightgo#fmt#update_file(l:tmpname, expand('%'))
  elseif !lightgo#config#FmtFailSilently()
    let errors = s:parse_errors(expand('%'), out)
    call s:show_errors(errors)
  endif

  " We didn't use the temp file, so clean up
  call delete(l:tmpname)

  if go#config#FmtExperimental()
    " restore our undo history
    silent! exe 'rundo ' . tmpundofile
    call delete(tmpundofile)

    " Restore our cursor/windows positions, folds, etc.
    if empty(l:curw)
      silent! loadview
    else
      call winrestview(l:curw)
    endif
  else
    " Restore our cursor/windows positions.
    call winrestview(l:curw)
  endif

  " be smart and jump to the line the new statement was added/removed
  call cursor(line('.') + diff_offset, current_col)

  " Syntax highlighting breaks less often.
  syntax sync fromstart
endfunction

function! lightgo#fmt#run(bin_name, source, target)
  let l:cmd = s:fmt_cmd(a:bin_name, a:source, a:target)
  if empty(l:cmd)
    return
  endif
  return lightgo#util#Exec(l:cmd)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

