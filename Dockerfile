FROM alpine

ADD caddy/  /home/caddy/
ADD conf/  /root/
ADD aria2  /etc/init.d/
ADD bin/  /usr/bin/
ADD entrypoint.sh /entrypoint.sh
ADD ca-certificates.crt /etc/ssl/certs/
RUN chmod +x /usr/bin/aria2c /usr/bin/rclone /usr/bin/filebrowser /etc/init.d/aria2 /entrypoint.sh /home/caddy/caddy /root/.config/rclone/up.sh.bak

ENV rpc jaz

EXPOSE 80 6800

ENTRYPOINT [ "sh", "/entrypoint.sh" ]
