FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends openssh-server iproute2 iputils-ping && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /var/run/sshd && \
    useradd -m -s /bin/bash k.giguere && \
    echo "k.giguere:Fallback#2022" | chpasswd

COPY sshd_config /etc/ssh/sshd_config
COPY banner.txt /etc/ssh/banner.txt

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
