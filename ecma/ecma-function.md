```javascript
- 在类里面，static声明的方法只提供给构造函数使用，不能传递给任何子例。如果在实例里使用会出现`TypeError`

# 思考: 当实参没有传值给对应的形参，内部给形参赋值，是没有用的。因为形参和实参没
# 有一 一对应的话，那么arguments是无法跟实参产生联系的，也就是说undefined的时候
# 形参和arguments是不产生联系的
function test(a, b) {
    b = 3;
    console.log(arguments[1]); // undefined，这里的argument[0]对应a，argument[1]对应b
}
test(1);

# 注意，当执行函数的时候，解析引擎自动添加上call
function test () {}
test.call();
summary: apply或者call是更改this的指向

# callee 和caller,arguments是一个指针，指向函数test，所以是引用类型
function test (a, b, c) {
    console.log(arguments.callee.length); // 形参的长度
    console.log(test.length);  // 形参的长度
    console.log(arguments.length); //实参的长度
}
callee在递归里面，若是匿名函数,可通过callee找到对应的递归函数
```



#### `new`的原理

```javascript
关于 `new`，有一件很酷的事情——当你使用`new`关键字调用一个函数时，以下两行代码将隐式地(在底层)为你完成，所创建的对象被称为`this`。
  - `const this = Object.create(Object.prototype);`
  - `return this;`

function newTest (name, age) {
      let me = {}; // 相当于this
      me.name = name;
      me.age = age;
      return me;  // new的时候隐式添加return this；
}
let test1 = newTest('jack', 44);
let test2 = newTest('jack1', 45);

# target属性
ES6引入了new.target属性，用于确认当前作用在哪个构造函数上。若不通过new命令使用构造函数则返回undefined，否者返回对应的构造函数。
class Parent {
    constructor () {
        if(new.target.name === 'Parent') {   // 划重点，这里可以用来禁止当前类被实例化
            throw new Error('本类禁止实例化')
        }
    }
}

```



#### 在函数内声明变量需要注意，这里面的a是局部变量，b是全局变量

```javascript
function test () {
    var a = b = 10; 
}
console.log(b); // 10
```



#### 使用表达式去定义函数的时候，函数名对外部是不可访问的，内部可访问

```javascript
let test1 = function test2() {
    console.log(test2.name); // test2
}
console.log(test2.name); // ReferenceError
```



#### `IIFE`

```javascript
# IIFE Imediately invoked function expression
优点有：自动执行、执行完毕后即释放GO里面的 function
写法一：(fn)()
写法二：(fn())
其中fn是function () {}

# 要注意以下两种写法区别
function fn () {                       function fn() {
    `报错`                                    `不报错`
}()                                    }(6)
左边把第二个括号当作函数的执行，
右边把第二个括号当作数字表达式

# ;(Fn())()
之所以要在前面加上分号，一方面是压缩代码的时候会报错，另一方面因为如果并列两个 IIFE 会造成括号混乱而报错。
```



#### 表达式与语句的区别

```javascript
表达式的定义：能产生值的操作的代码片段称为表达式，
语句：语句不包含值，但它改变程序的运行状态。
函数声明变成表达式时的方法!、+、-、||、&&
其中0 || fn、1 && fn
```



#### 函数调用都发生了什么

```javascript
宏观：函数返回时必须跳回到调用它的地方，因此计算机必须记住调用函数的发生处上下文。计算机存储上下文的地方叫做调用栈。每次调用函数时，当前上下文都会存储在此栈的顶部。当函数返回时，它会从栈中删除顶部上下文，并使用原来的上下文继续执行。在典型的`JavaScript`实现中，函数递归大约比单纯循环慢三倍。也就是说，通过简单循环来运行，通常比多次调用函数开销低。
微观：函数会产生一个独立的AO对象，存放函数执行时需要的属性和方法，其中一定会存在全局GO，排序关系是AO一定会比GO序号靠前，这就是为什么全局不能直接访问局部的一因素。当函数被调用完毕后，会销毁自身的AO对象，然后作用域链初始至函数定义。
```



#### 构造函数调用和普通函数调用以及方法调用在实参处理、调用上下文和返回值方面都有不同。

```javascript
`let obj = new Function("x","y","x+y;")`
a. 如果构造函数调用在圆括号内包含一组实参列表，先计算这些实参表达式，然后传入函数内，这和函数调用和方法调用是一致的。但如果构造函数没有形参，`Javascript`构造函数调用的语法是允许省略实参列表和圆括号的。

b. 调用构造函数创建一个新的空对象，这个对象继承自构造函数的prototype属性。构造函数试图初始化这个新创建的对象，并将这个对象用作其调用上下文，构造函数可以使用this关键字来引用这个新创建的对象。注意，尽管构造函数看起来像一个方法调用，它依然会使用这个新对象作为调用上下文。也就是说，在表达式new o.m()中，调用上下文并不是o.

c. 构造函数通常不使用return关键字，他们通常初始化新对象，当构造函数的函数体执行完毕时，它会显式返回实例化的对象。在这种情况下，构造函数调用表示是计算结果就是这个新对象的值。然而如果构造函数显式地使用return语句返回一个对象或者说引用数据类型，那么实例化后返回的是自定义的引用数据。如果构造函数使用return语句但没有指定返回值，或者返回一个原始值，那么这时将忽略返回值，同时使用这个新对象作为调用结果。这里主要说明当作为构造函数时的返回值存在两种情况，一种是返回引用类型的值会覆盖新创建的实例，一种是返回的基本类型的值会被新创建的对象覆盖。

d.最后一点，也是关于`Function()`构造函数非常重要的一点，就是它所创建的函数并不是词法作用域，相反，函数体代码的编译总是会在顶层函数执行。

let scope = 'globals';
function constructFunction () {
    let scope = 'local';
    
    // 无法捕获局部作用域
    return new Function('return scope'); 
} 

// 这一行代买返回global，因为同故宫Function()构造函数
// 所返回的函数使用的不是局部作用域
constructFunction()(); // =>"global"

既然说到了构造函数，顺便提一下函数的调用方式：
    * 函数调用
    * 作为对象属性的方法调用
    * 作为构造函数调用
    * 使用call、apply见解调用
```



#### 闭包

```javascript
# 当函数内部AO被返回到函数外部并保存时，一定会产生闭包，闭包会导致原来的作用域不释放。
# 过度的闭包可能会导致内存泄漏
为了输出 0 - 9 ，使用IIFE来保存 i 的值

函数被定义的时候的作用域是上级的AO、GO，除了return函数出去外，还可以通过window.xxx = fn

# AO & GO
AO Active Object
GO Global Object
AO：{
	Fn,
    形参，
    实参，
    变量声明，
    执行
    变量赋值
}

GO： {
	Fn,
    变量声明，
    执行
    变量赋值
}
```





#### call、bind、apply

```javascript
三者都是绑定函数的this指向，其中call和apply会立即执行，bind会返回一个函数，apply次参为数组。
DOM.addEventListener('click', function(){}.call(this), false); // 这里面的this指向DOM，因为addEventListener是谁调用this指向谁，然后如果函数里面直接使用this，而不经过call的绑定的话，在严格模式下this会指向undefined，在非严格模式下会指向window。

# 什么情况下有this指向问题
 - 函数里面嵌套函数
 - new 一个构造函数
 - 绑定事件的事件处理函数(click, onmouseover, onmouseout, drag)
 - "use strict";

# instanceof
instanceof运算符用于测试构造函数的prototype属性是否出现在对象的原型链中的任何位置
```



#### 原型链 prototype chain

```javascript
之所以大部分属性都放到原型链上面，因为大部分属性都是读取型，每次new命令都会产生该次属性，如果挂在圆形上就不会每次实例化都产生该属性，而且方法大部分都存放在原型，只有初始化属性才放在构造函数里面。避免属性一个一个地赋值，推荐使用对象那样赋值。

# __proto__
__proto__存放在this的对象里面，作为key值，它的value是构造函数的prototype，原型链的顶端是Object.prototype
__proto__:constructor.prototype
constructor.prototype={
    constructor: Fn,
    __proto__: Other Prototype 
}
// 不是所有的对象都继承于Object.prototype，Object.create(null)就能做到改变原型链的终点

# 修改原型属性
1. 修改基本类型的原型属性，只能修改当前实例化的对象，不能修改原型链上的属性。（因为要访问父级某个属性，肯定时当前实例没有该属性，所以本来想在当前实例修改父级的原型属性，但却给当前实例化对象添加了属性）
2. 修改引用类型的原型属性，当前实例化对象可以获取到父级甚至爷爷级别的原型属性地址，从而改变引用或者改变里面的值都是有可能的。
```



#### 带你进一步了解原型prototype

```javascript
原型是构造函数上的一个属性，原型是所有实例对象上的祖先，而且要new的时候才产生作用，也就是在继承的时候产生作用。有点类似作用域的变量访问。

# 实现继承的方案
 - 实现借用别的构造函数的内置方法，可以使用apply或者call，使用位置是当前实例化对象的构造函数里面。通过，call或者apply改变this的指向。存在不能借用原型链上属性的缺点。
 - 通过原型对象之间赋值可以只复制原型对象上面的属性不复制构造函数里面的方法和属性
	Fn.prototype = Fn1.prototype  // 原型链上的赋值时引用赋值，如果改变某方原型链会影响另一方的原型链
 - 为了弥补原型对象是引用赋值造成互相干扰的问题，可以通过以下两种方法弥补
	- 圣杯模式：通过一个中间函数作为中转站，然后将其实例化的对象作为原型属性的value
 	- 使用Object.create(Fn.prototype);创建一个独立的指向Fn原型属性的对象，然后将其赋值给原型对象。
 - 还有一种方法就是实例化出来的对象作为另一个构造函数的原型Fn.prototype = new Fn1()。这样可以继承构造函数以及原型链上的属性和方法。 //注意，这里没有直接使用Fn1里面的原型属性给Fn赋值，所以就没有引用传递的风险
 - ES6 提供的class字段也可以实现继承(其实是语法糖)
	ex: class Father {}; 
		class Son extends Father {
            constructor () {
                super();
            }
        }
注意：儿子要实现对老爸属性的继承，必须要在constructor构造器里面写上super()。
```



#### 插件结构

```javascript
;(()=>{
    function Test () {}
    Test.prototype = {};
    return Test;
})()

分析：
1. 最外层用IIFE包裹，隔离外界
2. 定义构造器和原型
3. 返回构造器

在ES6里面可以用Class来替换构造函数
class Test () {
    constructor () {}
    privateFn () {}
}
```



#### 纯函数

```javascript
任何时候输入相同的参数，都有相同的返回值返回
```





## Q & A

Q：需要注意的是函数存在函数提升的概念。

A：所以我们在定义函数的时候一般通过变量声明函数的方式，这样就可以避免函数提升的问题出现。

<br>

Q：如果需要在函数里面获取多个参数的话，那么建议使用扩展运算符，尽量避免使用arguments，因为它仅仅是一个类数组，并不是一个真正的数组

A：

```javascript
function restFn (...args) {
    // Your Code
}
```