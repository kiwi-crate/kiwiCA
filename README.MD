## Certificate Authority Container
- build the image with `docker build -t <img-name>:<tag> ./`
- run the CA with `docker compose --env-file <env-file-name> up`
    - this is a one-shot run which will generate a CA private key and certificate
        - copy dummy secret files from `secrets/*.staging` to `secrets/*.production` and ajust accordingly


#### This container is intended to be offline at all times except for when issuing new certificates.
