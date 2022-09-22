#!/bin/sh

PRIVKEY_LOCATION="/opt/cabox/private/rootCA.key"
source ${2}

if [ ! -e ${PRIVKEY_LOCATION} ]; then
    openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -aes256 -out ${PRIVKEY_LOCATION} -pass file:${1}
    openssl req -x509 -new -key ${PRIVKEY_LOCATION} -sha256 -days 365 -out /opt/cabox/certs/rootCA.pem -passin file:${1} -subj ${PEM_SUBJ}
fi
