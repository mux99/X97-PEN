#!/bin/sh
set -e
mkdir -p /var/run/vsftpd/empty
exec /usr/sbin/vsftpd /etc/vsftpd.conf
