#!/bin/bash

num1=3.759
num2=4.50
res=$num1*2+$num2/2

# echo $res
# echo "$res"|bc
# echo "scale=3;$res"|bc

sum=$(echo "$num1 + $num2" | bc)
# echo $sum

if (( $(echo "$sum <= 5" | bc) )); then
    echo "Hello"
    else echo "none"
fi

