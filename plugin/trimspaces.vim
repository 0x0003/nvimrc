" remove all trailing whitespaces and preserve screen state
function! Trimspaces() abort
  let l:save = winsaveview()
  %s/\s\+$//ge
  call winrestview(l:save)
endfun

command! Trim call Trimspaces()

