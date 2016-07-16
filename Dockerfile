FROM centos:latest

MAINTAINER Andreas Bichsel

#VARS to set: hostname, maildomain


RUN yum update -y && yum install -y \
	postfix \
	epel-release
RUN yum	install -y opendkim

#RUN postconf "smtpd_banner='\$myhostname ESMTP'; \"
#    postconf "mail_spool_directory='/var/spool/mail'; \"
#    postconf "mailbox_command="""
"
RUN postconf "smtpd_sasl_auth_enable = yes" \
    	 "broken_sasl_auth_clients = yes" \
    	 "smtpd_sasl_type = dovecot"\
    	 "smtpd_sasl_path = private/auth "\
    	 "smtpd_sasl_security_options = noanonymous "\
    	 "smtpd_recipient_restrictions = permit_mynetworks,permit_sasl_authenticated,reject_unauth_destination"\
    	 "message_size_limit = 100000000"\
    	 "mailbox_size_limit = 10000000000"\
    	 "myhostname = $hostname"\
    	 "mydomain = $maildomain "\
    	 "mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain"


# Add assets
#ADD assets/install.sh /opt/install.sh
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 25

# Run
#CMD /opt/install.sh;/usr/bin/supervisord -c /etc/supervisord/supervisord.conf
CMD /bin/bash

