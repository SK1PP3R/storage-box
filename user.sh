#!/bin/sh
if [ ! "$(id -u steam)" -eq "$UID" ]; then 
        usermod -o -u "$UID" steam ; 
fi
if [ ! "$(id -g steam)" -eq "$GID" ]; then 
        groupmod -o -g "$GID" steam ; 
fi
tail -f /var/log/auth.log
