##!/bin/bash

inicio=`date +%s`

for (( i=0; i<100000; i++ ))
do
   echo "hola mundo mesos", $i
   echo "EN DOCUMENTO..." $a >>testo.txt
done

fin=`date +%s`
let total=$fin-$inicio

echo $total

