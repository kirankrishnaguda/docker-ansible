# docker-ansible
This repository is the source for a disposable Docker based Ansible control node.

This docker container has the ability to pull in a playbook specification from a remote URL and automatically run that playbook on container startup. It also has the ability to automatically install Ansible roles from Ansible Galaxy.

You also have the option of mounting your own Ansible Playbooks, Roles and Inventory to take action against remote hosts. This container can accept a custom Ansible or Ansible Playbook command.

Lastly, you can also provide a custom `ansible.cfg` file by including it in your Ansible directory that you mount to the container. This container comes with a pre-installed `ansible.conf` that has sensible defaults.

## Docker Hub
This image is also available on Docker Hub: https://hub.docker.com/r/dynamictivity/docker-ansible/

## Contributing
Please see [Contributing](CONTRIBUTING.md) for instructions on contributing to this repository.

## Run Ansible Directly
You have the option of running Ansible in this image directly either using `docker-compose run` or `docker-run`.

### Docker Compose
```
docker-compose run --rm docker-ansible ansible all -m ping
```

### Docker Run
```
docker run --rm dynamictivity/docker-ansible all -m ping
```

## Running Ansible (Playbooks) with Docker Compose

### Docker Volumes
 - Mount your inventory to `/inventory`
 - Mount your Ansible to `/ansible`

### Example docker-compose.yml
#### Ansible Command
```
version: '2'
services:
    docker-ansible:
        image: dynamictivity/docker-ansible
        environment:
            ANSIBLE_COMMAND: "ansible all -m setup"
```

#### Remote Playbook and Galaxy Roles
```
version: '2'
services:
    docker-ansible:
        image: dynamictivity/docker-ansible
        environment:
            ANSIBLE_PLAYBOOK_URL: https://gitlab.dynamictivity.com/dynamictivity/docker-ansible/snippets/2/raw
            ANSIBLE_GALAXY_ROLES: "carlosbuenosvinos.ansistrano-deploy,jdauphant.nginx,ANXS.postgresql,dev-sec.os-hardening"
            ANSIBLE_COMMAND: "ansible-playbook site.yml"
        volumes:
            - /local/path/to/ansible_inventory:/inventory
```

#### Local Playbooks, Ansible Config and Inventory
```
version: '2'
services:
    docker-ansible:
        image: dynamictivity/docker-ansible
        environment:
            ANSIBLE_PLAYBOOK_ARGS: site.yml -vvvv
            ANSIBLE_EXTRA_VARS: "foo=bar bar=foo"
            ANSIBLE_EXTRA_EXTRA_VARS: "@params.json"
        volumes:
            - /local/path/to/ansible_playbooks:/ansible
            - /local/path/to/ansible_inventory:/inventory
```

## Retrieving Exit Codes
If you would like to retrieve exit codes from this container (useful for CI/CD), simply execute the container like so: `docker-compose run --rm docker-ansible; echo $?`

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
