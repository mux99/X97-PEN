# Student attack box - starts on the DMZ network only (external
# attacker foothold). Base Kali image; add tools as the course needs
# them session by session rather than installing everything up front.

FROM kalilinux/kali-rolling

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        nmap dnsutils whois iputils-ping curl \
        smbclient enum4linux-ng hydra john \
        theharvester wireshark-common tcpdump \
        openssh-client netcat-traditional \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root
CMD ["sleep", "infinity"]
