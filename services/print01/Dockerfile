# STUB - print server. Expand later (e.g. a real IPP/CUPS service +
# a known printer-firmware CVE) if you want a dedicated session on it.
# For now it just opens port 631 (IPP) so it shows up in scans.

FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends socat && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 631

CMD ["socat", "TCP-LISTEN:631,fork,reuseaddr", "SYSTEM:echo stub-print01"]
