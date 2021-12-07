#!/bin/bash

#查看内存使用百分比
free | sed -n '2p' | gawk 'x = int(( $3 / $2 ) * 100) {print x}' | sed 's/$/%/'

# 收获点
# - sed 获取第二行的数据，gawk获取每一行对应的列，sed追加
