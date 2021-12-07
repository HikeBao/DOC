#!/bin/bash

# testing the reading command

echo -n "Enter your name:"
read name
echo "Hello $name, welcome to my program"

read -p "Please enter your age: " age
days=$[ $age * 365 ]
echo "That makes you over $days days old"

#指定多个变量，输入的每个数据值都会分配给表中的下一个变量，如果用完了，就全分配各最后一个变量
read -p "Please enter name:" first last
echo "Checking data for $last. $first..."

#如果不指定变量，read命令就会把它收到的任何数据都放到特殊环境变量REPLY中
read -p "Enter a number:"
factorial=1
for (( count=1; count<=$REPLY; count++))
do
	factorial=$[ $factorial * $count ]
done
echo "The factorial of $REPLY is $factorial"

# 收获点
# - 当设置变量接受用户输入的值的时候，如果输入的参数多于用户设置变量数目，那么从左往右按照顺序赋值，
#   最后一个获取剩下的所有命令，而且$REPLY在有设置变量的时候是不起作用的。
# - $REPLY为系统默认的一个存储临时变量的地方，类似JS函数里面的arguments。它起作用在不设置变量但又
#   传参的情况
# - for循环的格式是 
#   for ((count=1; count<=$variable; count++))
#   do
#   here write what command you want to execute
#   done
# - mkdir命令的后面可以带上变量。ex：mkdir file${num}.txt,其中花括号也可以去掉，建议不要去掉花括号，这样语义化更好
#   否则或造成后面整体识别为变量，但变量的值为空，前面的话就为输出
# 	
# 

