# .dotfiles

- nvim config based off [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- tmux-sessionizer courtsey of [ThePrimeagen](https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer)
- relevant - [Stow](https://www.gnu.org/software/stow/)

## layout

packages are split by os, each top level dir is its own stow dir:

```
common/   bin grc kitty nvim tmux    shared across macos and linux
macos/    aerospace kitty tmux zsh
linux/    i3 i3status kitty tmux zsh
```

os specific settings live in their own files instead of conditionals:
- `~/.config/kitty-os.conf` - included at the end of `kitty.conf` (font size)
- `~/.tmux.os.conf` - sourced from `.tmux.conf` (copy mode clipboard command)

## stow

install stow:
```sh
brew install stow       # macos
sudo apt install stow   # linux
```

stow `common` and then the dir for the current os:
```sh
stow -d common -t ~ bin grc kitty nvim tmux
stow -d macos  -t ~ aerospace kitty tmux zsh     # macos
stow -d linux  -t ~ i3 i3status kitty tmux zsh   # linux
```

## tmux

prefix is set to ctrl + a
