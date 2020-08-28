FROM golang:1.15

WORKDIR /go/src/github.com/google/starlark-go

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o starlarkcmd cmd/starlark/starlark.go

FROM alpine:latest
RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=0 /go/src/github.com/google/starlark-go/starlarkcmd /usr/bin/starlark

CMD ["/usr/bin/starlark"]