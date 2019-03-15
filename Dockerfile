FROM ubuntu:16.04

RUN apt-get -y update \
  && apt-get -y install software-properties-common wget rsync \
  && apt-add-repository ppa:ansible/ansible \
  && apt-get -y update \
  && apt-get -y install zip unzip python-pexpect python-pip

RUN pip install ansible==2.7
RUN pip install pywinrm
ADD ansible/. /ansible
ADD my_init/init-ansible.sh /init.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD /init.sh
