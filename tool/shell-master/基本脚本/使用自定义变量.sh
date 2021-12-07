#!/bin/bash
#testing variables

days=10
guest="Katie"
echo "$guest logged in $days days age"
guest="Katie2"
days=5
echo "$guest logged in $days days age"


# 收获点
# - echo可以传送多个参数，可选双引号，每个变量前面都需要使用$进行声明
# - shell脚本始终是解释型语言，声明和赋是分开的，后面的赋值会覆盖前面的赋值
# - shell有点区别于JS的就是shell里面默认的都是字符串，如果需要进行运算的话，或者说需要将其变成表达式，需要使用$[]