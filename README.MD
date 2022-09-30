## Certificate Authority Container
> **Note**:<br/>
> This is intended to be offline at all times except for when issuing new certificates.
- build the image with `docker build -t <img-name>:<tag> ./`


This compose project has two functions:
1) Generate a rootCA pair (private key + certificate):
    - run with `ROOTCA_BIND="/bind/path" docker compose -f compose-rootCA.yaml up`
        - this is a one-shot run which will generate a CA private key and certificate
        - `ROOTCA_BIND` path must contain the two files found in `dummy/rootCA` (don't forget to adjust their contents accordingly)
            - point variable `ROOTCA_BIND` to a secure path where to write the rootCA private key and certificate (preferably a USB stick that will be unmounted and stored somewhere when not using the CA)

2) Generate ssl certificate for a client (user/server):
    - run with `ROOTCA_BIND="/rootCA/bind/path" CLIENT_BIND="/client/bind/location" docker compose -f compose-client.yaml up`
        - this is a one-shot run which will generate a client private key, csr and certificate which will be signed with previously generated rootCA
        - `ROOTCA_BIND` see point 1
`       - `CLIENT_BIND` path must contain the two files found in `dummy/client` (don't forget to adjust their contents accordingly)
            - for security use this variable the same way as `ROOTCA_BIND`

#### Exit Codes:
- 10: A private key file called rootCA.key is already present in the `ROOTCA_BIND` path. RootCA Key+Cert generation interrupted.
