#!/bin/bash

#instalando samba
echo "#instalando samba"
yum -y install samba

#atualizando repositorios
echo "#atualizando repositorios"
yum -y update

#Criando pasta do compartilhamento
echo "#Criando pasta do compartilhamento"
cd /
mkdir samba

#Dando permissão
echo"#Dando permissão"
chmod 777 -R samba

#Criando pasta teste
echo"#Criando pasta teste"
cd /samba
mkdir entrou_no_samba

#criando smb.conf
cd /etc/samba
echo "#criando smb.conf"
echo "[global]
  security = SHARE
[Arquivos]
  path = /samba
  guest ok = yes
  writable = yes" > smb.conf

#Reiniciando samba
echo "#Reiniciando samba"
service smb restart

#Colocando samba para iniciar com o linux
echo "#Colocando samba para iniciar com o linux"
chkconfig smb on

