#!/bin/bash
read -p "Enter the value of pie " pie
if [[ $(echo "$pie == 3.14" | bc) -eq 1 ]]; then 
    echo "The value is for pie"
else echo "Not the value for pie"
fi