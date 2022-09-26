## Certificate Authority Container
> This is intended to be offline at all times except for when issuing new certificates.
- build the image with `docker build -t <img-name>:<tag> ./`
- run the CA with `ROOTCA_BIND_MOUNT="/bind/location" docker compose --env-file <env-file-name> up`
    - this is a one-shot run which will generate a CA private key and certificate
    - point variable `ROOTCA_BIND_MOUNT` to a secure location where to write the rootCA private key and certificate (preferably a USB stick that will be unmounted and stored somewhere when not using the CA)
        - for production deployments copy *password* and *pem_subject* files from `dummy/` to the `ROOTCA_BIND_MOUNT` location and adjust accordingly


#### Exit Codes:
- 10: A private key file called rootCA.key is already present in the `ROOTCA_BIND_MOUNT` location. RootCA Key+Cert generation interrupted.
