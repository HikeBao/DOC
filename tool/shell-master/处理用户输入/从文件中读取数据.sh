#!/bin/bash
# reading data from a file

count=1
cat test | while read line
do
	echo "Line $count: $line"
	count=$[ $count + 1 ]
done
echo "Finished processing the file"

# 收获点
# - cat 子代输出指令echo，如果是一个文件，就会以行数组的形式输出
# - 获取文件中的每一行数据可以使用read line