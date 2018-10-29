#!/bin/bash

#cores
padrao="\033[0m"
verde="\033[0;32m"

#variaveis
FTP=/FTP
ARQ_CONF=/etc/vsftpd.conf
ARQ_PASSWD=/etc/passwd
OK=$(echo -e [$verde OK $padrao]);

#removendo vsftpd antigo 
echo Removendo vsftpd
apt-get remove vsftpd -y > /dev/null
#valida($?);
echo "Vsftpd removido $OK"

#instalando vsftpd
echo Instalando vsftpd
apt-get install vsftpd -y > /dev/null
#valida($?);
echo "Vsftpd instalado $OK"

#copiando arquivo original
echo Salvando Arquivo de Configuracao Original
cp $ARQ_CONF $ARQ_CONF.bkp
#valida($?);
echo "Arquivo Original Salvo $OK"

#configurando arquivo vsftpd
echo "Configurando Arquivo vsftpd"
sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g' vsftpd.conf
sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/g' vsftpd.conf
echo "Arquivo vsftpd configurado $OK"

#iniciando serviço vsftpd
echo "Iniciando Serviço vsftpd"
service vsftpd start
#valida($?);
echo "Serviço vsftpd Iniciado $OK"

#Criando usuario tools
echo "Criando usuario tools"
useradd tools
#valida($?);
echo "Usuario tools criado com sucesso $OK"

#Copiando arquivo passwd original
echo "Salvando arquivo passwd original"
cp $ARQ_PASSWD $ARQ_PASSWD.bkp
echo "Arquivo original salvo com sucesso $OK"

#Criando pasta FTP
echo "Criando pasta FTP"
rm -rf $FTP
mkdir $FTP
mkdir $FTP/parabens_entrou_na_ftp
echo "pasta FTP criada com sucesso $OK"

#Habilitando permissões na pasta FTP
echo "Habilitando permissão na pasta FTP"
chmod 777 /FTP -R
echo "Permissão habilitada $OK"

#apt install policycoreutils

