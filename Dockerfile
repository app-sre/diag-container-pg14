# Locking this to a specific Fedora version for now. New releases of Postgresql, and Fedora versions going out of
# support will drive this upgrade every 6-12 months.
FROM quay.io/fedora/fedora:38

RUN dnf -y --refresh upgrade && \
    dnf -y upgrade --security && \
    dnf -y install https://download.postgresql.org/pub/repos/yum/reporpms/F-38-x86_64/pgdg-fedora-repo-latest.noarch.rpm && \
    dnf -y install postgresql14 python3-pip python3-PyMySQL python3-psycopg2 git pcp telnet nmap bind-utils net-tools curl traceroute mtr tcpdump community-mysql rsync skopeo redis tmux iputils && \
    dnf clean all 

RUN pip install awscli redis

ADD root /

ENV TERM=vt100

RUN chmod 777 /run.sh && chmod 777 /urldecode.sh

USER 997

ENTRYPOINT ["/run.sh"]