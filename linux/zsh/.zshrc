# ~/.zshrc: ported from ~/.bashrc

# ---- History ----
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt APPEND_HISTORY        # like shopt -s histappend
setopt HIST_IGNORE_DUPS      # like HISTCONTROL=ignoredups
setopt HIST_IGNORE_SPACE     # like HISTCONTROL=ignorespace
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt PROMPT_SUBST          # allow $var/${...} expansion inside PROMPT

# ---- General shell behavior ----
unsetopt BEEP                 # no terminal bell (was: set bell-style none in .inputrc)

# globstar equivalent (** matches recursively) - uncomment to enable
# setopt GLOB_STAR_SHORT

# ---- less / lesspipe ----
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ---- debian_chroot (kept for parity, mostly irrelevant outside Debian chroots) ----
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# ---- Prompt ----
# zsh prompt escapes: %n=user %m=host %~=cwd(with ~) %(!.#.$)=$ normally, # if root
autoload -Uz colors && colors

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PROMPT='${debian_chroot:+($debian_chroot)}%F{magenta}%n@%m%f:%F{blue}%~%f%(!.#.$) '
else
    PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%(!.#.$) '
fi

# terminal title (xterm/rxvt), same idea as the bash case block
case "$TERM" in
    xterm*|rxvt*)
        precmd() { print -Pn "\e]0;${debian_chroot:+($debian_chroot)}%n@%m: %~\a" }
        ;;
esac

# ---- ls / grep colors + aliases ----
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# "alert" alias for long-running commands
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(fc -ln -1 | sed -e '\''s/^\s*//;s/[;&|]\s*alert$//'\'')"'

# ---- Extra aliases file (same as bash) ----
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# ---- Completion system (highlighted, arrow-navigable Tab menu) ----
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # colorize completions like ls

zmodload zsh/complist
bindkey -M menuselect '^[[Z' reverse-menu-complete   # Shift-Tab cycles backward
bindkey -M menuselect '\r' accept-line

# ---- Custom keybindings (ported from .inputrc) ----
bindkey -s '^F' 'tmux-sessionizer\n'   # Ctrl-F: run tmux-sessionizer
bindkey -s '^N' 'nvim\n'               # Ctrl-N: launch nvim

# ---- nvm ----
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
# nvm's bash_completion script is bash-specific; zsh's compinit (above)
# already handles nvm/node completion once nvm is loaded.

# ---- PATH / bob ----
export PATH="$PATH:$HOME/.local/bin"
[ -s "$HOME/.local/share/bob/env/env.sh" ] && . "$HOME/.local/share/bob/env/env.sh"

alias adbenv='source ~/.local/bin/adb-env'
alias sshqdc="ssh -i ~/.ssh/qdc_id_2026-8-23_131.pem"

# ---- Plugins ----
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
