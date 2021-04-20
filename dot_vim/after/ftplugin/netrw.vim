function! Duplicate()
  let curfilename = getline('.')
  call inputsave()
  let newname = input('Enter name: ')
  call inputrestore()
  if empty(newname)
    return
  endif
  execute '!cp '.b:netrw_curdir.'/'.curfilename.' '.b:netrw_curdir.'/'.newname
  execute 'e '.b:netrw_curdir
  execute 'edit '.b:netrw_curdir.'/'.newname
endfunction

nnoremap <silent> <Leader>C :call Duplicate()<cr>
