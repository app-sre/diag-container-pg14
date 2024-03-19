# Locking this to a specific Fedora version for now. New releases of Postgresql, and Fedora versions going out of
# support will drive this upgrade every 6-12 months.
FROM quay.io/fedora/fedora:39

RUN dnf -y --refresh upgrade && \
    dnf -y upgrade --advisory=FEDORA-2024-9044c9eefa && \
    dnf -y install postgresql14 python3-pip python3-PyMySQL python3-psycopg2 git pcp telnet nmap bind-utils net-tools curl traceroute mtr tcpdump community-mysql rsync skopeo redis tmux iputils openssl && \
    dnf clean all 

RUN pip install awscli redis

ADD root /

ENV TERM=vt100

RUN chmod 777 /run.sh && chmod 777 /urldecode.sh

USER 997

ENTRYPOINT ["/run.sh"]