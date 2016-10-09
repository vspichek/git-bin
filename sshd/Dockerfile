## Standard phusion part
FROM armhf/phusion/baseimage:0.9.18

## Expose ports.
EXPOSE 22

## Application specific part
MAINTAINER Vlad Spichek <vspichek@unixtastic.com>

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh -f && rm -f /etc/service/sshd/down  # Uncomment to Enable SSHD
#RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh           # Uncomment to Disable SSHD

RUN apt-get -qq update && apt-get -qq upgrade && \
    apt-get -qq install git-sh git sharutils && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

## Setup service
# Setup a git user and SSH
#Set a long random password to unlock the git user account
RUN groupadd -g 1000 git && useradd -g git -u 1000 -d /git -m -r -s /usr/bin/git-shell git && \
    sed -i -e 's/.*LogLevel.*/LogLevel VERBOSE/' -e 's/#*PermitRootLogin.*/PermitRootLogin no/' \
           -e 's/#UsePAM.*/UsePAM no/' /etc/ssh/sshd_config && \
   usermod -p `dd if=/dev/urandom bs=1 count=30 | uuencode -m - | head -2 | tail -1` git

## Remove /etc/motd
## Clean up
RUN rm -rf /etc/update-motd.d /etc/motd /etc/motd.dynamic && \
    ln -fs /dev/null /run/motd.dynamic && \
    rm -rf /tmp/* /var/tmp/*

CMD ["/sbin/my_init"]
