FROM alpine:3.20 as builder

RUN \
    apk add --no-cache \
        bash \
        chezmoi \
        curl \
        git \
        zsh && \
    adduser -D -u 1000 --home /out user && \
    mkdir -p /inn /out && \
    chown -R user:user /inn /out

COPY . /inn
COPY .ci/chezmoi.yml /tmp/chezmoi.yml

USER 1000

RUN chezmoi \
    apply \
    --config \
        /tmp/chezmoi.yml \
    --verbose

FROM scratch
COPY --from=builder /out /out
