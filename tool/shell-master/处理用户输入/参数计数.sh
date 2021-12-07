#!/bin/bash
# getting the number of parameters

echo There were $# parameters supplied

#花括号里不能使用美元符号
params=$#

echo The last parameter is $params
echo The last parameter is ${!#}

# 收获点
# - $#不仅可以获取函数里面参数的个数，还可以获取执行程序参数数量
# - $#不能带上花括号，不然报错
# - !#表示最后一个参数
