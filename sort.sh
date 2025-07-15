#!/bin/bash

read -p "Enter the array:" -a array
echo "Before sorting"
echo "${array[@]}"
n=${#array[@]}

for (( i=0 ; i<n ; i++))
do 
    mx=$i
    for(( j=i+1 ; j<n ; j++))
    do
        if [[ ${array[mx]} -gt ${array[j]} ]];then 
           mx=$j
        fi
    done

    temp=${array[i]}
    array[i]=${array[mx]}
    array[mx]=$temp
done

echo "After sorting:"
echo ${array[@]}