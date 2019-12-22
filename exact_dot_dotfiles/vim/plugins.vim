call plug#begin('~/.vim/plugged')

Plug 'janko/vim-test'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
Plug 'chrisbra/unicode.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'suy/vim-context-commentstring'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'haishanh/night-owl.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'itchyny/lightline.vim'
Plug 'vim-scripts/gitignore'
"Plug 'jremmen/vim-ripgrep'
"Plug 'posva/vim-vue'
Plug 'sheerun/vim-polyglot'
"Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'neoclide/jsonc.vim'

call plug#end()
