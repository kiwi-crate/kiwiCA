FROM alpine:3.16.2

# Base container setup
RUN apk update      && \
    apk add tzdata  && \
    apk add openssl

ENV TZ="Europe/Brussels"

# Create base folders for CA
RUN mkdir /opt/kiwica             \
          /opt/kiwica/certs       \
          /opt/kiwica/crl         \
          /opt/kiwica/newcerts    \
          /opt/kiwica/private     \
          /opt/kiwica/CSRs

RUN touch /opt/kiwica/index.txt       && \
    echo "0000" > /opt/kiwica/serial  && \
    chmod 700 /opt/kiwica/private

COPY ["./openssl.cnf", "/etc/ssl/openssl.cnf"]

COPY ["scripts", "/root"]
