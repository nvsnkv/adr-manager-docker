# Self-Hosted ADR Manager Instance
Set of dockerfiles and docker compose to run your own, self-hosted version of [ADR-Manager](https://github.com/adr/adr-manager)

## How-to
1. run `git submodule init` to get dependencies
2. use `pizzly/Dockerfile` to build pizzly backend
3. use `Dockerfile` in the repo root to build the container that will host ADR-Manager app
4. use `docker-compose.yaml` to run solution
5. follow [readme](https://github.com/adr/adr-manager#readme) and have fun!

## What's inside?
docker-compose.yaml creates following services:
* adr-manager - frontend. ADR-Manager does not have docker files in their repo so far, please use `Dockerfile` to create an image and name it adr-manager
* pizzly - OAuth backend for ADR-Manager instance. There is no official image in docker hub, please use `pizzly/Dockerfile` to create an image and name it pizzly
* postgres - database for Pizzly. Official image from docker hub.