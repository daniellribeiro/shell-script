#!/bin/bash

#variaveis

padrao="\033[0m"
verde="\033[0;32m"
piscando="\033[0;05m"
azul="\033[0;34m"
vermelho="\033[0;41m"

ok=$(echo -e "$verde [OK] $padrao")
workspace="/home/$USER"
arq_nome_email="/tmp/nome_email"
arq_repositorios="/tmp/repositorios"
arq_nome_link="/tmp/nome_link"
arq_configuracao="configuracao.tar.xz"
#funções

adicionar_repositorio() {
	#criando pasta repositorio
	if [ -e "$repositorio" ];then
		echo "PASTA DO REPOSITORIO JÁ EXISTE!!!"
	else
		echo "criando pasta repositorio $repositorio $ok"
		mkdir $repositorio

		#iniciando git
		cd $repositorio
		echo iniciando git $ok
		git init
		
		#adicionando repositorio
		repositorio="git@github.com:$nome_link/$repositorio.git";
		echo "adicionando repositorio $repositorio $ok"
		$(git remote add origin $repositorio);

		#baixando fontes
		echo "baixando fontes (git pull) $ok"
		git pull origin master
	fi
}

#Execução

echo -e "$piscando###CONFIGURANDO GIT###$padrao"

#Perguntas e Avisos
echo "Criar pasta github em $workspace ?"
echo "1-SIM 2-NAO"
read resposta
if [ $resposta == 2 ];then
	echo "Inserir caminho completo de onde deseja criar a pasta github"
	read workspace
fi

echo "Voce colocou o ZIP de configuracao em $workspace ?"
echo "1-SIM 2-NAO"
read resposta
if [ $resposta != 1 ];then
        echo -e "$vermelho PROGRAMA ENCERRADO $padrao"
        exit
fi

echo -e "$azul PARA CRIAR A CHAVE SSH VAI PRECISAR PRECIONAR ENTER$padrao"
echo -e "$vermelho O PRIMEIRO GIT PULL VAI PRECISAR DE LIBERACAO DO USUARIO$padrao"

#configurando e-mail e usuario
if [ $(git config --list | grep user.name) ];then
        echo "USUARIO JÁ ESTAVA CONFIGURADO!!!"
else
        echo "configurando usuario git $ok"

	git config --global user.name "$(head -n 1 $arq_nome_email)"
fi

if [ $(git config --list | grep user.email) ];then
	echo "EMAIL JÁ ESTAVA CONFIGURADO!!!"
else
	git config --global user.email "$(head -n 2 $arq_nome_email | tail -1 )"
fi

#gerando chave ssh
if [ $(ls /home/$USER/.ssh | grep "id_rsa.pub" ) != ""  ];then
	echo CHAVE SSH JÁ EXISTE
else 
	echo "criando chave ssh $ok"
	echo "$vermelho aperte o ENTER varias vezes $padrao"
	ssh-keygen

	#copiar chave ssh para github
	echo "copiando a chave publica para o github $ok"
	echo "$vermelho copie a chave abaixo no github $padrao"
	cat /home/$USER/.ssh/id_rsa.pub
	echo "depois de copiado tecle ENTER"
	read
fi

#Criando pasta github
cd $workspace
if [ -e "github" ];then
        echo "PASTA GITHUB JÁ EXISTE!!!";
else
        $(mkdir github);
        echo "criou pasta";
fi
mv $configuracao github
cd github

#descompactando arquivo configuracao
echo "descompactando arquivo de configuracao $ok"
tar -xf $configuracao -C /tmp

#adicionando repositorios
echo "adicionando repositorios $ok"
for repositorio in $(cat $arq_repositorios);do
	 adicionar_repositorio
done

#Limpando
rm $arq_nome_email
rm $arq_repositorios
rm $arq_nome_link
#Finalização
echo "Pronto, o seu git esta integrado aos seus repositorios do github";
