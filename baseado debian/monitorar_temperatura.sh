#!/bin/bash

#variaveis de caminho
pasta_log=/monitoramento
arquivo_log=$pasta_log/temperatura-$(date +%d-%m-%Y)
arquivo_temporario=/tmp/temporario

#verificar se pasta monitoramento existe e limpando arquivos antigos
if [ ! -d $pasta_log ];then
	mkdir $pasta_log
else
	$(find $pasta_log/* -mtime +1 -exec rm{} \;) 
fi
#verificar se arquivo_log existe
if [ ! -e $arquivo_log ];then
	echo > $arquivo_log
fi

#separando verificacoes do arquivo
echo -e "\n--------------------------------------------------------------------------\n" >> $arquivo_log

#temperatura alta
 
 #verificar
 echo $(sensors) > $arquivo_temporario
 sed -i 's/k10temp-pci-00c3 Adapter: PCI adapter temp1: +//g' $arquivo_temporario
 temperatura=$(cat $arquivo_temporario | cut -c 1)
 rm -rf $arquivo_temporario
 
 #analisar se está alto
 data=$(date)
 if [ $temperatura -ge 7 ];then
    for i in $(seq 10);do
    echo -e "\n\n TEMPERATURA ALTA!!! FAVOR VERIFICAR \n\n"
    echo -e "\n\n $data ---> TEMPERATURA ALTA!!! FAVOR VERIFICAR\n\n" >> $arquivo_log
    done
 fi

#registro periodico
sensores=$(sensors)
echo -e "\ndata: $data\n\n$sensores" >> $arquivo_log
