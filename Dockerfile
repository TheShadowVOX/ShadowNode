# Stage 1 (Build)
FROM golang:1.23.7-alpine AS builder

ARG VERSION
RUN apk add --update --no-cache git make mailcap
WORKDIR /app/
COPY go.mod go.sum /app/
RUN go mod download
COPY . /app/
RUN CGO_ENABLED=0 go build \
    -ldflags="-s -w -X github.com/TheShadowVOX/shadownode/system.Version=$VERSION" \
    -v \
    -trimpath \
    -o shadownode \
    shadownode.go
RUN echo "ID=\"distroless\"" > /etc/os-release

# Stage 2 (Final)
FROM gcr.io/distroless/static:latest
COPY --from=builder /etc/os-release /etc/os-release
COPY --from=builder /etc/mime.types /etc/mime.types

COPY --from=builder /app/shadownode /usr/bin/

ENTRYPOINT ["/usr/bin/shadownode"]
CMD ["--config", "/etc/shadownode/config.yml"]

EXPOSE 8080 2022
