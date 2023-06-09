#!/bin/sh
if [ ! "$(id -u steam)" -eq "$UID" ]; then 
        usermod -o -u "$UID" steam ; 
fi
if [ ! "$(id -g steam)" -eq "$GID" ]; then 
        groupmod -o -g "$GID" steam ; 
fi

if [ "$SMB_ENABLE" = true ]; then
apt install samba -y
rm /etc/samba/smb.conf

echo "[global]
port = ${SMB_PORT}
workgroup = WORKGROUP
log file = /var/log/samba/log.%m
max log size = 1000
logging = file
panic action = /usr/share/samba/panic-action %d
server role = standalone server
obey pam restrictions = yes
unix password sync = yes
passwd program = /usr/bin/passwd %u
passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
pam password change = yes
map to guest = bad user
usershare allow guests = yes
[homes]
   comment = Home Directories
   browseable = no
   read only = yes
   create mask = 0700
   directory mask = 0700
   valid users = %S
[printers]
   comment = All Printers
   browseable = no
   path = /var/spool/samba
   printable = yes
   guest ok = no
   read only = yes
   create mask = 0700
[print$]
   comment = Printer Drivers
   path = /var/lib/samba/printers
   browseable = yes
   read only = yes
   guest ok = no" | tee /etc/samba/smb.conf > /dev/null
fi

watch -n3 "ls -la /root"
