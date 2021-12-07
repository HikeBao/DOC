### **TypeScript** 

- 1.理解`泛型`、`接口`等面向对象的相关概念，`TypeScript`对面向对象理念的实现
- 2.理解使用`TypeScript`的好处，掌握`TypeScript`基础语法
- 3.`TypeScript`的规则检测原理
- 4.可以在`React`、`Vue`等框架中使用`TypeScript`进行开发



#### 数据类型

```typescript
boolean string number any void undefined null 

# 数组
list:number[]=[1, 2, 3, 4];

# 枚举
enum Weeaks{
    Mon,
    Tues,
    Wed
}

# 联合数据类型
data:number | string | boolean

# 类型推论
let x3 = 3; x3 = "hahah" // 报错 

# 类型断言
let strLength:number = (<string>x5).length;
let strLength:number = (x5 as string).length;

```



#### 接口

```typescript
# 定义接口 提取相同方法,约束和规范的作用
interface Iprinter {
    Printing(msg:string):string;
}

interface Imessage {
    getMsg():string;
}

# 实现接口/对类的约束
class colorPrinter implements Iprinter,Imessage {
    Printing(msg:string):string {
        return `打印${ string }成功`;
    }
    getMsg():string {
        return '实现多个接口成功';
    }
}

let p1 = new colorPrinter();
console.log(p1.Printing('简历'))

# 对函数的约束
interface ImyFunction {
    (a:string, b:number):boolean;
}
let fun1:ImyFunction;
fun1 = function(a:string, b:number):boolean {
    return false;
}

# 对数组的约束
interface IstuArr {
    [index:number]:string;
}
let arr1:Istuarr;
arr1=["aaa", "bbb"];

# 对JSON的约束
interface Idata {
    name:string,
    age?:number, // 可选参数
    readonly sex:string // 只读属性
}
function showData(n:Idata) {
    console.log(JSON.stringify(n));
}
showData({name: '你好', age: 19});
```



#### 类

```typescript
# 类的定义
class Person {
    name:string;
    age:number;
    constructor(name:string, age:number) {
        this.name = name;
        this.age = age;
    }
    print () {
        return `${ this.name }:${ this.age }`;
    }
}
let p = new Person('你好', 20);
console.log(p.print());

# 类的继承
class Student extends Person {
    number: string;
    school: string;
    constructor(number:string, school: string) {
        super('nihao', 100);
        this.number = number;
        this.school = school;
    }
    homework() {
        return `${ this.name }今年${ this.age }岁，就读于${ this.school }编号${ this.number }`
    }
}
let stu1 = new Student('1001', '北京大学');
// stu1.number = '1001';
// stu1.school = '北京大学';
console.log(stu1.homework());

# 接口的继承
interface Printer {
    getMsg();
}
interface ColorPrinter extends Printer {
    printing();
}
class HPPrinter implements ColorPrinter {
    getMsg () {}
    printing() {}
}

# 访问修饰符 public private protected 默认是public
class Person {
    age:number;
    private name:string;
    protected email: string;
}
// 访问修饰符
// public    均可访问
// private   子类不可访问
// protected 子类可访问

# 静态属性和静态方法
class Person {
    static name:string;
    static speak () {}
}

# 多态 
类似接口，约束子类，不同子类有不同的实现

# 抽象类和抽象方法
abstract class Animal {
    abstract eat();
    run () {
        
    }
}

```



#### 函数

```typescript
# 函数定义
function add(x, y):number {
    return x + y;
}

# 匿名函数
let add1 = function(x, y):number {
    return x + y;
}

# 函数的参数
function show(name, age?:number):void {
    console.log('无返回值的函数');
} // 可选参数一般放在参数的末尾

// 默认参数
function show(name, age = 0):void {
    console.log(age);
}

// 剩余参数
function add(x1, x2, ...x:number[]):number {
    return x1 + x2 + x.reduce((pre, cur) => pre+=cur,0)
}

# 函数的重载
function getInfo(name:string):void;
function getInfo(age:number):void;
function getInfo(str:any):void {}
```



#### 泛型

```typescript
# 泛型函数
function printarr1<T>(arr:T[]):void {
    ...
}
    
printarr1<number>([11, 22, 33])
printarr1<string>(['fsadfsa', 'fsdfdsa', 33])
    
# 泛型类
class myArrayList<T> {
    public name:T;
    list:T[]=[];
    add(val:T):void {
        
    }
}
let arr = new myArrayList<number>();

# 泛型接口
interface Iadd<T> {
    (x:T, y:T):T;
}
let add:Iadd<number>;
add = function(x:number, y:number) {
    return x + y;
}
```



#### 命名空间

```typescript
namespace IteratorPatter {
    export interface Istat {} // 在命名空间里面，要使用export来暴露
    export class CConcrete implements Istat { // 在命名空间里面，类可以正常实现接口，同样的，暴露也要使用export
        constructor(){}
    }
}

# 同一个命名空间过大，需要分割文件，那么需要使用标签引用来标识，这样就可以像在同一个文件一样编写代码
/// <reference path="Validation.ts" />

# 命名空间外可以通过namespace.Ib访问里面的接口，前提是Ib是要被export出来，不然不能访问哟

# 思考上面的代码，如果是多重嵌套的命名空间，岂不是需要namespaceA.namespaceB.namespaceC。这样就产生了别名的这一概念，可以通过 import D = namespaceA.namespaceB.namespaceC;

# 当涉及到多文件时，我们必须确保所有编译后的代码都被加载了。
第一种方式，把所有的输入文件编译为一个输出文件，需要使用--outFile标记：
tsc --outFile sample.js Test.ts

# 注意一点就是对模块不需要使用命名空间
```



#### 模块解释 TS vs Node

```typescript
# 相对路径
文件./root/src/featrue1/c.ts里面有语句import { moduleA } from './moduleA';
- TS
 1. ./root/src/featrue1/moduleA.ts
 2. ./root/src/featrue1/moduleA.tsx
 3. ./root/src/featrue1/moduleA.d.ts
 4. ./root/src/featrue1/moduleA/package.json (如果指定了"types"属性)

- Node
 1. ./root/src/featrue1/moduleA.js
 2. ./root/src/featrue1/moduleA/package.json (里面有没有main字段,有的话根据main字段)
 3. ./root/src/featrue1/moduleA/index.js

# 非相对路径
文件./root/src/featrue1/c.ts里面有语句import { moduleA } from './moduleA';
- TS
 1. ./root/src/featrue1/moduleA.ts
 2. ./root/src/featrue1/moduleA.tsx
 3. ./root/src/featrue1/moduleA.d.ts
 4. ./root/src/featrue1/moduleA/package.json (如果指定了"types"属性)

 1. ./root/src/moduleA.ts
 2. ./root/src/moduleA.tsx
 3. ./root/src/moduleA.d.ts
 4. ./root/src/moduleA/package.json (如果指定了"types"属性)
- Node
1. ./root/src/featrue1/moduleA.js
2. ./root/src/featrue1/moduleA/package.json (里面有没有main字段,有的话根据main字段)
3. ./root/src/featrue1/moduleA/index.js

4. ./root/src/moduleA.js
5. ./root/src/moduleA/package.json (里面有没有main字段,有的话根据main字段)
6. ./root/src/moduleA/index.js

# 设置baseUrl来告诉编译器到哪里去查找模块。 所有非相对模块导入都会被当做相对于 baseUrl
baseUrl的值由以下两者之一决定：
 - 命令行中baseUrl的值（如果给定的路径是相对的，那么将相对于当前路径进行计算）
 - ‘tsconfig.json’里的baseUrl属性（如果给定的路径是相对的，那么将相对于‘tsconfig.json’路径进行计算）
```



#### 补充

```typescript
# undefined和null都是其他数据类型的子集
let str:string = "ddd";
str = undefined // 不会报错

# 如果不指定类型，那默认是any,后续的任何类型的赋值操作都允许而不会类型检查
let b;
b = 1;
b = "fsss";

# 联合数据类型注意点：其中toString是string和number都拥有的，不然不允许
let demo:string | number;
console.log(demo.toString());

# 剩余参数, 其中剩余参数的类型一定是any，只读属性一旦赋值便不能修改
interface Istate {
    age:number,
	readonly name: string,
    [arg:string]: any
}
let obj1:Istate = {
    age: 10,
    name: '你好'
}

# 数组声明的三种表示方法
- let arr:number [] = [1, 2, 3];
- let arrType: Array<number> = [1, 2, 3];
- interface IArr {
    [index: number]:number
}
interface Istate {
    username: string,
    age: number    
}

let arrType4:IArr = []
let arrType5: Array<Istate> = [{
    username: '张三',
    age: 90
}]
let arrType6: Istate[] = [{ username: '张三', age: 90 }]

# 函数约束
- let funcType1:(name: string, age: number) => number = function (name: string, age:number):number{}
- interface funcType6 {
    (name: string, age:number):number
}
let funcType6: funcType6 = function (name: string, age:number):number{}

# 类型断言不是类型转换，只能断言联合类型里存在的类型
```



#### 新增

```typescript
# 类型别名 - type
type strType = string | number | boolean;
let str:strType = "10";
str = 10;

interface muchType1 {
    name: string
}
interface muchType2 {
    age: number
}
type muchType = muchType1 | muchType2;
let obj1:muchType = { name: "张三" }
let obj2:muchType = { age: 10 }
let obj3:muchType = { age: 10, name: "李四" }

# 限制字符串的选择
type sex = '男' | '女'
function getSex(s:sex):string {
    return s;
}
getSex('男') // 允许
getSex('1') // 报错

# 枚举类型
enum Days {
    Sun,
    Mon
}
console.log(Days) // 双向映射

# 泛型
function CreateArr<T>(length: number, value: T):Array<T> {
    let arr = [];
    for (let i = 0; i<length;i++) {
    	arr[i] = value;
    }
    return arr;
}
let strArray: string[] = CreateArr<string>(3, '1');
// 字符串数组 -> let strArr:string[];
// {[propName:string]: string}
```









