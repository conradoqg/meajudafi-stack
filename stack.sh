#!/bin/bash

set -e

# load the library
. bashopts.sh # For more information check it out https://gitlab.mbedsys.org/mbedsys/bashopts

# Enable backtrace display on error
#trap 'bashopts_exit_handle' ERR

# Initialize the library
bashopts_setup -n $0 -d "Stack manager" -u "$0 [options and commands] [-- [extra args]]" -x

# Declare the options
bashopts_declare -n ACTION -l action -o a -d "Action" -t enum -e 'deploy' -e 'remove' -r
bashopts_declare -n ENV -l environment -o e -d "Environemnt" -t enum -e 'prod' -e 'dev' -r
bashopts_declare -n PGADMIN_EMAIL -l pgadmin-username -d "PGAdmin email" -t string -v user@domain.com
bashopts_declare -n PGADMIN_PASSWORD -l pgadmin-password -d "PGAdmin password" -t string -v temporary
bashopts_declare -n POSTGRES_USERNAME -l postgres-username -d "Postgres username" -t string -v postgres
bashopts_declare -n POSTGRES_PASSWORD -l postgres-password -d "Postgres password" -t string -v temporary
bashopts_declare -n POSTGRES_READONLY_USERNAME -l postgres-readonly-username -d "Postgres readonly username" -t string
bashopts_declare -n POSTGRES_READONLY_PASSWORD -l postgres-readonly-password -d "Postgres readonly password" -t string

# Parse arguments
bashopts_parse_args "$@"

# Process options
bashopts_process_opts

if [ $ACTION = "deploy" ]; then 
    if [ $ENV = "dev" ]; then
        POSTGRES_READONLY_USERNAME="readonly"
        POSTGRES_READONLY_PASSWORD="KM8Rd9cJ4724nbRW"
    elif [ $ENV = "prod" ]; then
        if [ -z "$POSTGRES_READONLY_USERNAME" ]; then
            echo "POSTGRES_READONLY_USERNAME is missing"
            exit 1
        fi
        if [ -z "$POSTGRES_READONLY_PASSWORD" ]; then
            echo "POSTGRES_READONLY_PASSWORD is missing"
            exit 1
        fi
    fi

    echo "Deploying $ENV environment stack"

    echo "Checking volumes"    
    POSTGRES_VOLUME_COUNT=$(docker volume ls | grep -c postgres || true)
    PGADMIN_VOLUME_COUNT=$(docker volume ls | grep -c pgadmin || true)

    echo "Checking network"
    STACK_INTERNAL_NETWORK_COUNT=$(docker network ls | grep -c stack_internal_network || true)        

    if [ "$POSTGRES_VOLUME_COUNT" -eq 0 ]; then
        echo "Creating postgresql volume"
        docker volume create --name=postgresql
    fi

    if [ "$POSTGRES_VOLUME_COUNT" -eq 0 ]; then
        echo "Creating pgadmin volume"
        docker volume create --name=pgadmin
    fi    

    if [ "$STACK_INTERNAL_NETWORK_COUNT" -eq 0 ]; then
        echo "Creating stack_internal_network network"
        docker network create --driver overlay --attachable stack_internal_network
    fi     

    export COMPOSE_CONVERT_WINDOWS_PATHS=1
    docker stack deploy --compose-file docker-compose.base.yaml --compose-file docker-compose.${ENV}.yaml meajudafi
elif [ $ACTION = "remove" ]; then
    docker stack rm meajudafi
fi