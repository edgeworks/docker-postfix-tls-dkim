FROM debian:jessie

MAINTAINER Andreas Bichsel

# Set noninteractive mode for apt-get because postfix interrupts apt otherwise
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
	postfix \
	sasl2-bin\
	opendkim\
	opendkim-tools\
        --no-install-recommends && rm -r /var/lib/apt/lists/*

RUN postconf -e smtpd_banner="\$myhostname ESMTP"; \
    postconf -e mail_spool_directory="/var/spool/mail/"; \
    postconf -e mailbox_command=""



# Add assets
ADD assets/install.sh /opt/install.sh

# Run
CMD /opt/install.sh;/usr/bin/supervisord -c /etc/supervisord/supervisord.conf

