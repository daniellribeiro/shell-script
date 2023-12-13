#!/bin/bash

#variaveis
FTP=/FTP
ARQ_CONF=/etc/proftpd/proftpd.conf
OK=$(echo -e OK);

#usuario root
echo "Para rodar este script precisa estar logado como root"
echo "Voce esta logado como root ? 1-Sim 2-Nao"
read resposta

if [ $resposta -ne 1 ];then
	exit
fi

#instalando proftpd
echo "Aguarde"
apt-get install vim -y > /dev/null 2>/dev/null
echo "vim instalado $OK"

apt-get install proftpd -y > /dev/null 2>/dev/null
echo "Proftpd instalado $OK"

#copiando arquivo original
cp $ARQ_CONF $ARQ_CONF.bkp
echo "Arquivo Original Salvo $OK"

#configurando arquivo proftpd
sed -i 's/# DefaultRoot/DefaultRoot/g' $ARQ_CONF
echo "Copie e cole no terminal o seguinte comando"
echo -e "sudo vim $ARQ_CONF"
echo -e "Mude a linha DefaultRoot ~ para $vermelho DefaultRoot $FTP $padrao"
echo "Depois disso venha no script e aperte ENTER"
read
echo "Arquivo vsftpd configurado $OK"

#iniciando serviço vsftpd
service proftpd restart
echo "Reiniciado com sucesso $OK"

#Editando arquivo /etc/shells
echo >> /etc/shells
echo  "/bin/false" >> /etc/shells
echo "Arquivo /etc/shells editado $OK"

#Criando ftpgroup
groupadd ftpgroup
echo "Grupo ftpgroup criado $OK"

#Criando USUARIOFTP
echo "Criando usuario que acessara ftp"
echo -e "Qual o nome do usuario ?"
read usuario
useradd $usuario -s /bin/false -d $FTP -G ftpgroup
echo "Usuario $usuario criado com sucesso $OK"

#Criando pasta FTP
mkdir $FTP
mkdir $FTP/parabens_entrou_na_ftp
echo "pasta FTP criada com sucesso $OK"

#Senha no USUARIOFTP
echo
echo
echo "Digite a senha do usuario $usuario"
passwd $usuario

#site que me ajudou a criar script
#https://sempreupdate.com.br/como-criar-um-servidor-ftp-no-linux/
