#!/bin/bash

docker pull consul

docker stop consul-server -t0

docker run --rm --network=host -d --name=consul-server consul
