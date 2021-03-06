FROM golang:latest as builder

ARG GOPROXY
ENV GORPOXY ${GOPROXY}

WORKDIR /builder

RUN git clone https://github.com/panwenbin/gsocks5.git /builder \
  && cd bin && go build server.go

FROM panwenbin/alpinetz:latest

COPY --from=builder /builder/bin/server /app/gsocks5

WORKDIR /app

CMD ["./gsocks5"]

EXPOSE 1080
