FROM golang:1.21-bullseye@sha256:03c61acbdafde9d60dc4f94a75bc558ab329d9455b5f6c799182d8783798e92f as builder
COPY . /go/src/github.com/sozercan/snapgen
WORKDIR /go/src/github.com/sozercan/snapgen
RUN CGO_ENABLED=0 go build -o /snapgen --ldflags '-extldflags "-static"' ./cmd/frontend

FROM scratch
COPY --from=builder /snapgen /bin/snapgen
ENTRYPOINT ["/bin/snapgen"]
