#!/bin/bash

if [[ "x${1}" != x"--yes-i-really-really-mean-it" ]]; then
  echo -e "WARNING: kolla cluster will be destroyed"
  echo -e "    There is no way to recover from this action. To confirm, please add the following option:"
  echo -e "    --yes-i-really-really-mean-it"
  exit 2
else

echo "WARNING: being destroyed"
kolla-ansible destroy -i /etc/kolla/multinode --yes-i-really-really-mean-it
fi
