# bin/sh -e
export DC="docker compose -f 'docker-compose.dev.yml'"
alias dcb="$DC build"
alias dcu="$DC up"
alias dcub="$DC up --build"
alias dcd="$DC down"
alias dce="$DC exec app bundle exec"

dcclean(){
  docker stop $(docker ps -aq)
  docker rmi -f $(docker images -aq)
  docker volume rm $(docker volume ls -qf dangling=true)
}