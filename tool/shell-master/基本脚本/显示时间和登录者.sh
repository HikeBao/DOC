#!/bin/bash
#This script displays the date and who's logged on

#如果想在同一行显示
#echo -n -e 'The time is:\n\n'
echo The time is:
date
echo The one who has been logged is:
who

# 收获点
# - 直接输出系统定义好的变量，在一行里面单独写
# - 或者使用``圈起来就会认为是命令了
# - 想要echo不换行，可以添加-n参数，表示no
# - 目前掌握几个系统命令date、who


