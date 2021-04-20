#!/usr/bin/env zsh

export FORGIT_NO_ALIASES=1

source ~/.zplug/init.zsh

zplug "wfxr/forgit"
zplug "andrewferrier/fzf-z"
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
