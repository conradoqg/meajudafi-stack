#!/bin/sh

set -e

export COMPOSE_CONVERT_WINDOWS_PATHS=1

if [ $1 = "up" ]; then
    docker volume create --name=postgresql
    docker volume create --name=pgadmin
    docker stack deploy --compose-file docker-compose.base.yaml --compose-file docker-compose.dev.yaml cvmFundExplorer
elif [ $1 = "down" ]; then
    docker stack rm cvmFundExplorer
fi