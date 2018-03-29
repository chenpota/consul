#!/bin/bash

docker pull consul

docker stop dev-consul -t0

docker run --rm --network=host -d --name=dev-consul consul
