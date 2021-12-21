# New 的基本用法

`JavaScript `语言中，创建一个对象有许多方法，其中之一是使用`new`关键字外加一个函数(这个函数被大多数人称为构造函数)

```javascript
function fn(a,b){}

let obj1 = new fn(para1,para2);
let obj2 = new fn;

```

上面的两种创建对象的方法都是允许的,如果函数不需要用到参数,那么可以传参也可以不传参，如果需要用到参数但是不传参那么参数会被赋值为`undefined`，如果不传参函数后面的括号可以省略

```javascript
function fn(name,age){
	this.name = name;
	let old = age;
}

let obj = new fn();
obj.name 		//undefined
obj.old  		//undefined
let obj1 = new fn('Jacky',888)
obj1.name 		// 'Jacky'
obj1.old 		// 888

```

有人问了，直接量(`let obj={name:"Jacky",old:88}`)创建一个对象不是比你用`new`命令的方式更强？
是不是存在着某种优点? 接着往下看↓↓↓

现在有个需求，A、B分别的两个对象除了`value`不同，`key`都一样，我们用构造函数和直接量对比创建对象的区别

```javascript
let A = {
	name:"Jacky",
	old:88
}
let B = {
	name:"Mike",
	old:25
}

function fn(name,age){
	this.name = name;
	this.old = age;
}
let C = new fn('Jacky',88);
let D = new fn('Mike',25);
```

对比一下就很明显，一样的功能，用不同的方式都能达到目的，但是有没有发现直接量每次创建的对象都要重复去
再次编写`key`值，而对比`new`方式则只需要传入不同的数据即可。现在只需要创建A、B两个对象，如果要创建三个、一百个对象的话，`new`的方式的优势就很明显了。然而`new`的核心优点远不止这点。

```javascript
function fn(name,age){  // 构造函数
	this.name = name;  // 这是函数体里面的代码
	this.old = age;
}

function fn1(name,age){ // 普通函数
	return {name:name,age:age};
}
```

对比一下普通函数，发现了`new`后面的函数(构造函数),没有`return`但是它却能返回一个对象，而普通函数要显式
返回一个对象，否则函数返回`undefined`。 由于`new`命令后面的函数区别于普通函数，它的返回值可省略，默认
返回已经赋值完毕的初始化完成的对象。而普通函数则需要显式提供。

那构造函数返回的对象从哪里来的？
原来，当使用`new`运算符，`Javascript`解释器自动在当前环境创建一个空对象`{}`,然后根据函数体(也就是花括号
包裹的代码)里面的代码初始化这个空对象，其中上下文`(this)`自动绑定到这个空对象里面去，直到全部函数体内
的代码解释完毕后默认返回这个对象的引用给 赋值表达式左边的变量。
这样就可以解释为什么函数体内的this会一直绑定到创建的不同实例上，也可以解释构造函数对象的由来