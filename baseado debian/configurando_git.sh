#!/bin/bash
#instalando git
echo "instalando o git"
apt install git

echo "iniciando o git"
git init

echo "configurando o git"
echo "digite o nome do seu usuario no github"
read username
git config user.name "$username"
echo "digite o e-mail do seu usuario no github"
read email
git config user.email "$email"

echo "adicionando repositorio"
echo "escreva o nome do repositorio"
read repositorio
git remote add origin git@github.com:$username/$repositorio.git

echo "criando chave ssh"
echo "aperte o ENTER varias vezes"
ssh-keygen -t rsa -b 4096 -C "$email"

echo "copiando a chave publica para o github"
echo "copie a chave abaixo no github"
cat /root/.ssh/id_rsa.pub
echo "depois de copiado tecle ENTER"
read

echo "adicionando chave privada para verificar automaticamente"
ssh-add ~/.ssh/id_rsa

echo "Pronto, o seu git esta integrado ao seu repositorio do github"
