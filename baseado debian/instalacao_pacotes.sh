#!/bin/bash

#cores
padrao="\033[0m"
verde="\033[0;32m"
ok=$(echo -e "$verde [OK] $padrao")
saida="/dev/null"
instalador="sudo apt install -y"
#automaticos

echo -e "ATUALIZANDO $ok"
sudo apt update > $saida
sudo apt dist-upgrade > $saida

echo "INSTALANDO NET-TOOLS(IFCONFIG) $ok"
$instalador net-tools > $saida

echo "INSTALANDO HTOP $ok" 
$instalador htop > $saida

echo "INSTALANDO VIM $ok"
$instalador vim > $saida

echo "INSTALANDO GPARTED $ok"
$instalador gparted > $saida

echo "INSTALANDO JDK $ok"
$instalador default-jdk > $saida

echo "INSTALANDO GIT $ok"
$instalador git > $saida

echo "INSTALANDO SSH $ok"
$instalador ssh > $saida

#echo "INSTALANDO PLAYONLINUX $ok"
#$instalador playonlinux > $saida

#echo "INSTALANDO WINBIND(PRECISA PARA O PLAYONLINUX) $ok"
#$instalador winbind > $saida

echo "INSTALANDO STEAM $ok"
$instalador steam > $saida

echo "INSTALANDO VIRTUALBOX $ok"
$instalador virtualbox > $saida

echo "INSTALANDO MC $ok"
$instalador mc > $saida

#manuais
echo "Ir na Loja Ubuntu"
echo "E Baixar:"
echo "- Spotify"
echo "- Eclipse"
echo "- Pinta(Paint)"
