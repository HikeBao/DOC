#!/bin/bash
#using the backtick character  会把反引号里面当作一条命令来执行

testing=`date`
echo "The date and time are:$testing"

# 收获点
# - 证明前面的推理没错，反引号会将反引号作为一条命令执行
# 思考一下，是否所有的程序都会有这样的规则，就是什么时候判定为命令，什么时候
# 判定为普通字符串