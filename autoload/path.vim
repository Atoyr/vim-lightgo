
" don't spam the user when Vim is started in Vi compatibility mode
let s:cpo_save = &cpo
set cpo&vim

" initial_go_path is used to store the initial GOPATH that was set when Vim
" was started. It's used with :GoPathClear to restore the GOPATH when the user
" changed it explicitly via :GoPath. Initially it's empty. It's being set when
" :GoPath is used
let s:initial_go_path = ""

" GoPath sets or echos the current GOPATH. If no arguments are passed it
" echoes the current GOPATH, if an argument is passed it replaces the current
" GOPATH with it. If two double quotes are passed (the empty string in go),
" it'll clear the GOPATH and will restore to the initial GOPATH.
function! lightgo#path#GoPath(...) abort
  " no argument, show GOPATH
  if len(a:000) == 0
    echo lightgo#path#Default()
    return
  endif

  " we have an argument, replace GOPATH
  " clears the current manually set GOPATH and restores it to the
  " initial GOPATH, which was set when Vim was started.
  if len(a:000) == 1 && a:1 == '""'
    if !empty(s:initial_go_path)
      let $GOPATH = s:initial_go_path
      let s:initial_go_path = ""
    endif

    echon "vim-go: " | echohl Function | echon "GOPATH restored to ". $GOPATH | echohl None
    return
  endif

  echon "vim-go: " | echohl Function | echon "GOPATH changed to ". a:1 | echohl None
  let s:initial_go_path = $GOPATH
  let $GOPATH = a:1
endfunction

" Default returns the default GOPATH. If GOPATH is not set, it uses the
" default GOPATH set starting with Go 1.8. This GOPATH can be retrieved via
" 'go env GOPATH'
function! lightgo#path#Default() abort
  if $GOPATH == ""
    " use default GOPATH via go env
    return lightgo#util#env("gopath")
  endif

  return $GOPATH
endfunction
