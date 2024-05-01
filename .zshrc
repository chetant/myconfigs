export PATH=$PATH:~/homebrew/bin
alias ll='ls -lha'
alias gits='git status'
alias gitl='git log'
alias gitd='git diff'
alias gitb='git branch'

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[Z" backward-kill-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
