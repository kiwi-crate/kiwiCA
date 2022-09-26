FROM alpine:3.16.2

# Base container setup
RUN apk update && \
    apk add tzdata && \
    apk add openssl

ENV TZ="Europe/Brussels"

# Create base folders for CA
RUN mkdir /opt/ca-crate \
          /opt/ca-crate/certs \
          /opt/ca-crate/CRL \
          /opt/ca-crate/private \
          /opt/ca-crate/CSRs

COPY ./init.sh /root
