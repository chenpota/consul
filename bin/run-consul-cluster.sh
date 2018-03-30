#!/bin/bash

docker run --rm --network host -d --name=dev-consul -e CONSUL_BIND_INTERFACE=enp3s0 consul

docker run --rm --name=server1  -d -e CONSUL_BIND_INTERFACE=eth0 consul agent -dev -join=140.92.71.70

docker run --rm --name=server2  -d -e CONSUL_BIND_INTERFACE=eth0 consul agent -dev -join=140.92.71.70
