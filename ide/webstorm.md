webStorm模板配置

### Files-Template 配置 

变量大全

| 变量                  | 描述                                                         |
| :-------------------- | :----------------------------------------------------------- |
| `${DAY}`              | 当月的当天                                                   |
| `${DATE}`             | 当前系统日期                                                 |
| `${DS}`               | 美元符号（`$`）。此变量用于转义美元字符，因此不会将其视为模板变量的前缀。 |
| `${END}`              | 完成编辑变量后的插入位置                                     |
| `${HOUR}`             | 当前时间                                                     |
| `${MINUTE}`           | 当前分钟                                                     |
| `${MONTH}`            | 这个月                                                       |
| `${MONTH_NAME_FULL}`  | 当月的全名（1月，2月等）                                     |
| `${MONTH_NAME_SHORT}` | 当前月份名称的前三个字母（Jan，Feb等）                       |
| `${NAME}`             | 新实体的名称（文件，类，接口等）                             |
| `${PRODUCT_NAME}`     | IDE的名称（例如，WebStorm）                                  |
| `${PROJECT_NAME}`     | 当前项目的名称                                               |
| `${TIME}`             | 当前系统时间                                                 |
| `${USER}`             | 当前用户的登录名                                             |
| `${YEAR}`             | 今年                                                         |

> 自定义模板 `#set( $MyName = "John Smith" )`

```javascript
example
temp.vue
#set( $USER = "HikeBao" ) 

vue文件
#parse("temp.vue")
/**
* @description: #[[$END$]]#
* @Author: $USER
* @date: ${YEAR}-${MONTH}-${DAY}
*/
记住：需要把Enable Live Templates 的CheckBox 勾上
```

根据 <https://www.jetbrains.com/help/webstorm/parse-directive.html>





### 代码检测设置

> 打开*settings -> Editor -> Inspections*

HTML 

```html
Empty Tag                                            ×
Unknown HTML tag                                     x
Unknown HTML tag attribute							 x
```

> 打开*settings -> Editor -> Code Style -> JavaScript* 根据需要进行配置 Spaces、Punctuation

```javascript
快捷键
Ctrl+P              全局搜索文件夹( Navigate>File )
Ctrl+Shift+F        全局搜索文字。类似Ctrl+P的Symbols 
Alt+F				格式化( Reformate Code )
Alt+F1				定位当前文件在左边导航中的位置
					(Navigate Select In...)
Alt+F2				定位当前文件在文件夹中的位置 
					( Show in Explorer )
Alt+C				切换大小写( Toggle Case )
Ctrl+R 				替换文字
Ctrl+X				剪切所选文字，如果没有选中，则剪切光标所在行
Alt+Q				定位到上一处改动( Last Edit Location )
Alt+D               批量选中一样的文字
					( Add Selection for Next Ocurrence )
Ctrl+G 				定位到行数
Alt+H				查看文件修改历史( Show History )
Alt + W             逐步扩展 (Extend Selection)
F11 				添加备注
Ctrl+ [+|-]			折叠或扩展代码
Ctrl+ Shift+[+|-] 	折叠或扩展所有代码
Ctrl+{/}	        搜索对应{[里面的首尾
Ctrl+shift+{        搜索对应{[里面的内容
Alt+A               Add to favorites
/** + 回车           给函数添加注释
```

WebStorm 连接远程服务器

> 第一种方式：Tools -> Deployment 
>
> 第二种方式：Ctrl + Alt + S 打开settings, 找到Build,Execution,Deployment
>
> 准备好 服务器 IP、UserName、Password



`webStorm`小技巧

- 本地比较
- 代码片段(vue)



#### webStorm里面有一个解决冲突的工具，直接右键，solve confilict即可