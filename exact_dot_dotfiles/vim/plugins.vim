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
"Plug 'posva/vim-vue'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'neoclide/jsonc.vim'
Plug 'towolf/vim-helm'
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'svermeulen/vim-easyclip'
Plug 'tpope/vim-repeat'

call plug#end()
