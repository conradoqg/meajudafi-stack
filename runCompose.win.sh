#!/bin/sh

set -e

export COMPOSE_CONVERT_WINDOWS_PATHS=1
docker volume create --name=postgresql
docker-compose -f docker-compose.win.yaml up -d