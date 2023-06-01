#!/usr/bin/env zsh

source ~/.zplug/init.zsh

zplug "lukechilds/zsh-better-npm-completion", defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load
