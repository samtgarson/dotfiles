**dotfiles** _my dotfiles and "new machine" setup_


### What does it do
Sets up my home directory with dotfiles and installs everything a new machine needs to be used by me, using [chezmoi](https://github.com/twpayne/chezmoi).

Setup includes:

- oh-my-zsh
- vim plugins
- spaceship shell
- asdf (for managing versoins of ruby, node, python, kubectl and others)
- other miscellaneous tools

### Use it

1. install `chezmoi`
2. `chezmoi init https://github.com/samtgarson/dotfiles.git`
3. take a last look at what is included to be sure
4. `chezmoi apply` to install everything in one command


