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
$ dig @localhost -p 8600 consul.service.consul
```

# API

## GET /v1/agent/monitor?loglevel=debug

This endpoint streams logs from the local agent until the connection is closed.
