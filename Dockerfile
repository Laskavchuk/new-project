FROM --platform=$BUILDPLATFORM quay.io/projectquay/golang:alpine AS build

ARG TARGETPLATFORM
ARG BUILDPLATFORM

WORKDIR /src

COPY . .

RUN echo "Building on $BUILDPLATFORM for $TARGETPLATFORM" \
  && GOOS=$(echo $TARGETPLATFORM | cut -d'/' -f1) \
  && GOARCH=$(echo $TARGETPLATFORM | cut -d'/' -f2) \
  && go build -o /out/app -v ./...

FROM alpine

COPY --from=build /out/app /app

ENTRYPOINT ["/app"]