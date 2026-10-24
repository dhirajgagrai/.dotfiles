#!/usr/bin/env bash
#
# Create a new tmux window or pane in the current pane's directory,
# activating the mlir venv when that directory is under ~/hexdev.
#
# Window names are left to tmux, which shows the running program.
#
# usage: hexdev-new-window.sh [window|hsplit|vsplit]
#        defaults to "window" when no argument is given

mode=${1:-window}

current_path=$(tmux display-message -p '#{pane_current_path}')

case $mode in
    window) tmux new-window   -c "$current_path" ;;
    hsplit) tmux split-window -h -c "$current_path" ;;
    vsplit) tmux split-window -v -c "$current_path" ;;
    *)      tmux display-message "hexdev-new-window: unknown mode '$mode'"; exit 1 ;;
esac

# The new window/pane is now the active one, so send-keys needs no -t.
if [[ $current_path == "$HOME/hexdev"* ]]; then
    tmux send-keys "source ~/hexdev/mlir-env/bin/activate" C-m

    if [[ -f "$HOME/.local/bin/hexdev-set-var.sh" ]]; then
        tmux send-keys "source ~/.local/bin/hexdev-set-var.sh" C-m
    fi

    tmux send-keys "clear" C-m
fi
