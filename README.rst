========================
Team and repository tags
========================

.. image:: http://osci.kr/images/main/header_logo_c.png
    :target: https://github.com/OpenSourceConsulting/openstack-deploy

.. Change things from this point on

=========================
openstack-deploy Overview
=========================

The openstack-deploy is a tools that makes deployment of openstack and ceph easier.

openstack-deploy include "cobbler, kolla-ansible and ceph-ansible"

::

    provision : cobbler
    ceph      : ceph-ansible
    openstack : kolla-ansible


1. Deploy server
================
Create deploy-server.
deploy-server is named "cloud-deploy" which is localhost.

Run default settings for deploy server
--------------------------------------
::

    # sh 00_setting_default_for_deploy-server.sh
    # sh 01_run_default_settings_for_deploy_server.sh

- Settings like disable selinux and firewall etc
- Install python packages and ansible


Create local repository for rpm packages
----------------------------------------
::

    # sh 02_create_local_repo.sh

- Download rpm packages; centos base, updates, extras and docker, ceph, openstack etc


Download ceph-ansible and koll-ansible, then download kolla-images
------------------------------------------------------------------
::

    # sh 04_install_deploy_server.sh

- Download ceph-ansible and kolla-ansible from github and modify
- Download kolla-images already built from our private registry


2. Install ceph and kolla(openstack)
====================================

Deploy ceph
-----------
::

    # sh 11_run_default_settings_for_ceph.sh
    # sh 12_install_ceph_ansible.sh


Deploy kolla(openstack)
-----------------------
::

    # 21_run_default_settings_for_kolla.sh
    # 22_install_docker.sh
    # 23_precheck_kolla_ansible.sh
    # 24_install_kolla_ansible.sh

- Default settings for target servers
- Install docker service
- Check whether is ok to install kolla to target nodes
- Install kolla(openstack) useing kolla-ansible


3. Upgrade
==========

Upgrade ceph
------------
Firstly, you have to update your rpm repository for ceph packages.

::

    # ansible-playbook -i ceph-hosts.txt infrastructure-playbooks/rolling_update.yml


Upgrade kolla(openstack)
------------------------

Change version 
::

    # vi inventory/group_vars/all.yml
    -kolla_ansible_git_version: 4.0.2
    +kolla_ansible_git_version: 4.0.3


Run to download new kolla-images
::

    # ansible-playbook playbooks/41_download_new_kolla_images.yml


Run to upgrade to new images
::

    # kolla-ansible upgrade -i /etc/kolla/multinode

