# STUB - remote-access VPN gateway (DMZ). A real OpenVPN container is
# a reasonable later upgrade if you want a VPN-specific session; for
# now it just opens 1194/udp so it's visible during recon.

FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends socat && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 1194/udp

CMD ["socat", "UDP-LISTEN:1194,fork,reuseaddr", "SYSTEM:echo stub-vpn-gw"]
