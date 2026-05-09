#!/bin/bash

ENV=$1

echo "Running health check for ${ENV}"

sleep 15

curl -f http://localhost:8080/actuator/health

if [ $? -ne 0 ]; then
  echo "Health check failed"
  exit 1
fi

echo "Application healthy"
