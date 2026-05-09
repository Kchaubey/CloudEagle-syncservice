#!/bin/bash

echo "Deployment failed. Rolling back..."

docker compose down

docker compose up -d previous-stable-image
