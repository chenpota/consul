# Run consul server

```
$ ./bin/run-consul-server.sh
```

Default HTTP port is 8500.  
Consul agent is installed to every host and it is a first-class cluster participant. So servers don’t need to know discovery address in our network, all requests to discovery are processed to local address 127.0.0.1.

[docker-consul](https://hub.docker.com/_/consul/)

| ENV-VAR               | DESCRIPTIONS                          |
|:----------------------|:------------------------------------- |
| CONSUL_BIND_INTERFACE | The network interface to bind          |

# Run multiple servers in a data center

```
172.17.0.2   172.17.0.3   172.17.0.4
+---------+  +---------+  +---------+
| server1 |  | server2 |  | server3 |
+---------+  +---------+  +---------+
 eth0|        eth0|        eth0|
     |            |            |
     +------------+------------+

# server1
$ docker run --rm \
    --name=server1 \
    -e CONSUL_BIND_INTERFACE=eth0 \
    -ti consul \
    agent \
        -node=server1 -server -client 0.0.0.0 -ui \
        -bootstrap-expect=3 \
        -retry-join="172.17.0.2" -retry-join="172.17.0.3" -retry-join="172.17.0.4"

# server2
$ docker run --rm \
    --name=server2 \
    -e CONSUL_BIND_INTERFACE=eth0 \
    -ti consul \
    agent \
        -node=server2 -server -client 0.0.0.0 -ui \
        -bootstrap-expect=3 \
        -retry-join="172.17.0.2" -retry-join="172.17.0.3" -retry-join="172.17.0.4"

# server3
$ docker run --rm \
    --name=server3 \
    -e CONSUL_BIND_INTERFACE=eth0 \
    -ti consul \
    agent \
        -node=server3 -server -client 0.0.0.0 -ui \
        -bootstrap-expect=3 \
        -retry-join="172.17.0.2" -retry-join="172.17.0.3" -retry-join="172.17.0.4"
```

# Run a server an a client in a data center

```
192.168.10.11   192.168.10.10
  +--------+      +--------+
  | server |      | client |
  +--------+      +--------+
   eth0|           eth0|
       +---------------+

# server1
$ docker run --rm \
    --network host \
    --name=server \
    -e CONSUL_BIND_INTERFACE=eth0 \
    -ti consul \
    agent \
        -node=server -server -client 0.0.0.0 -ui \
        -bootstrap-expect=1

# server2
$ docker run --rm \
    --network host \
    --name=client \
    -e CONSUL_BIND_INTERFACE=eth0 \
    -ti consul \
    agent \
        -node=client -ui \
        -join=192.168.10.11
```

# Run consul client

## python-client

# DNS query

```
$ dig @localhost -p 8600 <service-name>.service.consul
```

# API

## agent

### GET /v1/agent/monitor?loglevel=debug

This endpoint streams logs from the local agent until the connection is closed.

### GET /v1/agent/services

Return all the services that are registered with the local agent.

### PUT /v1/agent/service/register

Register a service.

### PUT /v1/agent/service/deregister/SERVICE-ID

Deregister a service.

## catalog

### GET /v1/catalog/datacenters

Return the list of all known datacenters.

### GET /v1/catalog/nodes?dc=DATA-CENTER-ID

Return the nodes registered in a given datacenter.

### GET /v1/catalog/node/NODE-ID?dc=DATA-CENTER-ID

Return the node's registered services.

### GET /v1/catalog/services?dc=DATA-CENTER-ID

Return the services registered in a given datacenter.

### GET /v1/catalog/service/SERVICE-ID?dc=DATA-CENTER-ID

Return the nodes providing a service in a given datacenter.

## health

### GET /v1/health/node/NODE-ID?dc=DATA-CENTER-ID

Return the checks specific to the node provided on the path.

### GET /v1/health/checks/SERVICE-ID?dc=DATA-CENTER-ID

Return the checks associated with the service provided on the path.

### GET /v1/health/service/SERVICE-ID?dc=DATA-CENTER-ID

Return the nodes providing the service indicated on the path.

## KV store

### PUT /v1/kv/.../KEY

Create or update /.../key.

### GET /v1/kv/.../KEY?raw

Read /.../key.

### DELETE /v1/kv/.../KEY

Delete /.../key.

### PUT /v1/kv/.../FOLDER/

Create or update /.../folder/.

### GET /v1/kv/.../FOLDER/?keys

Read /.../folder/.

### DELETE /v1/kv/.../FOLDER/

Delete /.../folder/.

## status

### GET /v1/status/leader

Return the Raft leader for the datacenter in which the agent is running.

# [GliderLabs Registrator](https://github.com/gliderlabs/registrator)

Service registry bridge for Docker.

```
$ docker run --rm \
    -v /var/run/docker.sock:/tmp/docker.sock \
    --network host \
    -d gliderlabs/registrator \
    -internal consul://localhost:8500

$ docker run --rm \
    -v /var/run/docker.sock:/tmp/docker.sock \
    -d gliderlabs/registrator \
    -ip <ip-address> \
    consul://<ip-address>:8500
```

```
$ docker run --rm \
    -p 12344:12345 \
    -e "SERVICE_NAME=myweb" \
    -e "SERVICE_CHECK_HTTP=/healthcheck" \
    -e "SERVICE_CHECK_INTERVAL=10s" \
    -d <docker-image>
```

# Prometheus

# Grafana