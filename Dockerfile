FROM alpine:3.16.2

# Base container setup
RUN apk update      && \
    apk add tzdata  && \
    apk add openssl

ENV TZ="Europe/Brussels"

# Create base folders for CA
RUN mkdir /opt/ca-crate             \
          /opt/ca-crate/certs       \
          /opt/ca-crate/crl         \
          /opt/ca-crate/newcerts    \
          /opt/ca-crate/private     \
          /opt/ca-crate/CSRs

RUN touch /opt/ca-crate/index.txt       && \
    echo "0000" > /opt/ca-crate/serial  && \
    chmod 700 /opt/ca-crate/private

COPY ["./openssl.cnf", "/etc/ssl/openssl.cnf"]

COPY ["scripts", "/root"]
