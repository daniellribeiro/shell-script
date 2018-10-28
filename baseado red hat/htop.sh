#!/bin/bash

#removendo o htop
yum remove htop -y

#baixar programa do site
wget http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

#instalar programa
rpm -ihv epel-release-6-8.noarch.rpm

#removendo arquivo rpm
rm epel-release-6-8.noarch.rpm

#atualizando repositorios
yum update

#instalando htop
yum install htop -y
