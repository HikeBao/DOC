#!/bin/bash
#退出状态码，最大为255，超过则进行模运算
#testing the exit status
var1=10
var2=20
var3=$[ $var1 + $var2]
echo The answer is $var3
exit 5

# 收获点
#  - shell中变量声明不能有空格，不像JS; ex：var1 = 10 这是错误写法
#  - 退出状态码最大为255，超过进行模运算
#  - 进行运算可以使用var3=$[ $var1 + $var2 ]
