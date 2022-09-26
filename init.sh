#!/bin/sh

ROOTCA_MOUNT_LOCATION="/opt/ca-crate/rootCA"
source ${ROOTCA_MOUNT_LOCATION}/rootCA_pem_subject

if [ ! -e ${ROOTCA_MOUNT_LOCATION}/rootCA.key ]; then
    openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -aes256 -out ${ROOTCA_MOUNT_LOCATION}/rootCA.key -pass file:${ROOTCA_MOUNT_LOCATION}/rootCA_pkey_password
    openssl req -x509 -new -key ${ROOTCA_MOUNT_LOCATION}/rootCA.key -sha256 -days 365 -out ${ROOTCA_MOUNT_LOCATION}/rootCA.pem -passin file:${ROOTCA_MOUNT_LOCATION}/rootCA_pkey_password -subj ${ROOTCA_PEM_SUBJECT}
else
    echo -e "Private key already exists!\nRootCA certificate generation interrupted!";
    exit 10;
fi
