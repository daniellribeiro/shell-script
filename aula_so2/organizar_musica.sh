#!/bin/bash
ARQUIVO=/tmp/arquivo_temporario
ARQUIVO_PASTA=/tmp/arquivo_pasta
PASTA=musicas
PASTA_TEMP=/tmp/organizados

mkdir $PASTA_TEMP;
#usei o rev porque, por exemplo, na musica 01-Apenas_um_Rapaz_Latino-Americano-Belchior-Paralelas.mp3, o nome do cantor está no 4 array e não no 3, mas pelo que eu vi esempre o 2 de tras para frente

echo $(ls $PASTA | rev | cut -d- -f 2 | rev) > $ARQUIVO

repetir=0;
while [ $repetir -eq 0 ];
do
	i=1;
	artista=$(echo cut -d' ' -f $i $ARQUIVO);

	variavel=$(echo ls $PASTA_TEMP)
	tr '\n' ' ' < $variavel > $ARQUIVO_PASTA
	pasta=$(echo $(cut -d' ' -f 3 $ARQUIVO_PASTA));
	echo $pasta
	repetir=1;
done
