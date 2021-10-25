drop_the_mic(){
  docker ps -qa | xargs docker rm -fv
}

bye_bye_dangling(){
  docker images -q --filter "dangling=true" | xargs -n1 docker rmi -f
}
