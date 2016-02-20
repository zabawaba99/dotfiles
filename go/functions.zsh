if ! command -v gocov > /dev/null; then
  go get github.com/axw/gocov/gocov
fi

if ! command -v gocov-html > /dev/null; then
  go get github.com/matm/gocov-html
fi

if ! command -v godep > /dev/null; then
  go get github.com/tools/godep
fi

go_coverage() {
  json=$(mktemp)
  html=$(mktemp)

  echo "Generating coverage report"
  gocov test ./... > ${json}

  gocov-html ${json} > ${html}.html
  open ${html}.html
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

godep_audit() {
  for dep in $(cat Godeps/Godeps.json | jq -r '.Deps[].ImportPath' | cut -d '/' -f 1-3 | sort -u); do
    echo "Auditing $dep"

    cd $GOPATH/src/$dep
    echo "Pulling master of $(pwd)"
    git checkout master > /dev/null 2>&1
    git pull > /dev/null 2>&1
    cd -

    godep update $dep/...
    godep go build
    godep go test ./...
    git add Godeps/*
    git commit -m "updating $dep"
  done
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