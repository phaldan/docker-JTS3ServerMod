# JTS3ServerMod

[![](https://images.microbadger.com/badges/version/phaldan/jts3servermod.svg)](https://microbadger.com/images/phaldan/jts3servermod) [![](https://images.microbadger.com/badges/image/phaldan/jts3servermod.svg)](https://microbadger.com/images/phaldan/jts3servermod) [![](https://img.shields.io/docker/stars/phaldan/jts3servermod.svg)](https://hub.docker.com/r/phaldan/jts3servermod/) [![](https://img.shields.io/docker/pulls/phaldan/jts3servermod.svg)](https://hub.docker.com/r/phaldan/jts3servermod/) [![](https://img.shields.io/docker/automated/phaldan/jts3servermod.svg)](https://hub.docker.com/r/phaldan/jts3servermod/)

Size optimised docker image based on [openjdk:8-jre-alpine](https://hub.docker.com/_/openjdk/) image:

* `6.5.6`, `6.5`, `6`, `latest` ([Dockerfile](https://github.com/phaldan/docker-JTS3ServerMod/blob/9a5460343d5a1ef8f166d5e18111df8a9ad1c6c2/Dockerfile))
* `6.4.5`, `6.4` ([Dockerfile](https://github.com/phaldan/docker-JTS3ServerMod/blob/d854cd3cfa24b65b5dca2f05c17814e7888a3317/Dockerfile))

## Run JTS3ServerMod

```
$ docker run --name jts3servermod -d -v ${PWD}/config:/JTS3ServerMod/config -v ${PWD}/log:/JTS3ServerMod/log phaldan/jts3servermod
```

## What is JTS3ServerMod

[JTS3ServerMod](https://www.stefan1200.de/forum/index.php?topic=2.0) is a bot developed by Stefan1200 and adds some functions to the Teamspeak 3 server. Here is the feature list:

* Add a server group to an idle client, to put the server group name (e.g. AFK) to the client name. (since version 6.3)
* Inactive Clients Cleaner can delete clients from TS3 server database after a specified inactivity time. (since version 6.3)
* Inactive Channel Check can delete a channel, if it's empty for X hours. (since version 5.2)
* Channel Notify sends a message to specified clients, if clients join a specified channel. (since version 3.7)
* Auto Moves clients of specified server groups to specified channels on connection. (since version 3.6.3)
* Server Group Notify sends a message to specified clients, if members of a specified server group connects to TS3 server. (since version 3.6.2)
* Server Group Protection to kick people which are unauthorized member of a protected server group. (since version 3.0)
* Bad nickname check to kick people with a bad name from the server. (since version 3.0)
* Bad channel name check to delete channels with a bad name. (since version 3.0)
* Move idle users to another channel and sends a message.
* Kick idle users with a kick reason. (since version 2.0)
* Send a warning message if someone is idle.
* Move to a specified channel if client status is away (after some seconds idle), can move back if not away anymore (move back since version 2.0)
* Move to a specified channel if client status is headphone or microphone muted (after some seconds idle), can move back if not muted anymore (since version 3.0)
* Move recording users to another channel and sends a message
* Kick recording users from server with a kick reason
* Send a message every X minutes to virtual server or a special channel
* Send a welcome message to every connecting client, can send a special welcome message to specified server group members
* !lastseen chat command to see somebody's last online time.

## Configure

The following describes the basic configuration of JTS3ServerMod. A more detailed documention can be found on the [official page](https://www.stefan1200.de/forum/index.php?topic=2.0). 
The most important file is the main config, which is located at `config/JTS3ServerMod_InstanceManager.cfg`. Within the main config file you can set global admins and register server instances ([example](https://github.com/phaldan/docker-JTS3ServerMod/blob/master/config/JTS3ServerMod_InstanceManager.cfg)). 
Each server has his own config file (like `config/server1/JTS3ServerMod_server.cfg`) for enable/disable functionalities and define query connection settings to your TeamSpeak 3 server ([example](https://github.com/phaldan/docker-JTS3ServerMod/blob/master/config/server1/JTS3ServerMod_server.cfg)). The default server config is a minimal version and can be extended with a lot settings for each functionality ([example](https://github.com/phaldan/docker-JTS3ServerMod/blob/master/config/JTS3ServerMod_server_example.cfg)). Additionally to the server config each server has a few more config files, which mostly define bot-messages for different functionalities.

### Directory structure with a single server instance

```
config/
├── JTS3ServerMod_InstanceManager.cfg
├── JTS3ServerMod_server_example.cfg
└── server1
    ├── advertising.cfg
    ├── autokicktimermessages.cfg
    ├── automove.cfg
    ├── awaymessages.cfg
    ├── badchannelname.cfg
    ├── badnickname.cfg
    ├── channelnotifymessages.cfg
    ├── idlecheckmessages.cfg
    ├── idlemessages.cfg
    ├── JTS3ServerMod_server.cfg
    ├── mutemessages.cfg
    ├── recordmessages.cfg
    ├── servergroupnotifymessages.cfg
    ├── servergroupprotection.cfg
    └── welcomemessages.cfg
```
