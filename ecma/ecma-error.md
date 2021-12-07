#### 错误与调试

```javascript
# 错误 语法错误的话，一行代码也不执行 SyntaxError
var 1 = 1;
var 1ab = 1;
new = 5;  // 关键字不能赋值
function = 1;
let a = 1:
function 1test () {}

# 引用错误的话，发生错误后面的代码不执行 ReferenceError
var a = 1 = 2;
test();
console.log(xxx);
console.log(a) = 1;

# 范围错误 RangeError
let arr = [1, 2, 3]; arr.length = -1;
let num = new Number(66.66); number.toFixed(-1); // params 0 - 100

# 类型错误 TypeError
123();
let obj = {}; obj.say();
var a = new 'string'; // 实例化必须是构造函数

# URI错误 URIError  
URI：uniform resource identifier
URL：uniform resource locator https://www.baidu.com
URN：uniform resource name    mailto:xxx@qq.com tel:xxxx
let url = decodeURI('%Sfsd');

# eval evalError
----

new Error、 new TypeError、 new SyntaxError、 new RangeError()

# 手动抛出错误
try catch finally throw
try {
    // throw 抛出错误，被e捕获
    console.log(a);
} catch (e) {
    // 这里捕获到 throw 抛出的错误
    console.log(e.name + ': ' + e.message);
} finally {
    console.log('xxx');
}
其实这里的 finally 可要可不要，因为写在 try catch 后面的语句无论如何都会执行，而 finally 的作用就是无论如何都要执行，但是有一点需要注意的是，如果 catch 里面也发生错误了，那么写在外面的语句是不会执行的，而写在 finally 里面的语句会执行。
```



#### 期末考试

```javascript
# 一坑
const name = "Lydia"
console.log(name());
变量name保存字符串的值，该字符串不是函数，因此无法调用。

当值不是预期类型时，会抛出TypeErrors。 JavaScript期望name是一个函数，因为我们试图调用它。 但它是一个字符串，因此抛出TypeError：name is not a function

当你编写了一些非有效的JavaScript时，会抛出语法错误，例如当你把return这个词写成retrun时。 当JavaScript无法找到您尝试访问的值的引用时，抛出ReferenceErrors。

# 二坑
function checkAge(age) {
  if (age < 18) {
    const message = "Sorry, you're too young."
  } else {
    const message = "Yay! You're old enough!"
  }
  return message
}

console.log(checkAge(21)) // ReferenceError

# 三坑
function nums(a, b) {
  if
  (a > b)
  console.log('a is bigger')
  else 
  console.log('b is bigger')
  return 
  a + b
}

console.log(nums(4, 2)) // a is bigger undefined
console.log(nums(1, 2)) // b is bigger undefined

```

