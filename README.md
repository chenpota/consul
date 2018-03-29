# Run consul server

```
$ ./bin/run-consul-server.sh
```

[consul](https://hub.docker.com/_/consul/)

# Run consul client

## python-client

* After stop consul server, client will not re-register to consul server.

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
