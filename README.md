📦

**dotfiles** _my dotfiles and "new machine" setup_


### What does it do
Sets up my home directory with dotfiles and installs everything a new machine needs to be used by me, using [chezmoi](https://github.com/twpayne/chezmoi).

Setup includes:

- oh-my-zsh (+ zplug, syntax highlighting, autosuggestions)
- starship prompt
- neovim & vim config
- mise (for managing versions of node, ruby, python, go and others)
- fzf used in various ways
- many personalised aliases and functions
- other miscellaneous tools

### Use it

1. install `chezmoi` (`curl -sfL https://git.io/chezmoi | sh`)
2. `chezmoi init https://github.com/samtgarson/dotfiles.git`
3. `chezmoi diff` to compare config files (this does not display scripts that will run, so take a last look at what is included to be sure)
4. `chezmoi apply` to install everything in one command

### Setup prompts

`chezmoi init` asks a few questions which decide how much gets installed:

- **Minimal install** — for ephemeral or short-lived machines where I just need to code comfortably for a while. Skips kubernetes and AWS tooling, Mac App Store apps, and everything non-essential.
- **Install desktop apps** (macOS only) — for machines with a GUI, as opposed to command line boxes and Raspberry Pis. Adds GUI apps, terminal config and macOS system settings.
- **Remote server** (Linux only) — installs the mosh server.
- **Languages** — pick which language toolchains mise should install.

The two can combine: a minimal desktop install gets a working GUI machine without the full app list.

### Contribute

- Keep configuration stored in a folder under its domain
- To add to `.zshrc`, create a file in the domain directory called `config.zsh`
- If writing a script, ensure it's idempotent—it should check if it needs to run before executing.
- More info in the [chezmoi docs](https://github.com/twpayne/chezmoi/blob/master/docs/HOWTO.md)
