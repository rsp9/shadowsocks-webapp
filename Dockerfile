# build
FROM golang:1.15 AS builder
ARG SRCDIR=/usr/src/v2ray-plugin
ARG GOPATH=/go
ARG GOPROXY
COPY . ${SRCDIR}
WORKDIR ${SRCDIR}
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go install -v -a -installsuffix cgo

# package
FROM shadowsocks/shadowsocks-libev
LABEL maintainer="flikas<contact@flikas.name>"
COPY --from=builder /go/bin/* /usr/bin/
EXPOSE ${SERVER_PORT}

# command
USER nobody
CMD ["/bin/sh", "-c", "exec ss-server -s $SERVER_ADDR -p $SERVER_PORT -k ${PASSWORD:-$(hostname)} -m $METHOD -t $TIMEOUT -d $DNS_ADDRS -u $ARGS --plugin v2ray-plugin --plugin-opts \"server\""]