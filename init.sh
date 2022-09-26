#!/bin/sh

ROOTCA_MOUNT_LOCATION="/opt/ca-crate/rootCA"
source ${2}

if [ ! -e ${ROOTCA_MOUNT_LOCATION}/rootCA.key ]; then
    openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -aes256 -out ${ROOTCA_MOUNT_LOCATION}/rootCA.key -pass file:${1}
    openssl req -x509 -new -key ${ROOTCA_MOUNT_LOCATION}/rootCA.key -sha256 -days 365 -out ${ROOTCA_MOUNT_LOCATION}/rootCA.pem -passin file:${1} -subj ${PEM_SUBJ}
else
    echo -e "Private key already exists!\nRootCA certificate generation interrupted!";
    exit 10;
fi
