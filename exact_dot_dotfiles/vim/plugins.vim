" Autoload vim plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'mhinz/vim-signify'
Plug 'kaicataldo/material.vim'
Plug 'mileszs/ack.vim'
Plug 'zachahn/vim-ack-ag'
Plug 'wincent/command-t', { 
      \ 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make'
      \ }

call plug#end()
