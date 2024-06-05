#!/bin/sh

# Ensure permissions are dset on the workdir (/app)
chown -R unbound:unbound /app

# Write unbound config
cat > /app/unbound.conf <<EOL
server:
    directory: "/app"
    chroot: "/app"
    pidfile: "/app/unbound.pid"
    username: unbound
    use-syslog: no
    logfile: ""
    verbosity: 2
    log-queries: yes
    interface: ${INTERFACE_V4}
    interface: ${INTERFACE_V6}
    access-control: ${ALLOW_V4} allow
    #access-control: ${ALLOW_V6} allow
EOL

# Ensure RW permissions of config file
chmod 0600 /app/unbound.conf

# Run Unbound with the specified config
exec unbound -d -c /app/unbound.conf