# Use Gnu C compiler from Docker hub
FROM gcc:latest

RUN mkdir -p /app

# Define our workdir
WORKDIR /app

# Add latest unbound sourcecode to our build.
ADD https://nlnetlabs.nl/downloads/unbound/unbound-latest.tar.gz /app

# Unpack the install package
RUN tar --strip-components=1 -zxvf unbound-latest.tar.gz

# Configure our build
RUN ./configure

# Build it
RUN make

# Make it install
RUN make install

# Set required execute permission on entrypoint scipt
RUN chmod +x /app/entrypoint.sh

# Use the script to startup the unbound daemon.
ENTRYPOINT [ "/app/entrypoint.sh" ]
