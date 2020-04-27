ARG VERSION=golang:alpine
FROM ${VERSION}

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN addgroup -g 70 -S gopher && \
    adduser -u 70 -S -D -G gopher -H -h /home/gopher -s /bin/bash gopher && \
    mkdir -p /home/gopher && \
    chown -R gopher:gopher /home/gopher


RUN apk add --no-cache git tmux vim curl bash-completion bash util-linux jq openssh openssl tree nano su-exec

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH


WORKDIR /

COPY [".vimrc", ".profile", ".inputrc", ".gitconfig", "./home/gopher"]
COPY ["motd", "/etc/motd"]
COPY ["nanorc", "/home/gopher/.nanorc"]


# Move to our home
WORKDIR /root

# Setup certs and ssh keys
RUN mkdir -p /var/run/pwd/certs && mkdir -p /var/run/pwd/uploads \
    && ssh-keygen -N "" -t rsa -f  /etc/ssh/ssh_host_rsa_key >/dev/null \
    && mkdir ~/.ssh && ssh-keygen -N "" -t rsa -f ~/.ssh/id_rsa \
    && cat ~/.ssh/id_rsa.pub > ~/.ssh/authorized_keys

WORKDIR /home/gopher

# Remove IPv6 alias for localhost
CMD cat /etc/hosts >/etc/hosts.bak && \
    sed 's/^::1.*//' /etc/hosts.bak > /etc/hosts && \
    while true ; do su-exec gopher script -q -c "/bin/bash -l" /dev/null ; done
