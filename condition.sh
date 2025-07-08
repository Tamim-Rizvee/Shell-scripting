#!/bin/bash
num=5
if (( $num > 10 )); then
    echo "The number is greater than 10"
   elif (( $num == 10 )); then
	echo "The number is equal to 10"
   else 
	echo  "The number is less than 10"
fi
