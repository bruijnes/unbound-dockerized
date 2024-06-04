#!/bin/sh
set -e

# Create necessary devices inside the chroot
mkdir -p /app/dev
mknod -m 666 /app/dev/null c 1 3
mknod -m 666 /app/dev/random c 1 8
mknod -m 666 /app/dev/urandom c 1 9
mknod -m 666 /app/dev/zero c 1 5
mknod -m 666 /app/dev/stdout c 1 3
mknod -m 666 /app/dev/stderr c 1 3
mknod -m 666 /app/dev/stdin c 1 3

# Create necessary log file
touch /app/dev/log

# Ensure permissions are correct
chown -R unbound:unbound /app/dev

# Ensure RW access permissions
chmod 0600 /app/unbound.conf

# Run Unbound with the specified config
exec unbound -d -c /app/unbound.conf