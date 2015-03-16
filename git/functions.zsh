git_prune() {
  git branch --merged | grep  -v "\*\|master" | xargs -n1 git branch -d
}