#!/bin/bash

# using a global variable to pass a value

function db1 {
	value=$[ $value * 2 ]
}

read -p "Enter a value: " value
db1
echo "The new value is : $value"

# 收获点
# - shell中的函数会影响外部变量
# - 执行函数就像执行命令(date、who)一样,不需要加上括号来表明
