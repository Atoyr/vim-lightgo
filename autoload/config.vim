
let s:save_cpo = &cpo
set cpo&vim

function! lightgo#config#FmtCommand() abort
  return get(g:, "go_fmt_command", "gofmt")
endfunction

function! lightgo#config#FmtOptions() abort
  return get(g:, "go_fmt_options", {})
endfunction

function! lightgo#config#FmtFailSilently() abort
  return get(g:, "go_fmt_fail_silently", 0)
endfunction

function! lightgo#config#FmtExperimental() abort
  return get(g:, "go_fmt_experimental", 0 )
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

