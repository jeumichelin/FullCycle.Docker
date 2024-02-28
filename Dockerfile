FROM golang:alpine3.19 AS builder

WORKDIR /usr/src/app

COPY ./src .

RUN go build -ldflags "-s -w" fullcyclerocks.go && \
    apk upgrade  && \
    apk add upx && \
    upx --brute fullcyclerocks

FROM busybox:1.29-uclibc AS runner

WORKDIR /usr/src/app

COPY --from=builder /usr/src/app/fullcyclerocks .

CMD ["./fullcyclerocks"]