#!/bin/sh


CLIENT_MOUNT_LOCATION="/opt/ca-crate/client";
source ${CLIENT_MOUNT_LOCATION}/client_details;

echo "Generating ${CLIENT_NAME} private key...";
openssl genpkey -algorithm RSA                                      \
                -pkeyopt rsa_keygen_bits:2048                       \
                -aes256                                             \
                -out /opt/ca-crate/private/${CLIENT_NAME}.key.pem   \
                -pass file:${CLIENT_MOUNT_LOCATION}/client_pkey_password;
chmod 400 /opt/ca-crate/private/${CLIENT_NAME}.key.pem

echo "Generating Client CSR...";
openssl req -new                                                        \
            -subj ${CLIENT_CRT_SUBJECT}                                 \
            -key /opt/ca-crate/private/${CLIENT_NAME}.key.pem           \
            -passin file:${CLIENT_MOUNT_LOCATION}/client_pkey_password  \
            -out /opt/ca-crate/CSRs/${CLIENT_NAME}.csr.pem;

echo "Generating Client certificate..."
openssl ca -extensions "${CLIENT_TYPE}_certificate"                   \
           -notext                                                  \
           -batch                                                   \
           -passin file:/opt/ca-crate/rootCA/rootCA_pkey_password   \
           -in /opt/ca-crate/CSRs/${CLIENT_NAME}.csr.pem            \
           -out /opt/ca-crate/certs/${CLIENT_NAME}.crt.pem;
chmod 444 /opt/ca-crate/certs/${CLIENT_NAME}.crt.pem
