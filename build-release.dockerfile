FROM golang:1.16
ARG SRCDIR=/usr/src/v2ray-plugin
COPY . ${SRCDIR}

WORKDIR ${SRCDIR}
VOLUME $SRCDIR/bin
ENV GOPATH /go
ENV GOPROXY https://proxy.golang.com.cn,direct
CMD ./build-release.sh