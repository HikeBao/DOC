#!/bin/bash

# using a function in script

function func1 {
	echo "This is an example of a function"
}

count=1
while [ $count -le 5 ]
do
	func1
	count=$[ $count+1 ]
done
echo "This is the end of the loop"
func1
echo "Now this is the end of the script"

# 收获点
# - 在while循环中如果有中括号的逻辑判断ex：[] 中括号左右需要有空格,在赋值表达式中倒是可以$[$var1 + 1]
# - 循环赋值不是简单的i++或者i=i+1,而是count=$[ $count + 1 ]
