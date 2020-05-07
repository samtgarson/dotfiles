📦

**dotfiles** _my dotfiles and "new machine" setup_


### What does it do
Sets up my home directory with dotfiles and installs everything a new machine needs to be used by me, using [chezmoi](https://github.com/twpayne/chezmoi).

Setup includes:

- oh-my-zsh
- vim plugins
- starship prompt
- asdf (for managing versoins of ruby, node, python, kubectl and others)
- fzf used in various ways
- many personalised aliases and functions
- other miscellaneous tools

### Use it

1. install `chezmoi` (`curl -sfL https://git.io/chezmoi | sh`)
2. `chezmoi init https://github.com/samtgarson/dotfiles.git`
3. `chezmoi diff` to comparec config files (this does not display scripts that will run, so take a last look at what is included to be sure)
4. `chezmoi apply` to install everything in one command

### Contribute

- Keep configuration stored in a folder under its domain
- To add to `.zshrc`, create a file in the domain directory called `config.zsh`
- If writing a script, ensure it's idempotent—it should check if it needs to run before executing.
- More info in the [chezmoi docs](https://github.com/twpayne/chezmoi/blob/master/docs/HOWTO.md)
