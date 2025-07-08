#!/bin/bash
arr=(1 2 3 4)
echo ${arr[@]}
for (( i=0; i<4; i++))
do 
			echo " $i th item is ${arr[i]}"
done
