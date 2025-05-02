FROM golang:1.22-bookworm@sha256:d996c645c9934e770e64f05fc2bc103755197b43fd999b3aa5419142e1ee6d78 as builder
ARG LDFLAGS
COPY . /go/src/github.com/sozercan/snapgen
WORKDIR /go/src/github.com/sozercan/snapgen
RUN CGO_ENABLED=0 go build -o /snapgen -ldflags "${LDFLAGS} -extldflags '-static'" ./cmd/frontend

FROM scratch
COPY --from=builder /snapgen /bin/snapgen
ENTRYPOINT ["/bin/snapgen"]
