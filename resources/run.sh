#!/bin/bash

echo "Starting minecraft server...."

# EULAに同意
if [ ! -e eula.txt ]; then
	echo eula=${EULA:-true} > eula.txt
else 
	sed -ie "s/eula=false/eula=${EULA:-true}/" eula.txt
fi

# サーバ設定反映
if [ -e server.properties ]; then
	sed -ie "s/online-mode=.*/online-mode=${ONLINE_MODE:-true}/" server.properties
	echo "online-mode: ${ONLINE_MODE:-true}"
	sed -ie "s/server-port=.*/server-port=${PORT:-25565}/" server.properties
	echo "server-port: ${PORT:-25565}"
fi

# サーバ設定反映 
if [ -e spigot.yml ]; then
	sed -ie "s/bungeecord: .*/bungeecord: ${BUNGEECORD:-false}/" spigot.yml
	echo "bungeecord: ${BUNGEECORD:-false}"
fi

if [ "${BOOT_MODE}" = "BASH" ]; then
	/bin/bash
else
	java -Xmx${MEM_MAX} -Xms${MEM_MAX} -jar $(find /opt -type f -maxdepth 1 -name "spigot-*.jar")
fi
