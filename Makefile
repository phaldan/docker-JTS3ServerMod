MAKE=make -s
UPGRADE_SCRIPT=upgrade.sh
DOCKER_CLI=$(shell which docker.io || which docker)
DOCKER_IMAGE=phaldan/jts3servermod
DOCKER_CONTAINER=jts3servermod
VERSION?=6.3.3

.PHONY : all build update run clear logs

all: build

build:
	$(DOCKER_CLI) build --build-arg JTS3_SERVER_MOD_VERSION=$(VERSION) -t $(DOCKER_IMAGE):$(VERSION) .

update:
	$(DOCKER_CLI) pull $(shell sed -n 's/^FROM //p' Dockerfile)
	$(MAKE) build

run:
	$(DOCKER_CLI) run  -d --name $(DOCKER_CONTAINER) \
	-v ${PWD}/config:/JTS3ServerMod/config \
	-v ${PWD}/log:/JTS3ServerMod/log \
	$(DOCKER_IMAGE):$(VERSION)

clear:
	$(DOCKER_CLI) stop $(DOCKER_CONTAINER)
	$(DOCKER_CLI) rm $(DOCKER_CONTAINER)

logs:
	$(DOCKER_CLI) logs $(DOCKER_CONTAINER)

upgrade: update
	curl -o $(UPGRADE_SCRIPT) https://raw.githubusercontent.com/phaldan/docker-tags-upgrade/master/$(UPGRADE_SCRIPT)
	chmod +x $(UPGRADE_SCRIPT)
	./$(UPGRADE_SCRIPT) "$(DOCKER_IMAGE)" "$(VERSION)"

