#!/bin/bash

docker run -d --name=grafana -p 3000:3000 grafana/grafana

sleep 7

auth_header=$(echo -n "admin:admin" | base64)


# Run Fusedrill CLI
docker run --network host --rm \
 -e FUSEDRILL_BASE_ADDRESS="http://localhost:3000/api" \
 -e FUSEDRILL_OPENAPI_URL="http://localhost:3000/public/openapi3.json" \
 -e FUSEDRILL_OAUTH_HEADER="Authorization: Basic $auth_header" \
 ghcr.io/fusedrill/fusedrill-cli:latest