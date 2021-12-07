#### 函数脚本注意点
```javascript
# 参数
$@ 表示所有的参数


# 变量
声明变量的方式var1=11
使用表达式的方式 exprr=$[ $count + 1 ]
循环语句
while $[ $count + 1 ]
do
xxxx
done

for 循环
for value in ${arr[*]}
do
xxx
done

# 赋值
执行函数后需要赋值 var1=`func1 param1 param2`,其中函数的返回值是echo


```