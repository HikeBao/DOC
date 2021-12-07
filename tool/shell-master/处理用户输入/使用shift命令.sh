#!/bin/bash
# shift n 移动变量

count=1
while [ -n "$1" ]
do
	echo "Parameter #$count = $1"
	count=$[ $count+1 ]
	shift
done

echo -e "\n"

# demonstrating a multi-position shift
echo "The original parameters : $*"
shift 2
echo "Here's the new first parameter: $1"

# 收获点
# - -n 的意思是字符串长度为0时则为假
# - shift的功能是，让程序跳到下一个参数执行，如果后面加上参数则根据参数跳到指定的位置，而$1则代表
#   跳到指定位置的参数值
# - $*表示的是全部参数的意思
