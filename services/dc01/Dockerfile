# STUB - domain controller, enumeration-only.
#
# PEN stays scoped to network-layer pentesting; deep Active Directory
# attacks (Kerberoasting, ACL abuse, etc.) belong to the ADI/AUD
# courses later in the cursus. This host exists so students can see
# and enumerate a DC from the network - LDAP/Kerberos/SMB ports open,
# domain visible - without this course going deep on exploiting it.
#
# Swap this stub for the real samba/samba-ad-dc image when you're
# ready to build that session:
#   https://hub.docker.com/r/instantlinux/samba-dc  (or similar)
#
# For now this just opens the expected ports with a banner so Nmap/
# enum4linux have something to find.

FROM debian:12-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends socat && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 88 389 445

CMD ["sh", "-c", "socat TCP-LISTEN:445,fork,reuseaddr SYSTEM:'echo stub-dc01' & socat TCP-LISTEN:389,fork,reuseaddr SYSTEM:'echo stub-dc01' & wait"]
