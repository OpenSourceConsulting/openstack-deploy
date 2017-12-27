#!/bin/bash

echo "Precheck for kolla-ansible"
kolla-ansible prechecks -i /etc/kolla/multinode
