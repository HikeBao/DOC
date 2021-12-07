#!/bin/bash

# myscript functions

function addem {
	echo $[ $1 + $2 ]
}

function multem {
	echo $[ $1 * $2 ]
}

function divem {
	if [ $2 -ne 0]
	then
		echo $[ $1/$2 ]
	else
		echo -1
	fi
}

# 收获点
# 脚本库类似前端的loadsh工具，随便调用