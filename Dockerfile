FROM nginx:1.12-alpine

ENV VERSION=1.0.4

RUN apk update && \
    apk add inotify-tools rsync && \
    rm -rf /var/cache/apk/*

ADD https://github.com/hbouvier/watchgod/releases/download/v${VERSION}/watchgod.v${VERSION}.zip /tmp/

RUN cd /tmp && \
    unzip watchgod.v${VERSION}.zip && \
    mv bin/linux_amd64/watchgod /bin/ && \
    rm -rf bin watchgod.v${VERSION}.zip && \
    echo '{"Processes":[{"Name" : "nginx","Command" : ["/usr/sbin/nginx", "-g", "daemon off;"]}]}' > /etc/watchgod.json

ADD etc /etc

ENTRYPOINT ["/bin/watchgod"]
CMD ["-config", "/etc/watchgod.json", "boot"]
