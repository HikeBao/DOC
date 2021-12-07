#### node和npm以及打包工具webpack的关系

```javascript
node提供一个模块所需的包，然后npm提供一个包的管理，而webpack将包编译成浏览器能识别的js、html、css、img等等
node的全局变量是global,退出当前node程序使用process.exit()

# 暴露包到全局的两种方式
- exports.module = moduleName
- module.exports = noduleName

# 引包的简便方法
- 使用require的时候，可以省略js后缀名
- require既可以写绝对路径也可以写相对路径
- 使用webStorm调试node程序的时候，记得选择debugger
- require如果只写名字，那么会到当前路径node_modules文件夹下面查找对应的文件，如果找不到的化就会将node_modules/fileName/index.js文件当作默认，但是如果fileName文件夹里面存在package.json文件的话，会以entry作为默认入口
```



#### 递归文件失败原因

```javascript
- 路径问题，不能使用相对路径，明白了path模块的重要性，以及里面的API【resolve】
- 异步问题，获取文件名需要时间

知识拓展: `fs.createReadStream`、`fs.createWriteStream`,当读取的文件比较大的时候，可以使用读写文件流的方式，比readFile好一点
```

#### URL

```javascript
var url=require('url');

# url.parse
url.parse(req.url,true);  
第一个参数是地址
第二个参数是true的话表示把get传值转换成对象

url.formate
url.resolve
```



#### readdir

```javascript
fs.readdir('.idea', (error, files) => {
	if(error){
		return;
	}else {
		for(let i = 0 ; i< files.length; i++) {
			console.log(files[i])
		fs.stat('.idea/' + files[i], (err, stats)=>{
			if(err)return;
			console.log(stats.isFile());
		})
		}
	}
})
上面这段代码没问题，注意在第二次调用fs的state的时候，要包含父文件'.idea'
```