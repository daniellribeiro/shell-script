#!/bin/bash
ARQUIVO=/tmp/arquivo_temporario
PASTA=/home/daniel/Desktop/github/shell_script/aula_so2/musicas
PASTA_TEMP=/tmp/organizados

if [ ! -d "$PASTA_TEMP" ];then
	mkdir $PASTA_TEMP;
fi

#usei o rev porque, por exemplo, na musica 01-Apenas_um_Rapaz_Latino-Americano-Belchior-Paralelas.mp3, o nome do cantor está no 4 array e não no 3, mas pelo que eu vi esempre o 2 de tras para frente
echo $(ls $PASTA | rev | cut -d- -f 2 | rev) > $ARQUIVO

#Criando pasta dos artistas
echo Criando pasta dos artistas [ OK ]
for i in $(seq $(ls $PASTA | wc -l));do
	artista=$(echo $(cut -d' ' -f $i $ARQUIVO));
	cd $PASTA_TEMP
	if [ ! -d  $artista ];then
		mkdir $artista
		echo criou pasta
	else
		echo pasta já existe
	fi
done
cd $PASTA
