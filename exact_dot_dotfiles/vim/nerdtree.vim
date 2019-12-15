" hide help text
let g:netrw_banner = 0

" Auto toggle nerdtree if opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" nerdtree options
map <silent> <C-n> :call ToggleTree()<CR>
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden=1
let NERDTreeDirArrows = 1
let NERDTreeAutoDeleteBuffer = 1

" Hide annoying directories from the sidebar
let g:NERDTreeIgnore = ['^.git$', '^node_modules$']

"# sync open file with NERDTree
" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

function! ToggleTree()
  if IsNERDTreeOpen()
    NERDTreeToggle
  else
    NERDTreeFind
  endif
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

" Highlight current file in tree
autocmd BufEnter * call SyncTree()
