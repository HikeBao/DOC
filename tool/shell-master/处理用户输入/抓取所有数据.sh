#!/bin/bash
# testing $* and $@

count=1
for param in "$*"
do
	echo "\$* Parameter #$count = $param"
	count=$[ $count+1 ]
done

count=1
for param in "$@"
do
	echo "\$@ Paramenter #$count = $param"
	count=$[ $count+1 ]
done

# echo "I\'m \$*: " $*
# echo "I\'m \$@: " $@

# 收获点
# - 在双引号和单引号里面，sharp(#)也发挥不出应有的水平
# - $*是获取所有的参数，但是没有for value in arr的功能，也就是说没有数组的功能，它只是简单把参数排列出来
# - $@同样是获取所有参数，而且自带数组功能。
# - 思考一下for循环的常见方式
# 	
# 	方式一：
# 	for value in ${arr[*]} 
# 	do
# 	xxx
# 	done
# 	
# 	方式二：
# 	for ((i=0;i<$count;i++))
# 	do
# 	xxx
# 	done