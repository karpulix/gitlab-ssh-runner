FROM alpine:3.11
RUN apk add --no-cache \
    openssh-client \
    ca-certificates

COPY ssh_init /usr/bin/ssh_init
COPY ssh_run /usr/bin/ssh_run
RUN mkdir -p /root/.ssh && \
    touch /root/.ssh/config && \
    chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/config && \
    chmod +x /usr/bin/ssh_init && \
    chmod +x /usr/bin/ssh_run
    