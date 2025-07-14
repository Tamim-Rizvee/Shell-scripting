#!/bin/bash
num1=3.76
num2=2.24
sum=$(echo "$num1 + $num2" | bc)
echo "The sum of $num1 and $num2 is: $sum"