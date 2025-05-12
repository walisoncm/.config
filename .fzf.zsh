# Setup fzf
# ---------
# (No need to fix PATH because fzf is installed globally in /usr/bin in WSL)

# Auto-completion
# ---------------
[ -f ~/.fzf/shell/completion.zsh ] && source ~/.fzf/shell/completion.zsh

# Key bindings
# ------------
[ -f ~/.fzf/shell/key-bindings.zsh ] && source ~/.fzf/shell/key-bindings.zsh

# Custom Key bindings

# Ensure precmds are run after cd
fzf-redraw-prompt() {
    for precmd in $precmd_functions; do
        $precmd
    done

    zle reset-prompt
}

# Custom function to change directory using fzf with a keybinding
find_workspace() {
    local dir
    dir=$(find ~/Development/workspace -maxdepth 3 -type d 2>/dev/null | fzf)
    if [[ -n "$dir" ]]; then
        cd "$dir"
        fzf-redraw-prompt
    fi
}

# Bind "Ctrl + F" to the find_workspace function
zle -N find_workspace
bindkey '^F' find_workspace
