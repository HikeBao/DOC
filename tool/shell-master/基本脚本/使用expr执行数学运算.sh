#!/bin/bash
#An example of using the expr command

var1=10
var2=20
var3=`expr $var2 / $var1`
echo "The result is $var3"


# 收获点
#  - ll 可以在linux下查看当前目录的文件状态，如果是可执行文件则显示绿色
#    没有执行权限则显示正常灰色
#  - 声明变量一定要紧贴在一起，不然会报错 ex: var1= 10 会报错
#  - 变量可以有多种写法，其中``表示先执行里面的内容，然后再作为命令输出
#  - 如果``前面加上一个expr，则将expr后面的执行结果作为整个表达式结果输出 // 注意和上面的区别上面是着重以表达式再次输出
