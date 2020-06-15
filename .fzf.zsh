# Setup fzf
# ---------
if [[ ! "$PATH" == */home/bobby/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/bobby/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/bobby/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/bobby/.fzf/shell/key-bindings.zsh"
