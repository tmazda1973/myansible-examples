FROM ubuntu:14.04

MAINTAINER honda <honda@n-medika.jp>

USER root



#commoninstall
ENV DEBIAN_FRONTEND noninteractive
# TODO: TEST
#RUN apt-get update -y  && \
#    apt-get dist-upgrade -y  && \
#  apt-get -y install vim openssh-server git wget
RUN apt-get -y update
RUN apt-get -y dist-upgrade
RUN apt-get -y install openssh-server
RUN apt-get -y install git
RUN apt-get -y install wget
RUN apt-get -y install vim

#md5pass install
RUN apt-get -y update && \
    apt-get -y install syslinux-common libdigest-md5-file-perl libcrypt-passwdmd5-perl

#install desktop
RUN apt-get -y install language-pack-ja-base language-pack-ja ibus-mozc
RUN update-locale LANG=ja_JP.UTF-8 LANGUAGE="ja_JP:ja"
#RUN apt-get -y install lxde fonts-ipafont-mincho

#setup user
RUN useradd oruser && \
    mkdir /home/oruser && \
    chown -R oruser:oruser /home/oruser && \
    chmod -R 700 /home/oruser && \
    passwd -d oruser && \
    passwd -d root


##ORCA install
WORKDIR /root
RUN wget -q https://ftp.orca.med.or.jp/pub/ubuntu/archive.key  && \
    apt-key add archive.key
RUN wget -q -O /etc/apt/sources.list.d/jma-receipt-trusty48.list https://ftp.orca.med.or.jp/pub/ubuntu/jma-receipt-trusty48.list  && \
    apt-get update && \
    apt-get dist-upgrade -y  && \
    apt-get install -y jma-receipt  && \
    wget https://ftp.orca.med.or.jp/pub/data/receipt/outline/update/claim_update.tar.gz  && \
    tar xvzf claim_update.tar.gz  && \
    bash claim_update.sh
RUN /etc/init.d/postgresql start && \
    jma-setup

# orca first password setup
RUN sed -i 's/read PWD1/PWD1=ormaster/g' /usr/lib/jma-receipt/bin/passwd_store.sh  && \
    sed -i 's/read PWD2/PWD2=ormaster/g' /usr/lib/jma-receipt/bin/passwd_store.sh
RUN service postgresql start && \
    service jma-receipt start && \
    sudo -u orca /usr/lib/jma-receipt/bin/passwd_store.sh

#ssh root login setup
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config  && \
    sed -ri 's/^PermitEmptyPasswords no/PermitEmptyPasswords yes/' /etc/ssh/sshd_config  && \
    sed -ri 's/^UsePAM yes/UsePAM no/' /etc/ssh/sshd_config


#postgresql setup
RUN sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/9.3/main/postgresql.conf
RUN echo host all all 0.0.0.0/0 trust >> /etc/postgresql/9.3/main/pg_hba.conf

#clean up
WORKDIR /root
RUN rm -rf archive.key && \
    rm -rf claim  && \
    rm -rf claim_update.sh && \
    rm -rf claim_update.tar.gz && \
    rm -rf claim_update_.log.gz

#japanise language
ENV LANG ja_JP.UTF-8

##start script
ADD /root/scripts /root/scripts
RUN chmod -R 744 /root/scripts
CMD ["sh", "/root/scripts/start.sh"]

EXPOSE 5432
EXPOSE 22
EXPOSE 8000