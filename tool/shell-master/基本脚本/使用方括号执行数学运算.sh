#!/bin/bash

var1=10
var2=50
var3=45
var4=$[$var1 * ($var2 - $var3)]
echo 'The final result is '$var4

# 收获点
# - $[]里面可以嵌套表达式，而且还可以使用小括号分开
# - 在$[]里面不一定需要中括号左右两侧空出空白，不过运算符之间需要空出位置
# 
