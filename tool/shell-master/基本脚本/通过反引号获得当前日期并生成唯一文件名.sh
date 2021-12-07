#!/bin/bash
#copy the /usr/bin directory listing to a log file

today=`date +%y%m%d`
ls /usr/bin -al > log.$today

# 收获点
# - echo 999直接在terminal输出，会复述命令echo 999后再执行
# 
