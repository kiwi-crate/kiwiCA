#!/bin/sh


CLIENT_MOUNT_LOCATION="/opt/kiwica/client";
source ${CLIENT_MOUNT_LOCATION}/client_details;

echo "Generating ${CLIENT_NAME} private key...";
openssl genpkey -algorithm RSA                                      \
                -pkeyopt rsa_keygen_bits:2048                       \
                -aes256                                             \
                -out /opt/kiwica/private/${CLIENT_NAME}.key.pem   \
                -pass file:${CLIENT_MOUNT_LOCATION}/client_pkey_password;
chmod 400 /opt/kiwica/private/${CLIENT_NAME}.key.pem

echo "Generating Client CSR...";
openssl req -new                                                        \
            -subj ${CLIENT_CRT_SUBJECT}                                 \
            -key /opt/kiwica/private/${CLIENT_NAME}.key.pem           \
            -passin file:${CLIENT_MOUNT_LOCATION}/client_pkey_password  \
            -out /opt/kiwica/CSRs/${CLIENT_NAME}.csr.pem;

echo "Generating Client certificate..."
openssl ca -extensions "${CLIENT_TYPE}_certificate"                   \
           -notext                                                  \
           -batch                                                   \
           -passin file:/opt/kiwica/rootCA/rootCA_pkey_password   \
           -in /opt/kiwica/CSRs/${CLIENT_NAME}.csr.pem            \
           -out /opt/kiwica/certs/${CLIENT_NAME}.crt.pem;
chmod 444 /opt/kiwica/certs/${CLIENT_NAME}.crt.pem
