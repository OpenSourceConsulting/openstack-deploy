#!/bin/bash

OPENSTACK_VIP=$(egrep ^kolla_internal_vip_address /etc/kolla/globals.yml | awk '{print $2}')
OPENSTACK_DB_USER=root
OPENSTACK_DB_PASSWORD=$(grep ^database_password /etc/kolla/passwords.yml | awk '{print $2}')

echo $1

if [ -z $1 ]; then
    echo "Type dump file"
    exit 2
fi

OPENSTACK_DB_DUMP_FILE=$1

mysql --user=${OPENSTACK_DB_USER} \
          --password=${OPENSTACK_DB_PASSWORD} \
          --host=${OPENSTACK_VIP} < ${OPENSTACK_DB_DUMP_FILE}
