FROM alpine:3.8

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.7.0/s6-overlay-amd64.tar.gz /tmp/

RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
    && apk add  --no-cache --purge cgit git \
      openssh-server curl nginx fcgiwrap ca-certificates \
      py-pygments \
    && adduser \
      -u 10000 \
      -h /home/git \
      --disabled-password \
      -D \
      -s /usr/bin/git-shell \
      git \
    && passwd -u git \
    && ssh-keygen -A \
    && mkdir /run/nginx \
    && rm -rf /var/cache/apk/* /tmp/*

COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY sshd/sshd_config /etc/ssh/sshd_config
COPY cgit/cgitrc /etc/cgitrc

COPY nginx/run /etc/services.d/nginx/run
COPY sshd/run /etc/services.d/sshd/run
COPY fcgiwrap/run /etc/services.d/fcgiwrap/run

EXPOSE 443 80 22

CMD ["/init"]
