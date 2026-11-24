FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends samba && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -M -s /usr/sbin/nologin t.ricard && \
    (echo "Summer2024!"; echo "Summer2024!") | smbpasswd -a -s t.ricard && \
    mkdir -p /srv/samba/public /srv/samba/hr && \
    chmod -R 0777 /srv/samba/public && \
    chmod -R 0770 /srv/samba/hr

COPY smb.conf /etc/samba/smb.conf
COPY public-readme.txt /srv/samba/public/readme.txt

EXPOSE 139 445

CMD ["smbd", "--foreground", "--no-process-group", "--log-stdout"]
