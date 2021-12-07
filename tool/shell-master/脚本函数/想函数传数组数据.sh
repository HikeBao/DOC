#!/bin/bash

# trying to pass an array variable

function testit {
	echo "The parameters are : $@"
	
	#函数只会读取数组变量的第一个值
	thisarray=$1
	echo "The received array is ${thisarray[*]}"

	local newarray
	newarray=(`echo "$@"`)
	echo "The new array value is : ${newarray[*]}"
}

myarray=(1 2 3 4 5)
echo "The original array is : ${myarray[*]}"

#将数组变量当成一个函数参数，函数只会去函数变量第一个值
#testit $myarray

testit ${myarray[*]}

# 收获点
# - 输出数组${arr[*]},在函数中输出所有数组$@
# - 将数组变成一个函数参数，函数只会取函数变量第一个值
# - 定义数组的方法arr=(1 2 3)元素之间使用空格隔开
