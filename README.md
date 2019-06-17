# How to use:

1. Install:

```bash
wget https://raw.githubusercontent.com/elderapo/docker-compose-override/master/install.sh | bash
```

2. Set env `DOCKER_COMPOSE_OVERRIDES`

```bash
export DOCKER_COMPOSE_OVERRIDES=docker-compose.yml,docker-compose.override-1.yml,docker-compose.override-2.yml
```

or write in `.env`

```bash
DOCKER_COMPOSE_OVERRIDES=docker-compose.yml,docker-compose.override-1.yml,docker-compose.override-2.yml
```

3. Use `dco` instead of `docker-compose`

```bash
dco up -d --build
```
