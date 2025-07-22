#!/bin/bash

# if (( $(echo "$1>0 && $2>0" | bc) )); then
#     echo "1st quardant"
# elif (( $(echo "$1 > 0 && $2 < 0" | bc) )); then
#     echo "4th quardant"
# elif (( $(echo "$1 < 0 && $2 < 0" | bc) )); then
#     echo "Third quardant"
# else echo "2nd quardant"
# fi

add_numbers(){
    sum=0
    for i in $*; do
        sum=$(( sum + i ))
    done
    echo $sum
}

result=$( add_numbers "$@" )
echo "Sum = $result "