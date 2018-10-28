#atualizando repositorio
echo atualizando repositorio [ OK ]
echo $(sudo apt-get update)

#atualizando programas
echo atualizando programas [ OK ]
echo $(sudo apt-get upgrade)

#removendo programas desnecessarios
echo removendo programas desnecessario [ OK ]
echo $(sudo apt-get autoremove)

#instalando postgres-10
echo instalando postgres-10 [ OK ]
echo $(sudo apt-get install postgresql-10 -y)

#feito para executar no linux mint 19 - tara
