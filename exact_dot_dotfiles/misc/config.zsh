source ~/.local/share/chezmoi/.helpers

is_installed thefuck && eval $(thefuck --alias)

if is_installed hub; then
	# Source hub aliases
  eval "$(hub alias -s)"

  alias pr='hub pull-request'
fi

alias fd=fdfind
