# docker-rsyslog-logmatic

Docker container for [Logmatic](https://logmatic.io) (via rsyslog)

## Usage

### With Docker
```bash
docker run -e LOGMATIC_TOKEN="YOUR_TOKEN" -e LOGMATIC_TAGS='environment="staging" zone="europe"' quay.io/heetch/rsyslog-logmatic
```

### With Marathon and Docker

```
{
  "acceptedResourceRoles": [
    "slave_public",
    "*"
  ],
  "constraints": [
    [
      "hostname",
      "UNIQUE"
    ]
  ],
  "container": {
    "docker": {
      "forcePullImage": true,
      "image": "heetch/rsyslog-logmatic:latest",
      "forcePullImage": true,
      "network": "BRIDGE",
      "portMappings": [
        {
          "containerPort": 514,
          "hostPort": 5140,
          "protocol": "udp"
        }
      ]
    },
    "type": "DOCKER"
  },
  "cpus": 0.1,
  "env": {
    "LOGMATIC_TAGS": "environment=production,zone=europe",
    "LOGMATIC_TOKEN": "YOUR_TOKEN"
  },
  "id": "rsyslog-logmatic",
  "instances": xx,
  "mem": 64,
  "upgradeStrategy": {
    "maximumOverCapacity": 0,
    "minimumHealthCapacity": 0
  }
}
```

