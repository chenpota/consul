#!/bin/bash

docker stop consul-server -t0

docker run --rm \
	--network=host \
	--name=consul-server \
	-d consul
