" execute macro over visual selection on lines that match
function! macros#Visual() abort
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

function! macros#RepeatLast() abort
  try
    normal @@
  catch /E748/
    normal @q
  endtry
endfunction

xnoremap <silent> @ :<C-u>call macros#Visual()<CR>
nnoremap <silent> Q :call macros#RepeatLast()<CR>

