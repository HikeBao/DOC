#!/bin/bash

# using one command line parameter

factorial=1
for (( number = 1; number <= $1; number++))
do
	factorial=$[ $factorial * $number ]
done
echo The factor of $1 is $factorial


# 收获点
# - 一行代码解决factorial问题 shell的魅力