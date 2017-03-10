#!/bin/bash
# ansible-galaxy install jdauphant.nginx &> galaxy-install.log
cd /ansible && ansible-playbook nginx.yml
