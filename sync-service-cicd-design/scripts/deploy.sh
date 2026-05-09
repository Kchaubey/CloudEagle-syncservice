#!/bin/bash

ENV=$1

echo "Deploying sync-service to ${ENV}"

docker compose -f deploy/${ENV}/docker-compose.yml pull

docker compose -f deploy/${ENV}/docker-compose.yml up -d

./scripts/health-check.sh ${ENV}
