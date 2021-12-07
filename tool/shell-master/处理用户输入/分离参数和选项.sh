#!/bin/bash

# #extracting options and parameters

while [ -n "$1" ]
do
	case "$1" in 
	-a) echo "Found the -a option";;
	-b) echo "Found the -b option";;
	-c) echo "Found the -c option";;
	--) shift
		break;;
	*) echo "$1 is not an option";;
	esac
	shift
done

count=1
for param in $@
do
	echo "Parameter #$count: $param"
	count=$[ $count + 1 ]
done

# 收获点
# - shift指令虽然可以跳到指定参数位置，但同时也会消耗参数，所有需要采取一种参数和选项分离的方法
#   上面的 --) shift break;;就是通过--来分离选项和参数的一个方式
# - 存在这么一个问题，就是$@和$*都是代表剩余参数的意思，它们之间的区别？？？？