#!/bin/bash
# set -x
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

# Run Ansible command
if [ -n "$ANSIBLE_COMMAND" ]; then
  cd /ansible && $ANSIBLE_COMMAND;
fi

# Run Ansible playbook
if [ -n "$ANSIBLE_PLAYBOOK_ARGS" ]; then
  # ANSIBLE_PLAYBOOK_ARGS='site.yml -e "foo=bar" -vvvv'
  array=($ANSIBLE_PLAYBOOK_ARGS)
  # echo "${array[@]}";
  cd /ansible && ansible-playbook "${array[@]}";
fi

if [ -n "$ANSIBLE_EXTRA_VARS" ] || [ -n "$ANSIBLE_EXTRA_EXTRA_VARS" ]; then
  cd /ansible && ansible-playbook site.yml -e "$ANSIBLE_EXTRA_VARS" --extra-vars "$ANSIBLE_EXTRA_EXTRA_VARS";
fi

# Kill Container
## TODO: Find graceful way to do this: https://github.com/phusion/baseimage-docker/issues/451
kill 1
