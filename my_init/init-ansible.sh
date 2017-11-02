#!/bin/bash

# Download Ansible Galaxy roles, if specified
if [ -n "$ANSIBLE_GALAXY_ROLES" ]; then
  # Split ansible galaxy roles into array
  IFS=',' read -r -a array <<< "$ANSIBLE_GALAXY_ROLES";

  # Iterate over each galaxy role and install it
  for element in "${array[@]}"
  do
      ansible-galaxy install $element >>/ansible/galaxy-install.log 2>&1;
  done
fi

# Download remote playbook, if specified
if [ -n "$ANSIBLE_PLAYBOOK_URL" ]; then
  cd /ansible && wget -O site.yml $ANSIBLE_PLAYBOOK_URL;
fi

# Run Ansible playbook
if [ -n "$ANSIBLE_COMMAND" ]; then
  cd /ansible && $ANSIBLE_COMMAND;
else
  cd /ansible && ansible-playbook site.yml;
fi
