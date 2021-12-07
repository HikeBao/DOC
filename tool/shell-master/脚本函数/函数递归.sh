#!/bin/bash

function factorial {
	if [ $1 -eq 1 ]
	then
		echo 1
	else
		local temp=$[ $1 -1 ]
		local result=`factorial $temp`
		echo $[ $result * $1 ]
	fi
}

read -p "Please input a value: " value
result=`factorial $value`
echo "The factorial of $value is: $result"

# 收获点
# - 定义函数的局部变量的方式是使用local，shell中默认定义变量为global全局变量
# - 在函数中，除了$0 表示执行脚本的第一个参数外，$num表示执行函数的参数
# - 执行函数的方式类似命令，需要传参的话可以通过在函数后面加上对应的参数即可
