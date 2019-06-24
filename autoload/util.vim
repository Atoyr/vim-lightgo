let s:save_cpo = &cpo
set cpo&vim

function! go#util#GetLines()
  let buf = getline(1, '$')
  if &encoding != 'utf-8'
    let buf = map(buf, 'iconv(v:val, &encoding, "utf-8")')
  endif
  if &l:fileformat == 'dos'
    let buf = map(buf, 'v:val."\r"')
  endif
  return buf
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
