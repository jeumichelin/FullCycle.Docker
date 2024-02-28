FROM alpine:3.19.1 AS builder

WORKDIR /usr/local

RUN wget https://go.dev/dl/go1.22.0.linux-amd64.tar.gz -O go1.22.0.linux-amd64.tar.gz && \
    tar -xzf go1.22.0.linux-amd64.tar.gz && \
    rm -rf go1.22.0.linux-amd64.tar.gz

WORKDIR /usr/src/app

COPY ./src .

FROM alpine:3.19.1

WORKDIR /usr/src/app

COPY --from=builder /usr/local /usr/local
COPY --from=builder /usr/src/app .

ENV PATH="${PATH}:/usr/local/go/bin"

ENTRYPOINT [ "go", "run", "fullcyclerocks.go" ]