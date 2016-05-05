FROM centos:latest

MAINTAINER Andreas Bichsel

RUN yum update -y && yum install -y \
	postfix \
	epel-release
RUN yum	install -y opendkim

#RUN postconf -e smtpd_banner="\$myhostname ESMTP"; \
#    postconf -e mail_spool_directory="/var/spool/mail/"; \
#    postconf -e mailbox_command=""

RUN postconf -e smtpd_sasl_auth_enable=yes \
    postconf -e broken_sasl_auth_clients=yes \
    postconf -e smtpd_sasl_type=dovecot\
    postconf -e smtpd_sasl_path=private/auth \
    postconf -e smtpd_sasl_security_options=noanonymous \
    postconf -e smtpd_recipient_restrictions=permit_mynetworks,permit_sasl_authenticated,reject_unauth_destination
    postconf -e message_size_limit = 100000000
    postconf -e mailbox_size_limit = 10000000000
    postconf -e mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain
    postconf -e myhostname=$hostname
    postconf -e mydomain=$maildomain 

# Add assets
#ADD assets/install.sh /opt/install.sh

EXPOSE 25

# Run
#CMD /opt/install.sh;/usr/bin/supervisord -c /etc/supervisord/supervisord.conf
CMD /bin/bash

