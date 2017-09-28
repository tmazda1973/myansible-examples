#!/usr/bin/env bash

DOCUMENT_ROOT="/var/www/ansible-examples"

# ansibleモジュールをインストールする
sudo rpm -ivh http://ftp.riken.jp/Linux/fedora/epel/6/i386/epel-release-6-8.noarch.rpm
sudo yum -y install ansible

# plyabookを実行する
cd ${DOCUMENT_ROOT}/laravel-deploy
ansible-playbook -i hosts playbook-deploy.yml --connection=local -vvv
ansible-playbook -i hosts playbook-migrate.yml --connection=local -vvv