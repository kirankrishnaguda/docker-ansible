# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.22

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get -y update \
  && apt-get -y install software-properties-common wget rsync \
  && apt-add-repository ppa:ansible/ansible \
  && apt-get -y update \
  && apt-get -y install ansible

ADD ansible/. /ansible
ADD my_init/init-ansible.sh /etc/my_init.d/10-init-ansible.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
