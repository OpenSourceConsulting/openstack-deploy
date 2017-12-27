#!/bin/bash

ansible-playbook -i deployment/ceph-ansible/ceph-hosts.txt deployment/ceph-ansible/site.yml
