FROM alpine:3.6

# Install kubectl
ENV HOME=/config \
  VERSION=v1.8.5

ADD https://storage.googleapis.com/kubernetes-release/release/${VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl

RUN set -xe; \
    apk add --no-cache curl ca-certificates; \
    chmod +x /usr/local/bin/kubectl; \
    \
    # Create non-root user (with a randomly chosen UID/GUI).
    adduser kubectl -Du 2342 -h /config; \
    \
    # Basic check it works.
    kubectl version --client;

USER kubectl

ENTRYPOINT ["/usr/local/bin/kubectl"]
