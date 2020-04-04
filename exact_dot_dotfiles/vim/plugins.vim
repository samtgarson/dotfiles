call plug#begin('~/.vim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'cakebaker/scss-syntax.vim'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'chrisbra/unicode.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'haishanh/night-owl.vim'
Plug 'itchyny/lightline.vim'
Plug 'janko/vim-test'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'neoclide/jsonc.vim'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'suy/vim-context-commentstring'
Plug 'svermeulen/vim-easyclip'
Plug 'towolf/vim-helm'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/gitignore'
Plug 'Xuyuanp/nerdtree-git-plugin'

call plug#end()

" vim-align options
" ----------------
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" vim-test options
" ----------------
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>

" open tests in a tmux pane
let test#strategy = 'neovim'

" set test matcher for Jest
let g:test#javascript#jest#file_pattern = '\v((test|__tests__/).*|(spec|test)?)\.(js|jsx|coffee|ts|tsx)$'

" fzf options
" ----------
" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
map <silent> <C-p> :GFiles<Cr>
map <silent> <C-P> :Files<Cr>
map <Leader>f :Rg<Space>

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

command! Lint cexpr system("npm run lint --silent -- -f unix") | cw

" Fugitive options
" ---------------
map <Leader>G :tabnew<CR>:G<CR><c-W>o
