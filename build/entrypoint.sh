#!/bin/sh

# Create required username and group for chroot to work
groupadd unbound
useradd -r -g unbound unbound

# Ensure permissions are dset on the workdir (/app)
chown -R unbound:unbound /app

# Ensure RW permissions of config file
chmod 0600 /app/unbound.conf

# Run Unbound with the specified config
exec unbound -d -c /app/unbound.conf