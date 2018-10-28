#!/bin/bash
temperatura=./temperatura
data=$(date)
sensores=$(sensors)
echo -e " \n data: $data \n\n $sensores" >> $temperatura
