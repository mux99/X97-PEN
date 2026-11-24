# STUB - backup server (management network). Expand later if you want
# a "backup credentials left on an exposed share" teaching moment.

FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends socat && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 22

CMD ["socat", "TCP-LISTEN:22,fork,reuseaddr", "SYSTEM:echo stub-backup01"]
