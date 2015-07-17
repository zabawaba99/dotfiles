docker_up(){
  boot2docker up
}

drop_the_mic(){
  docker ps -qa | xargs docker rm -fv
}

bye_bye_dangling(){
  docker images -q --filter "dangling=true" | xargs -n1 docker rmi -f
}

if [ "$(boot2docker status)" != "running" ]; then
  docker_up
fi

if [ -z "$DOCKER_HOST" ]; then
  export DOCKER_IP=$(boot2docker ip 2> /dev/null)
  eval $(boot2docker shellinit 2> /dev/null)
fi

if ! docker ps | grep -q mysql_container ; then
  docker rm mysql_container > /dev/null 2>&1
  docker run -d -e MYSQL_ROOT_PASSWORD=root -p '3307:3306' --name="mysql_container" mysql:5.6 1> /dev/null
fi