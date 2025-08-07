FROM quay.io/projectquay/golang:1.24 AS builder

ARG TARGETOS
ARG TARGETARCH

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -o /app/main .

FROM builder AS test
RUN go test -v ./...

FROM scratch

COPY --from=builder /app/main /main

ENTRYPOINT ["/main"]
