#!/bin/bash
# using a variable to hold the list

list="Alabama Alaska Arizona"
list=$list" Connecticut"

for state in $list
do
	echo "Have you ever visited $state"
done

# 收获点
# - 当变量是以空格分开的变量时，用for循环会将每一个空格隔开的字符串输出

