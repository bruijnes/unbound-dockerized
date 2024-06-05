# Use Gnu C compiler from Docker hub
FROM gcc:latest

RUN mkdir -p /app

# Define our workdir
WORKDIR /app

# Add latest unbound sourcecode to our build.
ADD https://nlnetlabs.nl/downloads/unbound/unbound-latest.tar.gz /app
COPY ./entrypoint.sh /app/entrypoint.sh

# Unpack the install package
RUN tar --strip-components=1 -zxvf unbound-latest.tar.gz

# Configure our build
RUN ./configure

# Build it
RUN make

# Make it install
RUN make install

# Create required username and group for chroot to work
RUN groupadd unbound
RUN useradd -r -g unbound unbound

# Set required execute permission on entrypoint scipt
RUN chmod 0700 /app/entrypoint.sh

# Use the script to startup the unbound daemon.
ENTRYPOINT [ "/app/entrypoint.sh" ]
