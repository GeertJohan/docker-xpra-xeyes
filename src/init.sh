#!/bin/sh

# make .xpra writable for user
chown -R user:user /home/user/.xpra

# drop permissions and start xpra with xeyes
export HOME="/home/user"
sudo -u user xpra start :100 --start-child=xeyes --no-daemon --exit-with-children

