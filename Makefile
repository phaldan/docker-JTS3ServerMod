.PHONY : all build run clear
VERSION?=3.0.13.6
DOCKER_CLI=$(shell which docker.io || which docker)
DOCKER_IMAGE=phaldan/jts3servermod
DOCKER_CONTAINER=jts3servermod

all: build

build:
	$(DOCKER_CLI) build -t $(DOCKER_IMAGE):$(VERSION) .

run:
	$(DOCKER_CLI) run  -d --name $(DOCKER_CONTAINER) \
	-v ${PWD}/config:/JTS3ServerMod/config \
	-v ${PWD}/log:/JTS3ServerMod/log \
	$(DOCKER_IMAGE):$(VERSION)

clear:
	$(DOCKER_CLI) stop $(DOCKER_CONTAINER)
	$(DOCKER_CLI) rm $(DOCKER_CONTAINER)

