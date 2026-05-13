set -g fish_greeting ""

alias ls="ls --color=auto"
alias ll="ls -lah"

set -gx EDITOR nvim

starship init fish | source

