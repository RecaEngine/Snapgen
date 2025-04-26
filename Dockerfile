FROM golang:1.21-bullseye@sha256:adf7ccb07fe8ccadf7bb0317f02d2c3a4916f824a23f6975fd36c4bd7feece3f as builder
COPY . /go/src/github.com/sozercan/snapgen
WORKDIR /go/src/github.com/sozercan/snapgen
RUN CGO_ENABLED=0 go build -o /snapgen --ldflags '-extldflags "-static"' ./cmd/frontend

FROM scratch
COPY --from=builder /snapgen /bin/snapgen
ENTRYPOINT ["/bin/snapgen"]
