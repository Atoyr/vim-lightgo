let s:save_cpo = &cpo
set cpo&vim

function! smallgo#util#GetLines()
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
function! smallgo#util#IsWin() abort
  let win = ['win16', 'win32', 'win64', 'win95']
  for w in win
    if (has(w))
      return 1
    endif
  endfor

  return 0
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
