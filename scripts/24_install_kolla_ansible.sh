#!/bin/bash

echo "copy ceph config files to local"
ansible-playbook playbooks/22_ceph_conf_copy.yml

echo "kolla-ansible deploy"
kolla-ansible deploy -i /etc/kolla/multinode

echo "Generate the admin-openrc.sh file"
kolla-ansible post-deploy -i /etc/kolla/multinode

ansible-playbook playbooks/24_extra_config_for_kolla.yml
