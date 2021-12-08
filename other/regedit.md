#### 使用注册表完成一些右键打开的功能

```javascript
注册表是Microsoft Windows中的一个重要的数据库，用于存储系统和应用程序的设置信息。
# 书写规范
// 这一句一定要加上，不然执行不了
Windows Registry Editor Version 5.00  
[HKEY_CLASSES_ROOT\Directory\Background\shell\ws] 
// 右键浮窗的文案展示
@="ws"
 // 这个是给右键后的悬浮添加图标
"Icon"="C:\\Program Files\\JetBrains\\WebStorm 2019.1.3\\bin\\webstorm64.exe"

// command就是需要执行的路径,记住后面的%V一定要大写，而且需要有引号(单引号或者双引号)
[HKEY_CLASSES_ROOT\Directory\Background\shell\ws\command] 
@="C:\\Program Files\\JetBrains\\WebStorm 2019.1.3\\bin\\webstorm64.exe '%V'"

`summary` 要注意加上@表示默认值，其他字符ex(`Icon`)则表示是图标

使用regedit的时候，基础注意使用的场景
# HKEY_CLASSES_ROOT\*
	- shell 你可以设置简单explorer 的右键菜单扩展,比如在文件上点右键可以设置用记事本浏览等，只有新建几个键，并设置即可。
	- shellex则比较复杂，你必须懂得win32编程，因为那是通过windows的com接口提供高级功能，比如winrar的菜单，当你在文件上点右键，有用rar压缩，当点击后则会出现winrar,然后操作

# HKEY_CLASSES_ROOT\Directory
	- Background 用于空白处用什么程序打开文件夹
```



| **名称**       | **数据类型**                   | **描述**                                                     |
| -------------- | ------------------------------ | ------------------------------------------------------------ |
| 二进制值       | REG_BINARY                     | 原始二进制数据。大多数硬件组件信息作为二进制数据存储，以十六进制的格式显示在注册表编辑器中。 |
| DWORD 值       | REG_DWORD                      | 由 4 字节长（32 位整数）的数字表示的数据。设备驱动程序和服务的许多参数都是此类型，以二进制、十六进制或十进制格式显示在注册表编辑器中。与之有关的值是 DWORD_LITTLE_ENDIAN（最不重要的字节在最低位地址）和 REG_DWORD_BIG_ENDIAN（最不重要的字节在最高位地址）。 |
| 可扩展字符串值 | REG_EXPAND_SZ                  | 长度可变的数据字符串。这种数据类型包括程序或服务使用该数据时解析的变量。 |
| 多字符串值     | REG_MULTI_SZ                   | 多字符串。包含用户可以阅读的列表或多个值的值通常就是这种类型。各条目之间用空格、逗号或其他标记分隔。 |
| 字符串值       | REG_SZ                         | 长度固定的文本字符串。                                       |
| 二进制值       | REG_RESOURCE_LIST              | 一系列嵌套的数组，用于存储硬件设备驱动程序或它控制的某个物理设备所使用的资源列表。此数据由系统检测并写入 \ResourceMap 树，作为二进制值以十六进制的格式显示在注册表编辑器中。 |
| 二进制值       | REG_RESOURCE_REQUIREMENTS_LIST | 一系列嵌套的数组，用于存储一个设备驱动程序（或其控制的某个物理设备）可以使用的硬件资源列表。系统将此列表的子集写入 \ResourceMap 树。此数据由系统检测，作为二进制值以十六进制的格式显示在注册表编辑器中。 |
| 二进制值       | REG_FULL_RESOURCE_DESCRIPTOR   | 一系列嵌套的数组，用于存储物理硬件设备使用的资源列表。此数据由系统检测并写入 \HardwareDescription 树，作为二进制值以十六进制的格式显示在注册表编辑器中。 |
| 无             | REG_NONE                       | 没有任何特定类型的数据。此数据由系统或应用程序写到注册表，作为二进制值以十六进制的格式显示在注册表编辑器中。 |
| 链接           | REG_LINK                       | 一个 Unicode 字符串，它命名一个符号链接。                    |
| QWORD 值       | REG_QWORD                      | 由 64 位整数数字表示的数据。此数据在注册表编辑器中作为二进制值显示，并且是在 Windows 2000 中引入的。 |



```shell
# 使用regedit，了解regedit大概，明白regedit是一个数据库，存储着系统里面用户信
# 息、硬件信息以及硬件配置信息等重要信息
```



```shell
# 遇到问题
 	- 忽略路径中每个\都需要两个，不然会导致图标展示不出来
 	- 编辑执行命令command的时候，忽略了给\",导致右键可以打开，但不能执行
 	
# 学习到的知识点
 	- %SystemRoot% 打开`cmd`,输入`echo %SystemRoot%` 输出结果是c:/windows
 	- 当使用系统变量的时候，注册表的数据类型要设置为REG_EXPAND_SZ，表示长度可变的数据类型
```

