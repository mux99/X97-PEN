# --- INTENTIONALLY OLD BASE IMAGE ---
# Debian Jessie shipped Samba 4.2.x, which is affected by CVE-2017-7494
# ("SambaCry" / is-known-pipename RCE). Jessie is EOL, so we pull from
# the Debian archive mirror instead of the normal (removed) repos.
# This box represents "the old ERP file server nobody ever decommissioned."

FROM debian:jessie

RUN echo "deb http://archive.debian.org/debian jessie main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security jessie/updates main" >> /etc/apt/sources.list && \
    apt-get -o Acquire::Check-Valid-Until=false update && \
    apt-get install -y --no-install-recommends samba && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /srv/erp/import && \
    chmod -R 0777 /srv/erp/import

COPY smb.conf /etc/samba/smb.conf
COPY readme.txt /srv/erp/import/readme.txt

EXPOSE 139 445

CMD ["smbd", "-F", "--no-process-group"]
