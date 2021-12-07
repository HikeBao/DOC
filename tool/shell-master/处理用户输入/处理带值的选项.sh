#!/bin/bash

# extracting command line options and values

while [ -n "$1" ]
do 
	case "$1" in
	-a) echo "Found the -a option";;
	-b) param="$3"
		echo "Found the -b option, with parameter value $param"
		shift;; # 这里已经跳转到下一次里面去了
	-c) echo "Found the -c option";;
	--) shift
		break;;
	*) echo "$1 is not an option";;
	esac
	shift
done

count=1
for param in "$@" # 这里的双引号可以不要
do
	echo "Parameter #$count : $param"
	count=$[ $count + 1 ]
done

# 收获点
# - 注意处理带值的参数使用技巧，上面-b选项后面的shift;;并没有执行完毕，而是跳过这个参数
# - shift除了跳转指定参数的作用外，还有就是消耗参数，因为当其执行过后的参数，后面再也获取不到
# - for循环的前提是指定的数组列表不能为空
# - 数组的展示方式是${arr[*]}