let s:save_cpo = &cpo
set cpo&vim


function! lightgo#util#EchoSuccess(msg)
  call s:echo(a:msg, 'Function')
endfunction
function! lightgo#util#EchoError(msg)
  call s:echo(a:msg, 'ErrorMsg')
endfunction
function! lightgo#util#EchoWarning(msg)
  call s:echo(a:msg, 'WarningMsg')
endfunction
function! lightgo#util#EchoProgress(msg)
  redraw
  call s:echo(a:msg, 'Identifier')
endfunction
function! lightgo#util#EchoInfo(msg)
  call s:echo(a:msg, 'Debug')
endfunction

function! lightgo#util#GetLines()
  let buf = getline(1, '$')
  if &encoding != 'utf-8'
    let buf = map(buf, 'iconv(v:val, &encoding, "utf-8")')
  endif
  if &l:fileformat == 'dos'
    let buf = map(buf, 'v:val."\r"')
  endif
  return buf
endfunction

" IsWin returns 1 if current OS is Windows or 0 otherwise
function! lightgo#util#IsWin() abort
  let win = ['win16', 'win32', 'win64', 'win95']
  for w in win
    if (has(w))
      return 1
    endif
  endfor

  return 0
endfunction

function! lightgo#util#Exec(cmd, ...) abort
  if len(a:cmd) == 0
    call lightgo#util#EchoError("lightgo#util#Exec() called with empty a:cmd")
    return ['', 1]
  endif

  let l:bin = a:cmd[0]

  " Lookup the full path, respecting settings such as 'go_bin_path'. On errors,
  " CheckBinPath will show a warning for us.
  let l:bin = lightgo#path#CheckBinPath(l:bin)
  if empty(l:bin)
    return ['', 1]
  endif

  " Finally execute the command using the full, resolved path. Do not pass the
  " unmodified command as the correct program might not exist in $PATH.
  return call('s:exec', [[l:bin] + a:cmd[1:]] + a:000)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
