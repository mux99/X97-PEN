# Simulates the firewall/router sitting between the four network
# zones. Real IP forwarding + real iptables rules - not just an
# incidental side effect of a dual-homed host.
#
# Currently PERMISSIVE on purpose (see entrypoint.sh): the ruleset
# allows forwarding between every zone so nothing built so far (recon,
# scanning, service access) is accidentally blocked. Tighten this once
# S12 (segmentation & defense evasion) is actually being built -
# that's the session this container exists for.

FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends iptables iproute2 && \
    rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
