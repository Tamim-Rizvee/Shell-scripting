#!/bin/bash
for (( i=0 ; i<5; i++))
do
	echo "Hello world"
done

count=0
while [[ $count -le 5 ]]
do 
	echo "$count"
	((count++))
done
