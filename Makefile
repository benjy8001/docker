SHELL=/bin/sh

## Colors
ifndef VERBOSE
.SILENT:
endif
COLOR_COMMENT=\033[0;32m
IMAGE_PATH=/benjy80/docker
REGISTRY_DOMAIN=docker.io
VERSION=1.0.0


## Help
help:
	printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	printf " make [target]\n\n"
	printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	awk '/^[a-zA-Z\-\_0-9\.@]+:/ { \
		helpMessage = match(lastLine, /^## (.*)/); \
		if (helpMessage) { \
			helpCommand = substr($$1, 0, index($$1, ":")); \
			helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
			printf " ${COLOR_INFO}%-16s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
		} \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## build and push image
all: build push

## login on registry
registry_login:
	docker login ${REGISTRY_DOMAIN}

## build image and tags it
build:
	docker build -f docker/Dockerfile ./docker -t ${REGISTRY_DOMAIN}${IMAGE_PATH}:${VERSION}

## push image
push: registry_login
	docker push ${REGISTRY_DOMAIN}${IMAGE_PATH}:${VERSION}
