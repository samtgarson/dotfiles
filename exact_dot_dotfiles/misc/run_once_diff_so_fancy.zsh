#!/usr/bin/env zsh

source ~/.local/share/chezmoi/.helpers
source ~/.dotfiles/environment.zsh

function install_diff-so-fancy() {
  started Installing diff-so-fancy

  local download_url="https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy"
  local install_path=/usr/local/bin/diff-so-fancy

  successfully sudo curl -o $install_path $download_url
  successfully sudo chmod +x $install_path

  success Installed diff-so-fancy
}


if which diff-so-fancy > /dev/null; then
  success 'diff-so-fancy is already installed'
else
  successfully install_diff-so-fancy
fi

