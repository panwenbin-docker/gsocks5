FROM golang:1.14 as builder

ARG GOPROXY
ENV GORPOXY ${GOPROXY}

WORKDIR /builder

RUN git clone https://github.com/panwenbin/gsocks5.git /builder \
  && cd bin && go build server.go

FROM alpine:latest

RUN mkdir /lib64 \
  && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2

COPY --from=builder /builder/bin/server /app/gsocks5

WORKDIR /app

CMD ["./gsocks5"]

EXPOSE 1080
