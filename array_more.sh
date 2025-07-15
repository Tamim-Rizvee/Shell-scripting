#!/bin/bash

read -p "Enter the array:" -a array
odd=()
even=()
for el in "${array[@]}"
do
   if [[ $((el%2)) -eq 0 ]];then
        even+=($el)
    else odd+=($el)
    fi
done

echo "${even[@]}"
echo "${odd[@]}"