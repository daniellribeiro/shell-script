#!/bin/bash
#cores
padrao="\033[0m"
verde="\033[0;32m"
OK=$(echo -e [$verde OK $padrao] )

#variaveis
ARQUIVO=arquivo_temporario
ARQUIVO_ARTISTA=arquivo_artista
ARQUIVO_ALBUM=arquivo_album
PASTA=musicas
PASTA_TEMP=organizados

if [ ! -d "$PASTA_TEMP" ];then
	mkdir $PASTA_TEMP;
fi

echo $(ls $PASTA | rev | cut -d- -f 2 | rev) > $ARQUIVO

#Criando pasta dos artistas
echo Criando pasta dos artistas e movendo para sua respectiva pasta $OK
for i in $(seq $(ls $PASTA | wc -l));do
	artista=$(echo $(cut -d' ' -f $i $ARQUIVO));
	if [ ! -d  $PASTA_TEMP/$artista ];then
		mkdir $PASTA_TEMP/$artista
		 mv $PASTA/*$artista* $PASTA_TEMP/$artista
	fi
	#Movendo musicas para pasta do respectivo artista
done

#Criando pasta dos albuns
echo Criando pasta dos albuns e movendo para sua respectiva pasta $OK
echo $(ls $PASTA_TEMP) > $ARQUIVO_ARTISTA
i=0;
for i in $(seq $(ls $PASTA_TEMP | wc -l));do
	PASTA_ARTISTA=$(echo $(cut -d' ' -f $i $ARQUIVO_ARTISTA));
	echo $(ls $PASTA_TEMP/$PASTA_ARTISTA | cut -d- -f 2) > $ARQUIVO_ALBUM
	for j in $(seq $(ls $PASTA_TEMP/$PASTA_ARTISTA | wc -l));do
		album=$(echo $(cut -d' ' -f $j $ARQUIVO_ALBUM));
		if [ ! -d $PASTA_TEMP/$PASTA_ARTISTA/$album ];then
			mkdir $PASTA_TEMP/$PASTA_ARTISTA/$album
		fi
		#movendo musicas para pasta do respectivo album
		mv $PASTA_TEMP/$PASTA_ARTISTA/*$album* $PASTA_TEMP/$PASTA_ARTISTA/$album 2>/dev/null
	done
done

#Movendo para pasta original
echo Finalizando $OK
mv $PASTA_TEMP/* $PASTA

#Apagando arquivos temporarios
echo Apagando arquivos temporarios $OK
rmdir $PASTA_TEMP
rm $ARQUIVO $ARQUIVO_ARTISTA $ARQUIVO_ALBUM
