docker_up(){
  boot2docker up
  export DOCKER_IP=$(boot2docker ip 2> /dev/null)
  eval $(boot2docker shellinit 2> /dev/null)
}

drop_the_mic(){
  docker ps -qa | xargs docker rm -fv
}

bye_bye_dangling(){
  docker images -q --filter "dangling=true" | xargs -n1 docker rmi -f
}