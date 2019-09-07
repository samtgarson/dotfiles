" Autoload vim plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'
Plug 'kaicataldo/material.vim'
Plug 'wincent/command-t', { 
      \ 'do': 'cd ruby/command-t/ext/command-t && chruby system && ruby extconf.rb && make'
      \ }

call plug#end()
