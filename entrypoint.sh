#!/usr/bin/env sh
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH

sed 's/rpc-secret.*/rpc-secret='$rpc'/g' -i   /root/.aria2/aria2.conf
filebrowser -r /  --baseurl /file &
/home/caddy/caddy --conf=/home/caddy/Caddyfile -agree  &
/etc/init.d/aria2 start
tail -f /root/.aria2/aria2.log
