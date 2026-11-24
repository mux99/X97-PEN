#!/bin/sh
set -e

echo "[router] enabling IP forwarding"
sysctl -w net.ipv4.ip_forward=1 >/dev/null

echo "[router] flushing any existing rules"
iptables -F
iptables -t nat -F

# -----------------------------------------------------------------
# PERMISSIVE policy for now: allow forwarding in both directions
# between every zone this container touches, and masquerade so
# target hosts never need a static route back to kali - replies
# just come back through us automatically.
#
# This is intentionally wide open. The teaching point of a *filtered*
# segmented network (deny-by-default, narrow explicit allows, logging
# drops) is S12's job, not this box's starting state. When you build
# that session, this is the file to come back and tighten:
#   - swap the two ACCEPT lines below for a default DROP
#   - add explicit ACCEPT rules per allowed flow (zone, proto, port)
#   - add `-j LOG` on the default DROP so evasion attempts show up
# -----------------------------------------------------------------
iptables -P FORWARD ACCEPT
iptables -A FORWARD -j ACCEPT

for IF in $(ls /sys/class/net | grep -v lo); do
    iptables -t nat -A POSTROUTING -o "$IF" -j MASQUERADE
done

echo "[router] forwarding enabled, NAT configured on: $(ls /sys/class/net | grep -v lo | tr '\n' ' ')"
echo "[router] policy: PERMISSIVE (all zones can reach all zones) - tighten for S12"

tail -f /dev/null
