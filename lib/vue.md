####  响应式原理

```
如何通过definedProperty将某个组件里面的东西关联起来呢？
let input1 = document.querySelector('#input1');
let input2 = document.querySelector('#input2');
let data = {};
input1.addEventListener('input', (data) => {
    input2.value = input1.value
})
input2.addEventListener('input', data=>{
    input1.value=input2.value;
})

Object.defineProperty(data, 'jack', {
    get () {
        return input1.value;
    },
    set (newValue) {

        input1.value = newValue;
        input2.value = newValue;
    },
    enumerable: true,
    configurable: true
});
```

#### 父子孙生命周期

```javascript
beforeCreated 				// 父组件
created					    // 父组件
beforeMount					// 父组件
	beforeCreated	   		 // 子组件 
    created					// 子组件
    beforeMount				// 子组件
    	 beforeCreated		 // 孙组件
    	 created  			// 孙组件
    	 beforeMount  		 // 孙组件
         mounted		  	 // 孙组件
    mounted					// 子组件
mounted						// 父组件

# 案例
<father>
    <son ref="sonRef"></son>
</father>

// 现在需要在父组件里面调用子组件的方法
created () {
    this.$refs.sonRef.featchData(); // 报错，提示错误。因为this.$refs.sonRef为undefined
}

mounted () {
    this.$refs.sonRef.featchData(); // 正常
}
这就是为什么不建议在created里面进行一些子组件操作得原因，而且希望在使用ref前最好判断是否存在该元素得判断。
es5写法：this.$refs.sonRef && this.$refs.sonRef.featchData();
ts写法：this.$refs.sonRef?.featchData();
```



#### 组件通信

```javascript
# 父子间通信
props和$emit  // 响应式
$parent和$children  // 获取对应的父和子
ref   // 获取DOM或者对应实例,
provide和inject // 静态，可以跨N层级
$attrs和$listeners // 省略在子级里面props声明，直接v-on='evenName'

# 跨级通信
Bus
Vuex
provide和inject 
$attrs和$listeners
url之params通信，也称之为路由通信
browser之storage通信
window通信
```



#### 组件 vs 原生

```javascript
# Vue组件都有什么
- 事件
- 数据（响应式）
- 插槽（具名插槽和作用域插槽）
- 属性（class、style、props）
- ref（指向组件|DOM的实例）

# 原生HTML有什么
- 完全的自由，原始时代，API丰富，随便使用，考验一个人的基础
- 事件
- 数据（非响应式）
- 伪插槽（iframe）
- 属性（这里的属性不可传递）
- 原生DOM的Ref，通过document.querySelector
```



#### **Vue之Css作用域**

- BEM: 代表块（Block），元素（Element），修饰符（Modifier）
- Scoped: 为每个Dom元素加上唯一hash值，样式传透
  - `less`使用 `/deep/`
  - `stylus`使用  >>>
  - `scss`   使用::deep
- modules：将样式保存至`$style`里面

#### **Vue小技巧**

1.当使用`v-if`时，模板渲染在浏览器会产生`<!---->`，但是使用`v-show`不会有。

2.当被内置组件`keep-alive`包含，子组件的`destroy`不会触发。

3.`ref`在组件上表示引用，`ref`在标签上表示`DOM`元素

4.父给子传数据`v-bind`,父给子传`DOM`结构`slot`。子给父传数据`emit、slot-scope`







### **React**

- 1.`React`和`vue `选型和优缺点、核心架构的区别
- 2.`React`中`setState`的执行机制，如何有效的管理状态
- 3.`React`的事件底层实现机制
- 4.`React`的虚拟`DOM`和`Diff`算法的内部实现
- 5.`React`的`Fiber`工作原理，解决了什么问题
- 6.`React Router`和`Vue Router`的底层实现原理、动态加载实现原理
- 7.可熟练应用`React API`、生命周期等，可应用`HOC`、`render props`、`Hooks`等高阶用法解决问题
- 8.基于`React`的特性和原理，可以手动实现一个简单的`React`

### **Vue**

- 1.熟练使用`Vue`的`API`、生命周期、钩子函数
- 2.`MVVM`框架设计理念
- 3.`Vue`双向绑定实现原理、`Diff`算法的内部实现
- 4.`Vue`的事件机制
- 5.从`template`转换成真实`DOM`的实现机制

### **多端开发**

- 1.单页面应用（`SPA`）的原理和优缺点，掌握一种快速开发`SPA`的方案
- 2.理解`Viewport`、`em`、`rem`的原理和用法，分辨率、`px`、`ppi`、`dpi`、`dp`的区别和实际应用
- 3.移动端页面适配解决方案、不同机型适配方案
- 4.掌握一种`JavaScript`移动客户端开发技术，如`React Native`：可以搭建`React Native`开发环境，熟练进行开发，可理解`React Native`的运作原理，不同端适配
- 5.掌握一种`JavaScript` `PC`客户端开发技术，如`Electron`：可搭建`Electron`开发环境，熟练进行开发，可理解`Electron`的运作原理
- 6.掌握一种小程序开发框架或原生小程序开发
- 7.理解多端框架的内部实现原理，至少了解一个多端框架的使用

**数据流管理**

- 1.掌握`React`和`Vue`传统的跨组件通信方案，对比采用数据流管理框架的异同
- 2.熟练使用`Redux`管理数据流，并理解其实现原理，中间件实现原理
- 3.熟练使用`Mobx`管理数据流，并理解其实现原理，相比`Redux`有什么优势
- 4.熟练使用`Vuex`管理数据流，并理解其实现原理
- 5.以上数据流方案的异同和优缺点，不情况下的技术选型

**实用库**

- 1.至少掌握一种`UI`组件框架，如`antd design`，理解其设计理念、底层实现
- 2.掌握一种图表绘制框架，如`Echart`，理解其设计理念、底层实现，可以自己实现图表
- 3.掌握一种`GIS`开发框架，如百度地图`API`
- 4.掌握一种可视化开发框架，如`Three.js`、`D3`
- 5.工具函数库，如`lodash`、`underscore`、`moment`等，理解使用的工具类或工具函数的具体实现原理

### **开发和调试**

- 1.熟练使用各浏览器提供的调试工具
- 2.熟练使用一种代理工具实现请求代理、抓包，如`charls`
- 3.可以使用`Android`、`IOS`模拟器进行调试，并掌握一种真机调试方案
- 4.了解`Vue`、`React`等框架调试工具的使用