docker_up(){
  docker-machine start dev
}

docker_down(){
  docker-machine stop dev
}

drop_the_mic(){
  docker ps -qa | xargs docker rm -fv
}

bye_bye_dangling(){
  docker images -q --filter "dangling=true" | xargs -n1 docker rmi -f
}

# TODO: inspect status
# if [ "$(boot2docker status)" != "running" ]; then
#   docker_up
# fi
docker_up

if [ -z "$DOCKER_HOST" ]; then
  export DOCKER_IP=$(docker-machine ip dev)
  eval $(docker-machine env dev)
fi

if ! docker ps | grep -q mysql_container ; then
  docker rm mysql_container > /dev/null 2>&1
  docker run -d -v /etc/my.cnf:/etc/mysql/conf.d -e MYSQL_ROOT_PASSWORD=root -p '3307:3306' --name="mysql_container" mysql:5.6.25 1> /dev/null
fi

export DATABASE_DSN="root:root@tcp($DOCKER_IP:3307)/"