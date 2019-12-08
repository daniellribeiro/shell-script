#!/bin/bash
#VARIAVEIS
ARQUIVO_BRUTO=/tmp/arquivo_bruto
ARQUIVO_MES=/tmp/arquivo_mes
ARQUIVO_MOVER=/tmp/arquivo_mover

#limpando arquivos
rm $ARQUIVO_BRUTO $ARQUIVO_MES

#Entrando na pasta principal
cd  /home/daniel/Área\ de\ Trabalho/massa\ teste/2019

#criando massa
stat -c %y ./* > $ARQUIVO_BRUTO

#Obter trecho referente ao mes
cat $ARQUIVO_BRUTO | cut -c6,7 > $ARQUIVO_MES

#remover meses repetidos do arquivo
MES=($(cat $ARQUIVO_MES | sort | uniq))
#definir o que mover
CONTADOR=0
for i in ${MES[*]} ; do
echo $i
	mkdir $i
	$(stat -c %n ./* > $ARQUIVO_MOVER)
	for j in $(cat $ARQUIVO_MOVER);do
		VALOR=$(stat -c %y $j | cut -c6,7)
		if [ $VALOR -eq $i ]
		then
			mv $j $i
		fi
	done
	CONTADOR=$(($CONTADOR+1))
done
#criando pasta
#mkdir $MES
#echo "CRIANDO PASTA"
