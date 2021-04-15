FROM golang:1.14
WORKDIR /src
COPY . /src
RUN go build -o /bin/s3www -ldflags="-extldflags=-static"                                                                                            

FROM debian:buster
EXPOSE 8080

# Copy CA certificates to prevent x509: certificate signed by unknown authority errors
COPY --from=0 /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt

COPY --from=0 /bin/s3www /s3www

ENTRYPOINT ["/s3www"]
