#!/bin/sh

set -e

export COMPOSE_CONVERT_WINDOWS_PATHS=1

if [ -n "$1" ]; then
    if [ $1 = "deploy" ]; then

        POSTGRES_VOLUME_COUNT=$(docker volume ls | grep -c postgres)
        PGADMIN_VOLUME_COUNT=$(docker volume ls | grep -c pgadmin)

        if [ -z "$2" ] || [ $2 = "dev" ]; then        
            ENV=dev    
        elif [ $2 = "prod" ]; then
            ENV=prod        
            if [ "$PGADMIN_VOLUME_COUNT" -eq 0 ] && [ -z "$PGADMIN_EMAIL" ]; then
                echo '$PGADMIN_EMAIL is missing'
                exit 1
            fi
            if [ "$PGADMIN_VOLUME_COUNT" -eq 0 ] && [ -z "$PGADMIN_PASSWORD" ]; then
                echo '$PGADMIN_PASSWORD is missing'
                exit 1
            fi
            if [ "$POSTGRES_VOLUME_COUNT" -eq 0 ] && [ -z "$POSTGRES_USERNAME" ]; then
                echo '$POSTGRES_USERNAME is missing'
                exit 1
            fi
            if [ "$POSTGRES_VOLUME_COUNT" -eq 0 ] && [ -z "$POSTGRES_PASSWORD" ]; then
                echo '$POSTGRES_PASSWORD is missing'
                exit 1
            fi
            if [ -z "$POSTGRES_READONLY_USERNAME" ]; then
                echo '$POSTGRES_READONLY_USERNAME is missing'            
                exit 1
            fi
            if [ -z "$POSTGRES_READONLY_PASSWORD" ]; then
                echo '$POSTGRES_READONLY_PASSWORD is missing'            
                exit 1
            fi
        fi

        echo "Deploying $ENV environment stack"

        if [ "$POSTGRES_VOLUME_COUNT" -eq 0 ]; then
            echo "Creating postgresql volume"
            docker volume create --name=postgresql
        fi

        if [ "$POSTGRES_VOLUME_COUNT" -eq 0 ]; then
            echo "Creating pgadmin volume"
            docker volume create --name=pgadmin
        fi

        docker network create --driver overlay --attachable stack_internal_network
        
        docker stack deploy --compose-file docker-compose.base.yaml --compose-file docker-compose.${ENV}.yaml cvmFundExplorer
    elif [ $1 = "rm" ]; then
        docker stack rm cvmFundExplorer
    fi
else
    echo "Usage: build ACTION ENVIRONMENT NAME WORKER_ARGS"
    echo ""
    echo "ACTION = deploy/rm"
    echo "ENVIRONMENT = dev/prod"    
fi