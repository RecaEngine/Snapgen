FROM golang:1.21-bullseye@sha256:6ac4c35eed9933eb7ae528e9549182bcf421c7f0e39b7337411a54c2f6a8b680 as builder
COPY . /go/src/github.com/sozercan/snapgen
WORKDIR /go/src/github.com/sozercan/snapgen
RUN CGO_ENABLED=0 go build -o /snapgen --ldflags '-extldflags "-static"' ./cmd/frontend

FROM scratch
COPY --from=builder /snapgen /bin/snapgen
ENTRYPOINT ["/bin/snapgen"]
