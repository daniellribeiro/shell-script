#!/bin/bash
ARQUIVO_ERRO=/scripts/log/erro.txt
FTP=/FTP

#limpando log
if [ ! -e $ARQUIVO_ERRO ];then
	echo "#criando pasta log"
	echo "#"
	mkdir log
fi
echo "#limpando log"
 echo "#" 
cd log
echo > erro.txt

#removendo vsftpd antigo
echo "#removendo vsftpd"
echo "#"
yum remove vsftpd -y

#removendo pasta do vsftpd
echo "#removendo pasta vsftpd"
echo "#"
cd /etc
rm -rf vsftpd 2>$ARQUIVO_ERRO

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
cd /etc/vsftpd 2>$ARQUIVO_ERRO
cp vsftpd.conf vsftpd.conf.bkp 2>$ARQUIVO_ERRO

#Editando arquivo vsftpd.conf
echo "#editando arquivo vsftpd"
echo "#"
sed -i 's/anonymous_enable=YES/anonymous_enable=NO/g' vsftpd.conf 2>$ARQUIVO_ERRO 
sed -i 's/#chroot_local_user=YES/chroot_local_user=YES/g' vsftpd.conf 2>$ARQUIVO_ERRO

#Iniciando serviço vsftpd
echo "#iniciando serviço vsftpd"
echo "#"
service vsftpd start 2>$ARQUIVO_ERRO

#Criando usuario
echo "#criando usuario"
echo "#"
useradd tools 2>$ARQUIVO_ERRO

#Colocando vsftpd para iniciar junto com o linux
echo "#colocando vsftpd para iniciar automaticamente"
echo "#"
chkconfig vsftpd on 2>$ARQUIVO_ERRO

#Copiando arquivo passwd
echo "#copiando arquivo passwd original"
echo "#"
cd /etc 2>$ARQUIVO_ERRO
cp passwd passwd.original 2>$ARQUIVO_ERRO

#Criando pasta FTP
echo "#Criando pasta FTP"
echo "#"
rm -rf /FTP 2>$ARQUIVO_ERRO

cd / 2>$ARQUIVO_ERRO
mkdir FTP 2>$ARQUIVO_ERRO
cd /FTP 2>$ARQUIVO_ERRO
mkdir parabens_entrou_na_ftp 2>$ARQUIVO_ERRO

#Habilitando permissões pasta
echo "#Habilitando permissões pasta"
echo "#"
chmod 777 /FTP -R

#Habilitando permissões sistema
echo "#Liberando permissões sistema"
echo "#"
setsebool -P $FTP 0 2>$ARQUIVO_ERRO
getenforce 2>$ARQUIVO_ERRO
setenforce 0 2>$ARQUIVO_ERRO
iptables -F 2>$ARQUIVO_ERRO

#Lembrete
echo
echo "Lembrando:"
echo "Falta inserir a senha do tools"
echo "E configurar o arquivo /etc/passwd"
echo "para tools:x:(numero):(numero)::/FTP:/sbin/nologin"
echo "desabilitar firewall = system-config-firewall-tui"

#Aviso
comando=$(ls -l $ERRO_ARQUIVO | awk {'print $5'})

if [ $comando -gt '1' ];then
	echo "Ocorreram alguns erros verifique arquivo $ERRO_ARQUIVO"
else
	echo "Instalação concluida"
fi

