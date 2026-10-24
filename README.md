# .dotfiles

- nvim config based off [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)
- tmux-sessionizer courtesy of [ThePrimeagen](https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer)
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
- `~/.zshrc` - a separate file per os, nothing shared

to add a setting that differs per os, put it in the `*-os` / `*.os` file under
both `macos/` and `linux/`. a config that only exists on one os gets its own
package under that os dir.

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

### moving from the old layout

packages used to sit at the repo root, so after pulling the old links point
nowhere. remove the dangling ones and stow again:
```sh
{ find ~ -maxdepth 1 -type l; find ~/.config ~/.local -type l; } 2>/dev/null |
while read -r l; do
  [ ! -e "$l" ] && case "$(readlink "$l")" in *.dotfiles/*) rm -v "$l" ;; esac
done
```
then run the stow commands above.

## bin

scripts in `common/bin` go to `~/.local/bin`. symlinks that installers drop
there (`claude`, `bob`, `kitty`, `kitten`) are machine specific and ignored in
`.gitignore`.

## tmux

- prefix is set to ctrl + a
- prefix + f opens tmux-sessionizer
