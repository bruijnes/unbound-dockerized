# Use Gnu C compiler from Docker hub
FROM gcc:latest

RUN mkdir -p /app

# Define our workdir
WORKDIR /app

# Create required username and group
RUN groupadd unbound
RUN useradd -r -g unbound unbound

RUN chown -R unbound:unbound /app

# Add latest unbound sourcecode to our build.
ADD https://nlnetlabs.nl/downloads/unbound/unbound-latest.tar.gz /app

# Unpack the install package
RUN tar --strip-components=1 -zxvf unbound-latest.tar.gz

# Configure our build
RUN ./configure

# Build it
RUN make

# MAke it install
RUN make install

# Add our config file and entrypoint script
COPY unbound.conf /app/unbound.conf
COPY entrypoint.sh /app/entrypoint.sh

# Expose dns ports
EXPOSE 53/udp
EXPOSE 53/tcp

# Here we go ;)
ENTRYPOINT [ "/app/entrypoint.sh" ]


