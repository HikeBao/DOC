#!/bin/bash

# demonstrating the local keyword

function func1 {
	local temp=$[ $value +5 ]
	result=$[ $temp * 2 ]
}

temp=4
value=6

func1

echo "The result is $result"
if [ $temp -gt $value ]
then
	echo "temp is larger"
else
	echo "temp is smaller"
fi

# 收获点
# - 定义局部变量使用local
# - shell的大于不同于JS的 > ，它是-gt