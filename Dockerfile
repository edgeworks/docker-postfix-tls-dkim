FROM debian:jessie

# Set noninteractive mode for apt-get because postfix interrupts apt otherwise
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
                postfix \
                dovecot-imapd \
        --no-install-recommends && rm -r /var/lib/apt/lists/*
