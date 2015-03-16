if [ -z "$DOCKER_HOST" ]; then
  eval $(boot2docker shellinit 2>/dev/null)
  export DOCKER_IP=$(boot2docker ip 2> /dev/null)
fi