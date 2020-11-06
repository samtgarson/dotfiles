" set <Leader> to <space>
nnoremap <SPACE> <Nop>
let mapleader=" "

" map window keys
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-l> <C-w>l

" set tab width
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2

" show line numbers (using
" https://github.com/jeffkreeftmeijer/vim-numbertoggle)
set number relativenumber

" shortcut to show/hide numbers
function! ToggleNumbers()
  if &number && &relativenumber
    set nonumber norelativenumber
  else
    set number relativenumber
  endif
endfunction
map <leader>n :call ToggleNumbers()<CR>

" use system clipboard
set clipboard=unnamed

" shortcut to show/hide spacing
map <leader>l :set list!<CR>

" shortcut to find and replace highlighted text in document
vnoremap <C-r> "hy:%s/<C-r>h//g<left><left>
nnoremap <C-f> bve"hy/<C-r>h<CR>

" reload files changed outside of vim
set autoread

" from http://items.sjbach.com/319/configuring-vim-right
set hidden                 " better buffer handling in the background
runtime macros/matchit.vim " jump between if/else with %
filetype on                " filetype specific functionality
filetype plugin on
filetype indent on

" better autocomplete
set wildmenu
set wildmode=list:longest

" better search case insensitivity
set ignorecase
set smartcase

" start scrolling when 8 lines from the last line
set scrolloff=15

" centralised swapfile dir
silent !mkdir ~/.vim/tmp > /dev/null 2>&1
set backupdir=~/.vim/tmp,~/.tmp,/tmp
set directory=~/.vim/tmp,~/.tmp,/tmp

" use tabs and windows when switching with quickfix windows
set switchbuf=usetab

" Ensure plugins like GitGutter update frequently
set updatetime=100

" Characters to show when highlighting whitespace
set listchars=eol:$,tab:>-,trail:~,space:·,extends:>,precedes:<

" Set globally ignored file globs
set wildignore+=*/node_modules/*

" Format JSON
map <Leader>j :%!python -m json.tool

" Close all windows
map <Leader>W :%bd<CR>

" Automatically clear trailing whitespace
autocmd BufWritePre * %s/\s\+$//e

" clear nvim search highlight on esc
nnoremap <silent> <esc> :noh<return><esc>

" Mouse settings
set mouse=a
if !has('nvim')
  set ttymouse=xterm2
endif

" Shortcut for piping commands into quickfix window
function! Quickfix(...)
  cexpr system(join(a:000, ' ')) | cw
endfunction
command! -nargs=1 Qf call Quickfix(<f-args>)

" Set filetype for templates
au BufNewFile,BufRead,BufReadPost *.zsh.tmpl set filetype=zsh
au BufNewFile,BufRead,BufReadPost *.vim.tmpl set filetype=vim
au BufNewFile,BufRead,BufReadPost *.yaml.tmpl set filetype=yaml

