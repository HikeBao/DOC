#### 常用数组函数轮子

```javascript
// 判断数据类型
const isType = type => target => `[object ${type}]` === Object.prototype.toString.call(target);
const typeArray = [
    'Number', 
    'Array', 
    'Object', 
    'Undefined', 
    'Null', 
    'Set', 
    'Map', 
    'Symbol'], typeObj = {};
typeArray.forEach(item => typeObj[`is${item}`] = isType(item));

// Map ES5实现
// 关键在于hasOwnProperty
// 需要注意的是，指定的 this 值并不一定是该函数执行时真正的 this 值，
// 如果这个函数在非严格模式下运行，则指定为 null 和 undefined 的
// this值会自动指向全局对象（浏览器中就是 window 对象），同时值为原始
// 值（数字，字符串，布尔值）的 this 会指向该原始值的自动包装对象。
const selfMap = function (fn, context) {
    let arrMap = Array.prototype.slice.call(this);
    let arr = Array(arrMap.length-1);
    for(let i = 0 ; i < arrMap.length ; i++) {
        if(!arrMap.hasOwnProperty(i)) continue;
        arr[i] = fn.call(context, arrMap[i], i, this);
    }
    return arr;
}

// reduce 实现 Map方法
// 关键在...acc以及第二个参数[]
const selfMap = function (fn, context) {
    let arr = Array.prototype.slice.call(this);
    arr.reduce((acc, cur, index) => [...acc, fn.call(context, cur, index, this)], []);
}

// filter ES5实现
const selfFilter = function (fn, context) {
    let arrFilter = Array.prototype.slice.call(this);
    let arr = [];
    for(let i = 0 ; i < arrFilter.length ; i++) {
        if(!arrFilter.hasOwnProperty(i)) continue;
        fn.call(context, arrFilter[i], i ,this) && arr.push(arrFilter[i]);
    }
    return arr;
}

// reduce实现数组filter方法
const selfFilter = function (fn, context) {
  return this.reduce((pre,cur,index)=>fn.call(context,cur,index,this) ? [...pre, cur]:[...pre], []);
}

// flat ES5实现
// 关键点是判断如果是数组的话递归调用自身
// 设置depth和reduce的第二个参数是空数组[]
const selfFlat = function (depth = 1) {
    let flatArr = Array.prototype.slice.call(this);
    if(depth === 0) return flatArr;
    return flatArr.reduce((acc, cur) => Array.isArray(cur) ? [...acc, ...selfFlat.call(cur, depth-1)]:[...acc, cur], []);
}

// Some ES5实现
// 当是空数组或者是全是false则返回false
// 关键点在于最后一句if(res) return true;
// 主要用于判断某个item如果满足就立即跳出循环
const selfSome = function(fn, context) {
    let someArr = Array.prototype.slice.call(this);
    
    if(!someArr.length) return false;
    for(let i = 0; i < someArr.length; i++) {
        if(!someArr.hasOwnProperty(i)) continue;
        let res = fn.call(context, arr[i], i, this);
        if(res) return true;
    }
    return false;
}

// Reduce ES5实现
// 这里的let i = ++startIndex有点骚
// 使用了两次for循环
// 关键是这个 res = fn.call(null, res, reduceArr[i], i, this);
// 可以返回上一次结果
const selfReduce = function(fn, initialValue) {
    let reduceArr = Array.prototype.slice.call(this),
        res,
        startIndex;
    if(initialValue === undefined) {
        for(let i = 0 ; i< reduceArr.length; i++) {
            if (!reduceArr.hasOwnProperty(i)) continue;
            startIndex = i;
            res = reduceArr[i];
            break;
        }
    } esle {
        res = initialValue;
    }
    
    for(let i = ++startIndex || 0; i < reduceArr.length; i++) {
        if(!reduceArr.hasOwnProperty(i)) continue;
        res = fn.call(null, res, reduceArr[i], i, this);
    }
    return res;
}

// 实现函数的Call方法
// 当检测到没有传入正确的上下文，自动绑定至window
// bind的方法只返回结果，不返回函数，所以每次调用的时候都删除掉绑定的函数
// 通过唯一标志Symbol来解决函数名唯一的问题
const selfCall = function (context, ...args) {
    let func = this;
    context || (context = window);
    if(typeof func !== 'function') throw new TypeError('Is not a function');
    let caller = Symbol(caller);
    context[caller] = func;
    let res = context[caller](...args);
    delete context[caller];
    return res;
}

// 实现Bind方法
// new.target属性允许你检测函数或构造方法是否是通过new运算符被调用的。在通过new运算符被初始
// 化的函数或构造方法中，new.target返回一个指向构造方法或函数的引用。在普通的函数调用中，
// new.target 的值是undefined
// 函数的 bind 方法核心是利用 call，同时考虑了一些其他情况，例如
// bind 返回的函数被 new 调用作为构造函数时，绑定的值会失效并且改为 new 指定的对象
// 定义了绑定后函数的 length 属性和 name 属性（不可枚举属性）
// 绑定后函数的原型需指向原来的函数

const isComplexDataType = obj =>
(typeof obj === 'object' || typeof obj === 'function') && obj !== nullj;

const selfBind = function (bindTarget, ...args1) {
    if(typeof this !== 'function') 
        throw new TypeError('Bind must be called on a function');
    let func = this;
    let boundFunc = function(...args2) {
        let args = [...args1, ...args2];
        if(new.target) {
            let res = func.apply(this, args);
            
            if(isComplexDataType(res)) return res;
            
            return this;
        } else {
            func.apply(bindTarget, args);
        }
    }
    
    this.prototype && (boundFunc.prototype = Object.create(this.prototype));
    
    let desc = Object.getOwnPropertyDescriptors(func);
    Object.defineProperties(boundFunc, {
        length: desc.length,
        name: Object.assign(desc.name, {
            value: `bound${desc.name.value}`
        })
    });
    return boundFunc;
}

// 所谓防抖，就是指触发事件后在 n 秒内函数只能执行一次，如果在 n 秒内又触发了事件，则会重新计算函数执行时
// 间。
// 立即执行版的意思是触发事件后函数会立即执行，然后 n 秒内不触发事件才能继续执行函数的效果。
// 非立即执行版的意思是触发事件后函数不会立即执行，而是在 n 秒后执行，如果在 n 秒内又触发了事件，则会重新
// 计算函数执行时间。
const debounce = (func, time =17, options = {
    immediate: true,
    context: null
}) => {
    let timer;
    const _debounce = function (...args) {
        if(timer) {
            clearTimeout(timer);
        }
        if(options.leading && !timer) {
            timer = setTimeout(null, time);
            func.apply(options.context, args);
        } else {
            timer = setTimeout(() => {
                func.apply(options.context, args);
                timer = null;
            }, time);
        }
    };
    _debounce.cancel = function () {
        clearTimeout(timer);
        timer = null;
    };
    return _debounce;
}

// 节流
const throttle = (func, time = 17, options = {
  	leading: true,
    trailing: false,
    context: null
}) => {
    let previous = new Date(0).getTime();
    let timer = null;
    const _throttle = function (...args) {
        let now = new Date().getTime();
        
        if(!options.leading) {
            if (timer) return;
            timer = setTimeout(() => {
                timer = null;
                func.apply(options.context, args);
            }, time);
        } else if (now - previous > time) {
            claerTimeout(timer);
            timer = setTimeout(() => {
                func.apply(options.context, args);
            }, time);
        }
    }
    
    _throttle.cancel = () => {
        previous = 0;
        clearTimeout(timer);
        timer = null;
    }
    return _throttle;
}

// new 关键字
const isComplexDataType = obj => (typeof obj === 'object' ||typeof obj === 'function') && obj !== null
const selfNew = function (fn, ...rest) {
    let instance = Object.create(fn.prototype);
    let res = fn.apply(instance, rest);
    return isComplexDataType(res) ? res : instance;
}

// instanceof 
const selfInstanceof = function (left, right) {
    let proto = Object.getPrototypeOf(left);
    while (true) {
        if(proto == null) return false;
        if(proto === right.prototype) {
            return true;
        }
        proto = Object.getPrototypeOf(proto);
    }
}

// private variable
const proxy = function(obj) {
    return new Proxy(obj, {
        get(targe, key) {
            if(key.startsWidth('_')) {
                throw new Error('private key');
            }
            return Reflect.get(target, key);
        },
        ownKeys(target) {
            return Reflect.ownKeys(target).filter(key => !key.startsWidth('_'));
        }
    })
}

// class
function inherit(subType, superType) {
    subType.prototype = Object.create(superType.prototype, {
        constructor: {
            enumerable: false,
            configurable: true,
            writable: true,
            value: subType	
        }
    });
    Object.setPrototypeOf(subType, superType)
}


// 简单实现 JSON.stringify 方法
const isString = value => typeof value === 'string';
const isSymbol = value => typeof value === 'symbol'
const isUndefined = value => typeof value === 'undefined'
const isDate = obj => Object.prototype.toString.call(obj) === '[object Date]'
const isFunction = obj => Object.prototype.toString.call(obj) === '[object Function]';
const isComplexDataType = value => (typeof value === 'object' || typeof value === 'function') && value !== null;
const isValidBasicDataType = value => value !== undefined && !isSymbol(value); // 合法的基础类型
const isValidObj = obj => Array.isArray(obj) || Object.prototype.toString.call(obj) === '[object Object]';// 合法的复杂类型(对象)
const isInfinity = value => value === Infinity || value === -Infinity


// 在数组中存在 Symbol/Undefined/Function 类型会变成 null
// Infinity/NaN 也会变成 null
const processSpecialValueInArray = value =>
    isSymbol(value) || isFunction(value) || isUndefined(value) || isInfinity(value) || isNaN(value) ? null : value;

// 根据 JSON 规范处理属性值
const processValue = value => {
    if (isInfinity(value) || isNaN(value)) {
        return null
    }
    if (isString(value)) {
        return `"${value}"`
    }
    return value
};

let s = Symbol('s')
let obj = {
    str: "123",
    arr: [1, {e: 1}, s, () => {
    }, undefined,Infinity,NaN],
    obj: {a: 1},
    Infinity: -Infinity,
    nan: NaN,
    undef: undefined,
    symbol: s,
    date: new Date(),
    reg: /123/g,
    func: () => {
    },
    dom: document.querySelector('body'),
};

// obj.loop = obj

const jsonStringify = (function () {
    // 闭包 + WeakMap 防止循环引用
    let wp = new WeakMap()
    // 递归调用 jsonStringify 的都是闭包中的这个函数，而非 const 声明的 jsonStringify 函数
    return function jsonStringify(obj) {
        if (wp.get(obj)) throw new TypeError('Converting circular structure to JSON');
        let res = "";

        if (isComplexDataType(obj)) { // 复杂类型的情况
            if (obj.toJSON) return obj.toJSON; // 含有 toJSON 方法则直接调用
            if (!isValidObj(obj)) {  // 非法的复杂类型直接返回
                return
            }
            wp.set(obj, obj);

            if (Array.isArray(obj)) {  // 数组的情况
                res += "[";
                let temp = []; //声明一个临时数组用来控制属性之间的逗号
                obj.forEach((value) => {
                    temp.push(
                        isComplexDataType(value) && !isFunction(value) ?
                            jsonStringify(value) :
                            `${processSpecialValueInArray(value, true)}`
                    )
                });
                res += `${temp.join(',')}]`
            } else {  // 对象的情况
                res += "{";
                let temp = [];
                Object.keys(obj).forEach((key) => {
                    // 值是对象的情况
                    if (isComplexDataType(obj[key])) {
                        // 值是合法对象的情况
                        if (isValidObj(obj[key])) {
                            temp.push(`"${key}":${jsonStringify(obj[key])}`)
                        } else if (isDate(obj[key])) { // Date 类型调用 toISOString
                            temp.push(`"${key}":"${obj[key].toISOString()}"`)
                        } else if (!isFunction(obj[key])) { // 其余非函数类型返回空对象
                            temp.push(`"${key}":{}`)
                        }
                    } else if (isValidBasicDataType(obj[key])) {   // 值是基本类型
                        temp.push(`"${key}":${processValue(obj[key])}`)
                    }
                });
                res += `${temp.join(',')}}`
            }
        } else if (isSymbol(obj)) { // Symbol 返回 undefined
            return
        } else {
            return obj  // 非 Symbol 的基本类型直接返回
        }
        return res
    }
})();


console.log(jsonStringify(obj));
console.log(JSON.stringify(obj));

`为什么 ['1', '7', '11'].map(parseInt) 返回 [1, NaN, 3]`
['1', '7', '11'].map(parseInt) 不能按预期工作，因为在每次迭代中 map 传递三个参数 parseInt()。第二个参数 index 作为radix（进制）参数传递给 parseInt 。因此，使用不同的基数解析数组中的每个字符串。'7'被解析为基数1，它是 NaN，'11' 被分析为基数 2，值为 3，'1' 被解析为默认基数 10，因为它的索引 0 是假值。
```



> 这里有个注意点：
>
> - 为什么不将this直接当做数组使用，而要使用Object.prototype.slice.call()将其转化为数组？
>   - 因为传进来的this不一定是数组，有可能是类数组，这样就可以兼容
> - 为什么要使用Object.prototype.slice.call()转化为数组，不能换成扩展运算符吗？
>   - 不可以，因为扩展运算符的类型是固定的，要么是数组要么是类数组，不过可以使用`Array.from()`,可以兼容类数组和数组



### 中期评审报告（不及格）

- 没有思考函数的作用是用来干什么的，以及最后的返回值应该是怎样 （some没有返回false可以得知）
- 没有考虑到获取第一个元素的作用以及如何获取第一个元素，而且获取了第一个元素后没有记录当前索引下标，导致第二次循环从零开始。并且忽略了reduce函数的作用，是将当前元素和上一次元素进行比对，而不是上一次元素跟索引进行比对

如何改进：写轮子前先思考轮子是干什么的，明确这一点很重要，其次考虑循环的目的是为了什么，是为了获取某个元素还是遍历所有，如果是获取某个元素要及时退出循环





1. 手撕常用数组方法`map`、`filter`等,在微信公众号有专门的文章可以参考

   - `map`、`filter`、`reduce`、`some`、`flat`

   - 手动实现`call、apply、bind`

   - 1.多种方式实现数组去重、扁平化、对比优缺点
   - 2.多种方式实现深拷贝、对比优缺点
   - 3.手写函数柯里化工具函数、并理解其应用场景和优势
   - 4.手写防抖和节流工具函数、并理解其内部原理和应用场景
   - 5.实现一个`sleep`函数
   - 6.了解递归和循环的优缺点、应用场景、并可在开发中熟练应用

> 关于编译原理、不需要理解非常深入，但是最基本的原理和概念一定要懂，着对于学习一门编程语言非常重要

### **编译原理** 

- 1.理解代码到底是什么，计算机如何将代码转换为可以运行的目标程序
- 2.正则表达式的匹配原理和性能优化
- 3.如何将`JavaScript`代码解析成抽象语法树(`AST`)
- 4.`base64`的编码原理
- 5.几种进制的相互转换计算方法，在`JavaScript`中如何表示和转换

### **网络协议**

- 1.理解什么是协议，了解`TCP/IP`网络协议族的构成，每层协议在应用程序中发挥的作用
- 2.三次握手和四次挥手详细原理，为什么要使用这种机制
- 3.有哪些协议是可靠，`TCP`有哪些手段保证可靠交付
- 4.`DNS`的作用、`DNS`解析的详细过程，`DNS`优化原理
- 5.`CDN`的作用和原理
- 6.`HTTP`请求报文和响应报文的具体组成，能理解常见请求头的含义，有几种请求方式，区别是什么
- 7.`HTTP`所有状态码的具体含义，看到异常状态码能快速定位问题
- 8.`HTTP1.1`、`HTTP2.0`带来的改变
- 9.`HTTPS`的加密原理，如何开启`HTTPS`，如何劫持`HTTPS`请求
- 10.理解`WebSocket`协议的底层原理、与`HTTP`的区别

### **设计模式**

- 1.熟练使用前端常用的设计模式编写代码，如单例模式、装饰器模式、代理模式等
- 2.发布订阅模式和观察者模式的异同以及实际应用
- 3.可以说出几种设计模式在开发中的实际应用，理解框架源码中对设计模式的应用

**前端安全**

- 1.`XSS`攻击的原理、分类、具体案例，前端如何防御
- 2.`CSRF`攻击的原理、具体案例，前端如何防御
- 3.`HTTP`劫持、页面劫持的原理、防御措施









> 据我了解的大部分前端对这部分知识有些欠缺，甚至抵触，但是，如果突破更高的天花板，这部分知识是必不可少的，而且我亲身经历——非常有用！



### **JavaScript编码能力** 

- 1.多种方式实现数组去重、扁平化、对比优缺点
- 2.多种方式实现深拷贝、对比优缺点
- 3.手写函数柯里化工具函数、并理解其应用场景和优势
- 4.手写防抖和节流工具函数、并理解其内部原理和应用场景
- 5.实现一个`sleep`函数

### **手动实现前端轮子**

- 1.手动实现`call、apply、bind`
- 2.手动实现符合`Promise/A+`规范的`Promise`、手动实现`async await`
- 3.手写一个`EventEmitter`实现事件发布、订阅
- 4.可以说出两种实现双向绑定的方案、可以手动实现
- 5.手写`JSON.stringify`、`JSON.parse`
- 6.手写一个模版引擎，并能解释其中原理
- 7.手写`懒加载`、`下拉刷新`、`上拉加载`、`预加载`等效果

### **数据结构**

- 1.理解常见数据结构的特点，以及他们在不同场景下使用的优缺点
- 2.理解`数组`、`字符串`的存储原理，并熟练应用他们解决问题
- 3.理解`二叉树`、`栈`、`队列`、`哈希表`的基本结构和特点，并可以应用它解决问题
- 4.了解`图`、`堆`的基本结构和使用场景

### **算法**

- 1.可计算一个算法的时间复杂度和空间复杂度，可估计业务逻辑代码的耗时和内存消耗
- 2.至少理解五种排序算法的实现原理、应用场景、优缺点，可快速说出时间、空间复杂度
- 3.了解递归和循环的优缺点、应用场景、并可在开发中熟练应用
- 4.可应用`回溯算法`、`贪心算法`、`分治算法`、`动态规划`等解决复杂问题
- 5.前端处理海量数据的算法方案

