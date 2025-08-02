FROM quay.io/projectquay/golang

WORKDIR /app
COPY . .

RUN go mod tidy && \
    go build -o app .

FROM busybox:latest
COPY --from=builder /app/app /app/app

ENTRYPOINT ["/app/app"]