#!/bin/bash

OPENSTACK_VIP=$(egrep ^kolla_internal_vip_address /etc/kolla/globals.yml | awk '{print $2}')
OPENSTACK_DB_USER=root
OPENSTACK_DB_PASSWORD=$(grep ^database_password /etc/kolla/passwords.yml | awk '{print $2}')

DB_BACKUP_PATH=/home/openstack_db_backup
DUMP_FILE=openstack_db_backup.$(date +%Y_%m_%d).sql

if [ ! -d ${DB_BACKUP_PATH} ]; then
    mkdir ${DB_BACKUP_PATH}
fi

mysqldump --user=${OPENSTACK_DB_USER} \
          --password=${OPENSTACK_DB_PASSWORD} \
          --host=${OPENSTACK_VIP} \
          --all-databases > ${DB_BACKUP_PATH}/${DUMP_FILE}
