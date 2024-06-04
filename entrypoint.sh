#!/bin/sh

# Ensure permissions are correct
chown -R unbound:unbound /app/dev

# Ensure RW access permissions
chmod 0600 /app/unbound.conf

# Run Unbound with the specified config
exec unbound -d -c /app/unbound.conf