#!/bin/bash

my_array=(1.2 2.4 3.5 4.7 5.55 6.78)
sum=0.00

for i in "${my_array[@]}";
do 
    sum=$(echo "$sum + $i" | bc)
done

echo "$sum"

read -p "Enter array elements: " -a array
echo "Before operation \n"
echo "${array[@]}"

array[0]=$(echo "${array[1]} + ${array[2]}" | bc)
echo "After operation\n"
echo "${array[@]}"
