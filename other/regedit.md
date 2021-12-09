# Regedit 注册表

> 概念：注册表是Microsoft Windows中的一个重要的数据库，用于存储系统和应用程序的设置信息。所以在修改注册表前最好进行注册表备份
>
> 应用场景：
>
> - 使用注册表完成一些右键打开的功能，包括空白地方右键，鼠标悬浮在文件上右键



#### 使用注册表完成一些右键打开的功能

```shell
Windows Registry Editor Version 5.00

[HKEY_CLASSES_ROOT\Directory\shell\vscode]
@="vscode"
"Icon"="D:\\software\\install\\vscode\\details\\vs.exe"

[HKEY_CLASSES_ROOT\Directory\shell\vscode\command]
@="\"D:\\software\\install\\vscode\\details\\vs.exe\" \"--working-dir\" \"%v.\""
```

字段说明：

- `Windows Registry Editor Version 5.00`：必须放在`reg`文件的第一行，有点类似`shell`脚本第一行

- `[HKEY_CLASSES_ROOT\Directory\shell\vscode]`：存放脚本静态资源的文件夹

- `@="vscode"`： 鼠标右键的名字

- `"Icon"="D:\\software\\install\\vscode\\details\\vs.exe"`：鼠标右键图标的路径

- `[HKEY_CLASSES_ROOT\Directory\shell\vscode\command]`：存放程序`.exe`的文件夹

- `@="\"D:\\software\\install\\vscode\\details\\vs.exe\" \"--working-dir\" \"%v.\""`：执行程序路径



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
# 遇到问题
 	- 忽略路径中每个\都需要两个，不然会导致图标展示不出来
 	- 编辑执行命令command的时候，忽略了给\",导致右键可以打开，但不能执行
 	
# 学习到的知识点
 	- %SystemRoot% 打开`cmd`,输入`echo %SystemRoot%` 输出结果是c:/windows
 	- 当使用系统变量的时候，注册表的数据类型要设置为REG_EXPAND_SZ，表示长度可变的数据类型
```

