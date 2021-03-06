if !exists("g:ck_host")
  let g:ck_host = 'localhost'
endif

function! CkHost(...)
  if(a:0 > 0)
    let g:ck_host = a:1
  endif
  echo "host: " . g:ck_host
endfunction

function! CkCommand(s)
  let tc = system(join(["chuck @" . g:ck_host, a:s], ' '))
  return tc
endfunction

function! CkStatus()
  let tc = CkCommand("^")
  return tc
endfunction

function! CkTime()
  let tc = CkCommand("--time")
  return tc
endfunction

function! CkAdd()
  w
  let f = expand("%:p")
  let tc = CkCommand(join(["+", f], ' '))
  return tc
endfunction

function! CkRemove(n, ...)
  let tc = CkCommand(join(["-", a:n] + a:000, ' '))
  return tc
endfunction

function! CkReplace(n)
  w
  let f = expand("%:p")
  let tc = CkCommand(join(["=", a:n, f], ' '))
  return tc
endfunction

function! CkKill()
  echo "kill ChucK? [y or n]"
  let c = getchar()
  if(nr2char(c) == 'y')
    let tc = CkCommand("--kill")
  else
    let tc = ""
  endif
  return tc
endfunction


command! -nargs=? Host :call CkHost(<f-args>)
command! -nargs=+ Remove :call CkRemove(<f-args>)
command! -nargs=1 Replace :call CkReplace(<f-args>)

map <LocalLeader>^ :call CkStatus()
map <LocalLeader>+ :call CkAdd()
map <LocalLeader>t :call CkTime()
map <LocalLeader>k :call CkKill()
map <LocalLeader>h :call CkHost()

