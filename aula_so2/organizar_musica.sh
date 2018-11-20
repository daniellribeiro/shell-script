#!/bin/bash
ARQUIVO=/tmp/arquivo_temporario
ARQUIVO_ARTISTA=/tmp/arquivo_artista
ARQUIVO_ALBUM=/tmp/arquivo_album
PASTA=/home/daniel/Desktop/musicas
PASTA_TEMP=/tmp/organizados

if [ ! -d "$PASTA_TEMP" ];then
	mkdir $PASTA_TEMP;
fi

#OBS:usei o rev porque, por exemplo, na musica 01-Apenas_um_Rapaz_Latino-Americano-Belchior-Paralelas.mp3, o nome do cantor está no 4 array e não no 3, mas pelo que eu vi esempre o 2 de tras para frente
echo $(ls $PASTA | rev | cut -d- -f 2 | rev) > $ARQUIVO

#Criando pasta dos artistas
echo Criando pasta dos artistas [ OK ]
for i in $(seq $(ls $PASTA | wc -l));do
	artista=$(echo $(cut -d' ' -f $i $ARQUIVO));
	cd $PASTA_TEMP
	if [ ! -d  $artista ];then
		mkdir $artista
		#echo criou pasta
	#else
		#echo pasta já existe
	fi
	cd $PASTA
	mv *$artista* $PASTA_TEMP/$artista
done
cd $PASTA_TEMP

#OBS:Pelo que vi o segundo campo é o nome do album
echo Criando pasta dos albuns [ OK ]
echo $(ls $PASTA_TEMP) > $ARQUIVO_ARTISTA
i=0;
for i in $(seq $(ls $PASTA_TEMP | wc -l));do
	PASTA_ARTISTA=$(echo $(cut -d' ' -f $i $ARQUIVO_ARTISTA));
	cd $PASTA_TEMP/$PASTA_ARTISTA
	echo $PASTA_ARTISTA
	echo $(ls | cut -d- -f 2) > $ARQUIVO_ALBUM
	for j in $(seq $(ls | wc -l));do
		album=$(echo $(cut -d' ' -f $j $ARQUIVO_ALBUM));
		if [ ! -d $album ];then
			mkdir $album
		fi
		mv *$album* $PASTA_TEMP/$PASTA_ARTISTA/$album
	done
done
