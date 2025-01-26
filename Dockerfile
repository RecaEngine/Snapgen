FROM golang:1.21-bullseye@sha256:ca78a56712ab89487123b3af2b30052824653730e7ff25271d2f3037153bc0df as builder
COPY . /go/src/github.com/sozercan/snapgen
WORKDIR /go/src/github.com/sozercan/snapgen
RUN CGO_ENABLED=0 go build -o /snapgen --ldflags '-extldflags "-static"' ./cmd/frontend

FROM scratch
COPY --from=builder /snapgen /bin/snapgen
ENTRYPOINT ["/bin/snapgen"]
