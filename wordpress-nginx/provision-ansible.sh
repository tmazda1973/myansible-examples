#!/usr/bin/env bash

DOCUMENT_ROOT="/var/www/ansible-examples"

sudo rpm -ivh http://ftp.riken.jp/Linux/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
sudo yum -y install ansible
cd ${DOCUMENT_ROOT}/wordpress-nginx
ansible-playbook site.yml --connection=local -vv
