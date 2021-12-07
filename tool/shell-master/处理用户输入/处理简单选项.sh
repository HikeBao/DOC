#!/bin/bash
# extracting command line options as parameters

while [ -n "$1" ]
do
	case "$1" in
	-a) echo "Found the -a option";;
	-b) echo "Found the -b optins";;
	-c) echo "Found the -c optins";;
	*) echo "$1 is not a valid options";;
	esac
	shift
done

# 收获点
# - 当作是复习吧，这里的分情况考虑处理场景比较简单，就是case和简单的几个shfit的配合