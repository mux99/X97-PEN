FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends vsftpd && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -m -s /bin/bash operator && \
    echo "operator:Operator2023" | chpasswd && \
    mkdir -p /srv/ftp/cnc-programs && \
    mkdir -p /srv/ftp/pub && \
    chown -R ftp:ftp /srv/ftp/pub && \
    chown -R operator:operator /srv/ftp/cnc-programs

COPY vsftpd.conf /etc/vsftpd.conf
COPY welcome.txt /srv/ftp/pub/welcome.txt
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 21 21100-21110

ENTRYPOINT ["/entrypoint.sh"]
