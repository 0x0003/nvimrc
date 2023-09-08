" create session
function! SessMake() abort
  let s:sessiondir = $HOME . "/.config/nvim/.sessions" . getcwd()
  if (filewritable(s:sessiondir) != 2)
    exe 'silent !mkdir -p ' s:sessiondir
    redraw!
  endif
  let b:filename = s:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
endfunction

" load session
function! SessLoad() abort
  let s:sessiondir = $HOME . "/.config/nvim/.sessions" . getcwd()
  let s:sessionfile = s:sessiondir . "/session.vim"
  if (filereadable(s:sessionfile))
    exe 'source ' s:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

augroup sess
  autocmd!
  " autoload session if launched without arguments
  if(argc() == 0)
    autocmd VimEnter * nested :call SessLoad()
  endif
  " create session file on exit
  autocmd VimLeave * :call SessMake()
augroup END

