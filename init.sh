#!/bin/sh

ROOTCA_MOUNT_LOCATION="/opt/ca-crate/rootCA"
source ${ROOTCA_MOUNT_LOCATION}/rootCA_pem_subject

if [ ! -e ${ROOTCA_MOUNT_LOCATION}/rootCA.key ]; then
    openssl genpkey -algorithm RSA                                      \
                    -pkeyopt rsa_keygen_bits:4096                       \
                    -aes256                                             \
                    -out ${ROOTCA_MOUNT_LOCATION}/rootCA.key            \
                    -pass file:${ROOTCA_MOUNT_LOCATION}/rootCA_pkey_password
    chmod 400 ${ROOTCA_MOUNT_LOCATION}/rootCA.key

    openssl req -x509                                                       \
                -new                                                        \
                -sha256                                                     \
                -days 7300                                                  \
                -subj ${ROOTCA_PEM_SUBJECT}                                 \
                -key ${ROOTCA_MOUNT_LOCATION}/rootCA.key                    \
                -passin file:${ROOTCA_MOUNT_LOCATION}/rootCA_pkey_password  \
                -out ${ROOTCA_MOUNT_LOCATION}/rootCA.pem
    chmod 444 ${ROOTCA_MOUNT_LOCATION}/rootCA.pem

else
    echo -e "Private key already exists!\nRootCA certificate generation interrupted!";
    exit 10;
fi

while :; do
    sleep 1
done
