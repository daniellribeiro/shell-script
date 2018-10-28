#/bin/bash
function Instalar(){
echo -------------------------------------------
echo              INSTALAR VIRTUAL BOX
echo -------------------------------------------
echo
echo Voce quer:
echo 1-Instalar
echo 2-Desistalar
echo 3-Sair
echo
read resposta;

pasta=/tmp;
if [ $resposta -eq 1 ];then
	echo ----baixando virtual box;
	$(wget https://download.virtualbox.org/virtualbox/5.2.16/VirtualBox-5.2.16-123759-Linux_amd64.run -O $pasta/virtualbox.run);

	echo ----instalando virtual box
	(chmod +x $pasta/virtualbox.run);
	$($pasta/./virtualbox.run);
	
	$(rm -rf $pasta/virtual*);
	
elif [ $resposta -eq 2 ];then
	echo ----desistalando virtual box;
	$(sh /opt/VirtualBox/uninstall.sh);
elif [ $resposta -eq 3 ];then
	exit
else
	echo----OPCAO INVALIDA
	Instalar
fi
}

Instalar
