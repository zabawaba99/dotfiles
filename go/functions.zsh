go_sanity() {
  find . -path ./Godeps -prune -o -name '*.go' -exec gofmt -l -s {} + # make sure code is properly formatted and simplified
  test -z "$(find . -path ./Godeps -prune -o -name '*.go' -exec golint {} + | tee /dev/stderr)" # enforce styling
  go vet ./... # check for possible uh ohs
  find . -path ./Godeps -prune -o -name '*.go' -exec gocyclo -over 10 {} + # check code complexity. 1 is the base complexity of a function +1 for each 'if', 'for', 'case', '&&' or '||'
  godep go test -v -race # run tests checking for race conditions
}

go_cleanup() {
  gofmt -s -w .

  # reset godeps if gofmt cleaned them up
  godep_changes=$(git status | grep Godeps | wc -l)
  if [ "$godep_changes" -gt "0" ]
    then
      echo -e "${yellow}resetting godeps to HEAD"
      git checkout HEAD -- Godeps
  fi
}

godep_update() {
  git checkout master
  git pull
  git checkout -B updating-croods
  git rebase master
  godep update "$@"
  git add Godeps/*
  git commit -m "updating godeps"
  git push --set-upstream origin updating-croods
  hub pull-request -m "update godeps"
}