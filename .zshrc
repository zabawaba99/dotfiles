
alias gocld="cd ~/go/src/github.com/CitrixConcierge"

# load all dotfiles
for file in ~/dotfiles/**/**.zsh; do
  echo $file
  source $file
done