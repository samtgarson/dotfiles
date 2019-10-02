" Autoload vim plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'Quramy/tsuquyomi'
Plug 'scrooloose/nerdtree'
Plug 'chrisbra/unicode.vim'
Plug 'cakebaker/scss-syntax.vim'
Plug 'tpope/vim-commentary'
Plug 'suy/vim-context-commentstring'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhinz/vim-signify'
Plug 'haishanh/night-owl.vim'
Plug 'itchyny/lightline.vim'
Plug 'mileszs/ack.vim'
Plug 'zachahn/vim-ack-ag'
Plug 'vim-scripts/gitignore'
"Plug 'posva/vim-vue'
Plug 'sheerun/vim-polyglot'
Plug 'wincent/command-t', { 
      \ 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
      \ }

call plug#end()
