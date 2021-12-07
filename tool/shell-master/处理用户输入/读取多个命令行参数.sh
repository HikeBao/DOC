#!/bin/bash

# handing lots of parameters

total=$[ ${1} * ${!#} ]
echo The tenth parameter is ${1}
echo The eleventh parameter is ${!#}
echo The total is $total

# 收获点
# - 最后一个参数${!#}