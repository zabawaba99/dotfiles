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

godep_audit() {
  function foo() {
    echo "Auditing $1"

    curdir=$(pwd)
    cd $GOPATH/src/$1
    echo "Pulling master of $(pwd)"
    git checkout master > /dev/null 2>&1
    git pull > /dev/null 2>&1
    cd $curdir

    godep update $1/...
    godep go build
    godep go test ./...
    git add Godeps/*
    git commit -m "updating $1"
  }

  cat Godeps/Godeps.json | jq -r '.Deps[].ImportPath' | cut -d '/' -f 1-3 | sort -u | xargs -n1 foo
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