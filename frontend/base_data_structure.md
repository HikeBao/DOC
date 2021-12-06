#### 显式类型转换

```javascript
Number(null); // 0
Number(undefined); // NaN
Number(true); // 1
parseInt(true); // NaN
parseInt(undefined); // NaN
parseInt(null); // NaN
parseInt(NaN); // NaN
parseInt('10', 16); // 16 把10(16),16(10)
parseInt('123abc'); // 123
parseInt('abc123'); // NaN
13.toString(16); // d

# summary parseInt没有Number一样进行数据类型的隐式转换
```



#### 隐式类型转换

```javascript
let a = '123';
a++;  // 这里隐式类型转换Number(a),然后再a = a + 1;  /、*、-、%都做了隐式转换
let b = 1 > '2'; // '2'会进行Number('2')的转换才进行对比
// > < >= <=都会进行字符串转换为数字，前提是比较的一项是Number类型，如果两项都是字符串，则比较ASCII
let c = 2 > 1 > 3; // false
let d = 2 > 1 == 1; // true
let e  = +'123'; //  123 这里的+会进行Number('123')
// undefined、null、0 没关系，undefined == null 为true
isNaN('123'); // true 这里进行了隐式转换Number('123')
isNaN(null); // false
isNaN(undefined); // true
Number(1) === Number(1); // true
Boolean(true) === Boolean(true); // true
记住，Number和Boolean只会将对应的内容转化为基本类型，没有关键字new的话是不会变成对象的
```



#### ASCII和Unicode

```javascript
# ASCII分为两张表
表1：0-127
表2：128-255

Unicode涵盖ASCII码
'x'.charCodeAt(); // 用来获取字符对应的ASCII码
```



#### JavaScript中被认定是假值

```javascript
false、""、" "、0、null、undefined、NaN
Tips: [] == 0 //true
undefined 转换为数字，值为NaN > Number(undefined)
null 转为数字，值为 0 > Number(null)
```



#### `boolean`、`string`、`number`的装箱、拆箱

```javascript
# str和new String('123')不同
let str = '123';
console.log(new String('123').length)
```

#### padStart、String.raw

```javascript
使用`string.padStart`方法，我们可以在字符串的开头添加填充。传递的参数大于字符串长度会在字符串前面增加一个空格，如果小于则什么事情没有发生

String.raw函数式用来获取一个模板字符串的原始字符串的，它返回一个字符串，其中忽略了转移符(\n，\v,\t)
let str = 'C:\Users\lenovo\Desktop'
console.log(String.raw`${str}`);  // "C:UserslenovoDesktop"
正常应该是 C:\Users\lenovo\Desktop
```
