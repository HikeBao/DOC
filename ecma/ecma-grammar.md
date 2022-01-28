

#### 变量声明及赋值

```javascript
var a = 10;
```

**这里包含两步：**

1. 声明变量，`var a;`
2. 变量赋值，`a = 10;`

> 注意：逗号运算符是从左往右运算的，所以
>
> let a = 10, b=20;
>
> 逗号运算符从左往右运算，先给a赋值然后再给b赋值。a变量有暂时性死区，而b变量是没有的，会挂载到全局变量

#### 原始值与引用值

> 基本类型使用的是栈内存 (Null, Undefined, String, Number, Boolean)
> 引用类型使用的是堆内存 (Function、 Object、 Array、Map、Set)

```javascript
// 注意，重新赋值的过程不是覆盖的过程.这就是为什么可以恢复数据,这也是基本数据类型不能修改的原因。
var a = 3;
var b = a;

a = 1; 

// 引用数据类型的赋值是存地址，如果是重新赋值则会销毁原来的联系。如果是往里面塞东
// 西则会改变原来的值
let arr1 = [1, 2];
let arr2 = arr1; // 引用类型的赋值
arr.push(3); // 往里面塞东西
arr = [1]; // 重新赋值

字符串、数字和布尔类型等基本数据类型的值并不是引用类型，因此当你向这些值中添加属性时`JavaScript`并不会报错，但实际上你并没有将这些属性添加进去。这些值是不可变的，不能改变。有人会问，为什么有时候字符串可以像对象一样使用一些方法？那就是基本类型的装箱与拆箱的过程。
```



#### switch和if应用场景

```javascript
switch ：使用场景当值已经固定了
if ：使用场景当数据是有一个范围的时候
```



#### for循环

```javascript
for(let i =0; i;i++) {
    # 内部可以通过break跳出循环
    # 可以通过 i = 0 跳出循环
    # 如果for循环在函数里面，可通过return跳出循环
}

// 思考与while的区别
let i = 100;
for(;i--;) {
    console.log(i);
}

```



#### `typeof`类型判断是否欺骗了你

```javascript
typeof(x); // 输出都是字符串，而且在里面输入没有定义的变量也不会报错
typeof(null); // 之所以返回object是因为JavaScript的一个bug，为了指定空对象提出来的。
typeof('1' - '1'); // number
console.log(a); // ReferenceError
console.log(typeof(a)); // undefined
console.log(typeof(typeof(a))); // string
```



#### 严格模式

```javascript
# 如果浏览器不支持严格模式，那么就不会报错
如果是函数的话可能会报错，所以只能从数字和字符串中选择，而字符串最合理
'use strict';

严格模式禁用：caller、callee、with、必须声明变量、var a = b = 1, 函数内的this指向undefined，在严格模式下调用函数要通过call来改变this的指向，函数参数不能重复、对象的属性名拒绝重复(但不报错)，eval在严格模式下是有作用域的不能在全局访问，不能使用八进制，而且在严格模式下给封印的属性赋值扩展、赋值会报错

在非严格模式下，call会将第一个参数装箱。
```



#### new 、点、括号、原型、this

```javascript
 function Foo() {
     getName = function () { alert(1); }
     return this;
 }

 Foo.getName = function () { alert(2); }
 Foo.prototype.getName = function () { alert(3); }
 var getName = function () { alert(4); }
 function getName () { alert(5); }

Foo.getName(); // 2
getName();     // 4   当时做错是因为忽略函数的全部提升问题
Foo().getName();  // 1 这个是因为忽略函数内部有赋值的问题
getName();  // 1    同上
new Foo.getName();  // 2 
new Foo().getName(); // 3
new new Foo().getName();// 3
summary：如果new fn.xxx后面没有带括号，那么fn.xxx先执行，
如果new fn().xxx后面带了括号，那么new fn()限制性
如果返回值是一个基本类型，那么new 基本类型 > 基本类型。eg:new 3 > 3
```



#### return的值是一个赋值表达式时，返回的是右边的值

```javascript
function fbb() {
    var a={};
    return a.b=0;//返回的是等号右边的值0；
}
fbb(); // 0

# 同样道理
function Car(name) {
    return this.name = name;
}
console.log(typeof new Car({}).name); // 返回undefined

这里面涉及到对象的key是基本类型的问题，如果是基本类型的话，都可以作为对象的key值，当然也包括 null 、 undefined 、 ''、 ' ' 、 NaN,如果是引用类型的话，key值是堆地址
```



#### 算术运算符和逻辑运算符优先级

```javascript
1.（）圆括号的优先级最大
2. 一元运算符   ++ 、 --( ++a 优先级小于 a++ )、 ! 、+... 、-...
3. 算术运算符  **(幂) 、* 、 / 、 %(取余) 、 + 、 -
4. 移位运算符 <<（按位左移）、>>（按位右移）、>>>（无符号右移）
5. 比较运算符 < 、 <= 、 > 、 >= 、 == 、 != 、=== 、!==
6. 位运算符 & (按位与) 、^ （按位异或） 、| (按位或)
7. 逻辑运算符 &&(逻辑与)、|| （逻辑或） 
8. 三元运算符
9. 赋值运算符 =、 += 、-= 、*= 、/= 、%=
10. 展开运算符 ...
11. 逗号运算符 , 

所以：当 console.log(true && 1 + 0 || 1),输出的是3，而且逻辑运算符只对真假做校验，不会特意去转化成 true 与 false 作为返回值
```



#### `Object`和`String`、`Number`之间的转换

```javascript
let x = {
    toString () {
        return x;
    },
    valueOf () {
        return y;
    }
}
console.log(x == 1);
console.log(x == '2');
# 分析 以上两个比较都会进行类型的转换，而且都会先经过valueOf。如果valueOf返回的是基本类型，那么就不会经过toString的方法。如果只有toString方法，那么直接走toString方法，并且若返回的不是基本的数据类型则报错。
```



#### `undefined`、`null`、`0`

```javascript
undefined == null // true
undefined == 0 // false
null == 0 // false
Number(null) //0
Number(undefined) // NaN
Number([]) // 0
[] == 0 // true
[''] == 0 // true
[' '] == 0 // true
[undefined] == 0 // true
[null] == 0 // true
```



#### `import`与`require`

```javascript
import与require在ES6里面都是引入模块时使用，而且引入的模块时只读的，不能修改引入的模块。
而且`import`命令式编译阶段执行的，有点类似函数声明和var关键字声明变量，在代码运行之前。因此这意味着被导入的模块会先运行，而导入模块的文件会后执行。
```



#### delete

```javascript
通过var、const、let关键字声明的变量无法使用delete操作符删除
```



#### 解构赋值

```javascript
let arr = [1,2,3];
let [y] = [arr];
y === arr; // true，证明解构赋值是另一种赋值方式
let [x] = arr;
console.log(x); // 1
```



#### 打印引用类型的数据

```javascript
除了 null 和 undefined ，所有的基本类型和引用类型的构造函数原型上都会挂在到一个toString()的方法函数。对于引用类型的数据，可以将其序列化。对于基本类型，可以将其进行格式上面的改变。

最重要一点就是，如果要将引用类型的数据打印在页面上，必须先将其转换为基本类型。
```
