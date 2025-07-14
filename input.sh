#!/bin/bash
read -p "Enter a number: " num1
read -p "Enter another number: " num2
sum=$((num1 + num2))
echo "The sum of $num1 and $num2 is: $sum"
diff=$((num1 - num2))
echo "The difference between $num1 and $num2 is: $diff"
prod=$((num1 * num2))
echo "The product of $num1 and $num2 is: $prod"
div=$((num1 / num2))
echo "The division of $num1 by $num2 is: $div"
exit 0