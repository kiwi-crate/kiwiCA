## Certificate Authority Container
- build the image with `docker build -t <img-name>:<tag> ./`
- run the container with `docker container run -it -v /location/for/storing/CA/data:/opt/cabox <img-name>:<tag>`
- within the container execute init.sh `/bin/sh /root/init.sh /location/to/private/key/password /location/to/certificate/subject/file`
    - the certificate subject file is expected to have the following variable `PEM_SUBJ="/C=Country/ST=State/etc..."`


#### This container is intended to be offline at all times except for when issuing new certificates.
