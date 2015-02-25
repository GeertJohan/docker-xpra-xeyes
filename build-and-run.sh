#!/bin/bash

# echo commands
set -x

# kill any existing xpra-xeyes container
docker stop -t 3 xpra-xeyes 2>&1 > /dev/null
docker kill xpra-xeyes 2>&1 > /dev/null
docker rm xpra-xeyes 2>&1 > /dev/null

# build the container
docker build -t xpra-xeyes .

# start the container with .xpra socket folder bind-mounted.
# capture the containerID, (which is the socket's hostname).
CID=$(
	docker run -d \
		-v $HOME/.xpra:/home/user/.xpra \
		--name xpra-xeyes \
		xpra-xeyes
)

# sleep is required because the container and xpra server might not be fully started otherwise
sleep 2

# attach to the xpra server
XPRA_SOCKET_HOSTNAME="${CID:0:12}" xpra attach :100

# stop the xpra server
XPRA_SOCKET_HOSTNAME="${CID:0:12}" xpra stop :100
