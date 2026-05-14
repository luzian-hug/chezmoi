# =========================================================
# CORE SHELL SETUP
# =========================================================

set -g fish_greeting ""

set -gx EDITOR nvim

starship init fish | source
zoxide init fish | source


# =========================================================
# ALIASES
# =========================================================

alias ls="eza"
alias ll="ls -lah"
alias l="ll"


# =========================================================
# FZF + HISTORY SEARCH
# =========================================================

function fzf_history_search
    set query (commandline)

    history \
    | fzf --height 80% --reverse \
        --query="$query" \
        --prompt="history > " \
    | read -l result

    if test -n "$result"
        commandline --replace -- $result
    end
end




# =========================================================
# ZOXIDE FUZZY DIRECTORY JUMP (zi)
# =========================================================

function zi
    set dir (zoxide query -l | fzf --height 40% --reverse)

    if test -n "$dir"
        cd "$dir"
    end
end


# =========================================================
# FILE VIEWER / EDITOR (vf)
# =========================================================

function vf
    set file (fzf --height 80% --reverse \
        --preview 'bat --style=numbers --color=always {}')

    if test -n "$file"
        nvim "$file"
    end
end


# Key Bindings

bind \cr fzf_history_search
bind \cf vf
