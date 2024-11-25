FROM golang:1.23-bookworm@sha256:3f3b9daa3de608f3e869cd2ff8baf21555cf0fca9fd34251b8f340f9b7c30ec5 AS builder
ARG LDFLAGS
COPY . /go/src/github.com/sozercan/snapgen
WORKDIR /go/src/github.com/sozercan/snapgen
RUN CGO_ENABLED=0 go build -o /snapgen -ldflags "${LDFLAGS} -extldflags '-static'" ./cmd/frontend

FROM scratch
COPY --from=builder /snapgen /bin/snapgen
ENTRYPOINT ["/bin/snapgen"]
