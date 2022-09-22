FROM alpine:3.16.2

# Base container setup
RUN apk update && \
    apk add tzdata && \
    apk add openssl

ENV TZ="Europe/Brussels"

# Create base folders for CA
RUN mkdir /opt/cabox \
          /opt/cabox/certs \
          /opt/cabox/CRL \
          /opt/cabox/private \
          /opt/cabox/CSRs

COPY ./init.sh /root
