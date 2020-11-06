#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers

if is_installed aws_completer; then
  successfully complete -C aws_completer aws
  successfully complete -C aws_completer awslocal
fi

