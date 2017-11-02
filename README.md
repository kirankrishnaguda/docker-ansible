# docker-ansible
This repository is the source for a disposable Docker based Ansible control node.

This docker container has the ability to pull in a playbook specification from a remote URL and automatically run that playbook on container startup. It also has the ability to automatically install Ansible roles from Ansible Galaxy.

You also have the option of mounting your own Ansible Playbooks, Roles and Inventory to take action against remote hosts. This container can accept a custom Ansible or Ansible Playbook command.

Lastly, you can also provide a custom `ansible.cfg` file by including it in your Ansible directory that you mount to the container. This container comes with a pre-installed `ansible.conf` that has sensible defaults.

## Contributing
Please see [Contributing](CONTRIBUTING.md) for instructions on contributing to this repository.

## Configuring Ansible Playbooks

### Example docker-compose.yml
```
version: '2'
services:
    nginx-ansible:
        build: .
        environment:
            ANSIBLE_PLAYBOOK_URL: https://gitlab.dynamictivity.com/dynamictivity/docker-ansible/snippets/2/raw
            ANSIBLE_GALAXY_ROLES: "carlosbuenosvinos.ansistrano-deploy,jdauphant.nginx,ANXS.postgresql,dev-sec.os-hardening"
            ANSIBLE_COMMAND: "ansible-playbook site.yml"
```

# TODO
- Ability to load remote Ansible inventory files
- Ability to load remote Ansible configuration

# Support
support@dynamictivity.com

License
-------
MIT

Author Information
------------------
Travis Rowland
