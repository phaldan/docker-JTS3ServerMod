all:
	docker build -t phaldan/jts3servermod .

run:
	docker run --name jts3servermod -d -v ${PWD}/config:/JTS3ServerMod/config -v ${PWD}/log:/JTS3ServerMod/log phaldan/jts3servermod
