# ----------------------------------------------

# This came from Greg V's dotfiles:
#      https://github.com/myfreeweb/dotfiles
autoload -U colors && colors
setopt transient_rprompt; setopt prompt_subst

HISTFILE=~/.zsh_history
HISTSIZE=4096
SAVEHIST=4096

# Autoload git functions
fpath=(~/dotfiles/git/functions $fpath)
autoload -U ~/dotfiles/git/functions/*(:t)

# Enable auto-execution of functions.
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

# Append git functions needed for prompt.
preexec_functions+='preexec_update_git_vars'
precmd_functions+='precmd_update_git_vars'
chpwd_functions+='chpwd_update_git_vars'

# Set the prompt.
PROMPT=$'%{${fg[cyan]}%}%B%~%b$(prompt_git_info)%{${fg[default]}%} '

chpwd() {
    printf '\e]50;CurrentDir=%s\a' "$(pwd)"
}
# ----------------------------------------------

# ----------------------------------------------
# hombrew zsh

# completions
fpath=(/usr/local/share/zsh-completions $fpath)

zstyle ':completion:::git:*' script /usr/local/etc/bash_completion.d/git-completion.bash
fpath=(/usr/local/share/zsh/site-functions $fpath)

# online help
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/help

#syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR=/usr/local/share/zsh-syntax-highlighting/highlighters

autoload -U compinit && compinit
zmodload -i zsh/complist

# ----------------------------------------------

# load all dotfiles
for file in ~/dotfiles/**/**.zsh; do
  source $file
done
