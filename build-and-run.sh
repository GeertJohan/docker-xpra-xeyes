#!/bin/bash

set -x

docker stop -t 3 xpra-xeyes 2>&1 > /dev/null
docker kill xpra-xeyes 2>&1 > /dev/null
docker rm xpra-xeyes 2>&1 > /dev/null

docker build -t xpra-xeyes .

CID=$(
	docker run -d \
		-v $HOME/.xpra:/home/user/.xpra \
		--name xpra-xeyes \
		xpra-xeyes
)

sleep 1

XPRA_SOCKET_HOSTNAME="${CID:0:12}" xpra attach :100

XPRA_SOCKET_HOSTNAME="${CID:0:12}" xpra stop :100