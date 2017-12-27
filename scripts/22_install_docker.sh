#!/bin/bash

echo "Docker install to kolla target nodes"
ansible-playbook playbooks/21_docker_installation.yml
