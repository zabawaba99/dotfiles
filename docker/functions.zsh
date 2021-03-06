drop_the_mic(){
  docker ps -qa | xargs docker rm -fv
}

bye_bye_dangling(){
  docker images -q --filter "dangling=true" | xargs -n1 docker rmi -f
}

start_mysql_container() {
  if ! docker ps | grep -q mysql_container ; then
    docker rm mysql_container > /dev/null 2>&1
    docker run -d -e MYSQL_ROOT_PASSWORD=root -p '3307:3306' --name="mysql_container" mysql:5.6.25 1> /dev/null
  fi

  export DATABASE_DSN="root:root@tcp($DOCKER_IP:3307)/"
}
start_mysql_container

start_rabbit_container() {
  if ! docker ps | grep -q rabbit_container ; then
    docker rm rabbit_container > /dev/null 2>&1
    docker run -d -hostname my-rabbit --name rabbit_container -p 15672:15672 -p 5672:5672 rabbitmq:3-management 1> /dev/null
  fi

  export RABBITMQ_URI="root:root@tcp($DOCKER_IP:3307)/"
}
