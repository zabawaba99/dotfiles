beanssh () {
  ssh -i ~/.ssh/cloudburrito -o UserKnownHostsFile=/dev/null -o CheckHostIP=no -o StrictHostKeyChecking=no -A ec2-user@$@
}

runAgainst() {
  cmd=$1
  shift

  for d in $@; do
    echo -e $green"In $d"$NC
    cd $d
    echo -e $green"Running cmd: "$yellow"$cmd"$NC
    eval $cmd
    cd ..
  done
}