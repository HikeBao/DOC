#!/bin/bash
#
uptime | sed 's/user.*$//' | gawk '{print $NF}'

# 收获点
# - sed 编辑处理文本文件 's/new/old' s是替换的意思
# - gawk搭配print来使用，$NF表示最后一列
