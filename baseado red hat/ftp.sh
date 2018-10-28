#!/bin/bash
FTP=/FTP

#removendo vsftpd antigo
echo "#removendo vsftpd"
echo "#"
yum remove vsftpd -y

#removendo pasta do vsftpd
echo "#removendo pasta vsftpd"
echo "#"
cd /etc
rm -rf vsftpd

#atualizando repositorio
echo "#atualizando repositorios"
echo "#"
yum update -y

#instalando vsftpd
echo "#instalando vsftpd"
echo "#"
yum install vsftpd -y

#copiando arquivo original
echo "#copiando arquivo vsftpd.conf original"
echo "#"
cd /etc/vsftpd
cp vsftpd.conf vsftpd.conf.bkp

#Editando arquivo vsftpd.conf
echo "#editando arquivo vsftpd"
echo "#"
sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g' vsftpd.conf
sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/g' vsftpd.conf

#Iniciando serviço vsftpd
echo "#iniciando serviço vsftpd"
echo "#"
service vsftpd start

#Criando usuario
echo "#criando usuario"
echo "#"
useradd tools

#Colocando vsftpd para iniciar junto com o linux
echo "#colocando vsftpd para iniciar automaticamente"
echo "#"
chkconfig vsftpd on

#Copiando arquivo passwd
echo "#copiando arquivo passwd original"
echo "#"
cd /etc
cp passwd passwd.original

#Criando pasta FTP
echo "#Criando pasta FTP"
echo "#"
rm -rf /FTP

cd /
mkdir FTP
cd /FTP
mkdir parabens_entrou_na_ftp

#Habilitando permissões pasta
echo "#Habilitando permissões pasta"
echo "#"
chmod 777 /FTP -R

#Habilitando permissões sistema
echo "#Liberando permissões sistema"
echo "#"
setsebool -P $FTP 0
getenforce
setenforce 0
iptables -F

#Lembrete
echo
echo "Lembrando:"
echo "Falta inserir a senha do tools"
echo "E configurar o arquivo /etc/passwd"
echo "para tools:x:(numero):(numero)::/FTP:/sbin/nologin"
echo "desabilitar firewall = system-config-firewall-tui"

