#!/bin/bash
#display user information from system

echo "User info fro userId:$USER"
echo UID:$UID
echo HOME:$HOME
#换行
echo -e '\n'      
echo 'The cost of the item is \$15'

# 收获点
# - 明白系统变量和系统命令是两种概念
# - echo 默认只会输出字符串，如果没有${}或者是``或者是加上-e
# - 姑且认为-e是转义字符，类似innerHTML,默认是innerText