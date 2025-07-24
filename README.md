# ShadowNode

ShadowNode is the server control plane for ShadowNode Panel. It's responsible for creating and managing server containers to provide a safe and secure environment for game servers to run without affecting other system services or users.

## Documentation

* [Panel Documentation](https://shadownode.io/panel/1.0/getting_started.html)
* [ShadowNode Documentation](https://shadownode.io/shadownode/1.0/installing.html)
* [Community Guides](https://shadownode.io/community/about.html)
* Or, get additional help [via Discord](https://discord.gg/shadownode)

## Reporting Issues

Please use the [shadownode/panel](https://github.com/shadownode/panel) repository to report any issues or make feature requests for ShadowNode. In addition, the [security policy](https://github.com/shadownode/panel/security/policy) listed there also applies to this repository.

## Building

To build ShadowNode, simply run the command below. This will generate a binary in the root directory that can be executed directly.

```bash
GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -gcflags "all=-trimpath=$(pwd)" -o shadownode -v shadownode.go
```

## Running

To run ShadowNode, simply execute the binary with the `--config` flag pointing to the location of the configuration file.

```bash
sudo ./shadownode --config /etc/shadownode/config.yml
```

### Debugging

You can run ShadowNode in debug mode by passing the `--debug` flag.

```bash
sudo ./shadownode --config /etc/shadownode/config.yml --debug
```

## Configuration

A sample configuration file is provided below. Note that only a subset of the configuration options are shown here.

```yaml
debug: false
uuid: ""
token_id: ""
token: ""
api:
  host: 0.0.0.0
  port: 8080
  ssl:
    enabled: false
    cert: ""
    key: ""
system:
  sftp:
    bind_port: 2022
```

### Docker

ShadowNode is designed to run in a containerized environment, and we provide an official Docker image for easy deployment.

```bash
docker run -d \
  --name shadownode \
  -p 8080:8080 \
  -p 2022:2022 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker/containers/:/var/lib/docker/containers/ \
  -v /etc/shadownode/:/etc/shadownode/ \
  -v /var/lib/shadownode/:/var/lib/shadownode/ \
  -v /var/log/shadownode/:/var/log/shadownode/ \
  -v /tmp/shadownode/:/tmp/shadownode/ \
  ghcr.io/shadownode/shadownode:latest
```

## License

ShadowNode is licensed under the [MIT License](https://github.com/TheShadowVOX/shadownode/blob/develop/LICENSE).