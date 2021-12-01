`BOM` （Browser Object Modal浏览器对象模型）。`BOM`提供了很多对象，用于访问浏览器的功能，这些功能与任何网页内容无关。`BOM`的核心对象是`window`，它表示浏览器的一个实例。在浏览器中，`window`对象有双重角色，它既是通过`JavaScript`访问浏览器窗口的一个接口，又是`ECMAScript`规定的`Global`对象。

```javascript
定义全局变量： const a = 99 ; var a = 99; let a = 99;   // 都是定义全局变量
在window对象上直接定义属性 a = 99;		// 类似的，在函数里面如果没有定义变量，同样挂载到全局对象
前者不能使用delete进行删除，后者可以

解释：使用var语句添加的window属性有一个名为[[Configurable]]的特性，这个特性的值被设置为false，因此这样定义的属性不可以通过delete操作符删除
```



### 解释`instanceof`操作符的局限性

```javascript
在使用iframe的情况下，浏览器中会存在多个`Global`对象。在每个框架中定义的全局变量会自动成为框架中`window`对象的属性。由于每个`window`对象都包含原生类型的构造函数，因此每个框架都有一套自己的构造函数，这些构造函数一一对应，但不相等。例如，`top.Object`并不等于`top.frames[0].Object`。这个问题会影响到对跨框架传递的对象使用`instanceof`操作符
```



### Window对象

窗口位置：用来确定和修改`window`对象位置的属性和方法有很多

```javascript
let leftPos = typeof window.screenLeft === 'number' ? 
    window.screenLeft : window.screenX;
let topPos = typeof window.screenTop === 'number' ? 
    window.screenTop : window.screenY;

注意，在`IE`中`screentTop`的值和`chrome、ff、safari`不一样，它表示是`window`距离屏幕顶部再加工具栏的高度，而其他的则仅仅是船体距离屏幕高度

`document.documentElement.clientWidth`: 指的是`html`出去滚动条的宽度

`document.body.clientWidth`: 指的是`body`除去滚动条的宽度

`window.innerWidth`：除去滚动条的宽度

`window.outerWidth`在`IE`和`chrome`有不同的表现
```



### Location对象

```javascript
location`提供了与当前窗口中加载的文档有关的信息，还提供了一些导航功能。因为它既是`window`对象的属性，也是`document`对象的属性`。

location拥有的属性:
hash：`#xxx`
host: `www.baidu.com:80`   返回带端口的域名
hostname: `www.baidu.com`  返回不带端口的域名
href:`https://baidu.com`   返回当前加载页面的完整URL，而location.toString()方法也返回这个值
pathname:`/file/name`      返回URL中的目录和文件名
port: `8080`     	   	   返回URL中的端口号
protocol:`https`           返回页面使用的协议
search:`?id=98`            返回URL中的查询字符串，字符串以问号开头

位置操作

`location.href`
`location.assign`
`window.location`
`location.reload`: 重新加载当前显示的页面，可以加参数true进行去缓刷新
`location.replace`
```



#### history对象

```javascript
history 对象保存着用户上网的历史纪录，从窗口被打开的那一刻算起。因为history是window对象的属性，因此每个浏览器窗口、每个标签页乃至每个框架，都有自己的history对象与特定的window对象关联。

常用方法
`history.go(-Number)`: 前进`-number`页
`history.back()`
`history.forward`
```



### navigator对象

```javascript
现在已经成为识别客户端浏览器的事实标准. 具体拥有什么属性上网查资料
在开发中一般用于判断浏览器的厂商
```





### screen 对象

> 具体查资料



