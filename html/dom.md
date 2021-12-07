#### 三种对象

```javascript
# 本地对象 Native Object
Object、Function、Array、String、Number、 Boolean、 Error、EvalError、RangeError、ReferenceError、TypeError、URIError、Date、RegExp
其中Number、String和Boolean也称为包装对象

# 内置对象 Build-in Object
Global(虚拟，不存在)、Math

全局的方法：isNaN()、 parseInt()、 Number()、 decodeURI()
全局的属性：Infinity、 NaN、 Undefined
`本地对象和内置对象都是ES的内部对象`

# 宿主对象 Host Object
执行JS脚本的环境提供的对象，浏览器对象window(BOM)和document(DOM)
注意，DOM是由W3C维护的，BOM包含DOM

后面的M代表model的意思，说白了模型就是一套方法和属性去操作文档
```



#### XML

```javascript
Ⅰ. 可以自定义标签，可以成对，也可以单标签,尽量回避一些存在的属性,ex: 表单的name、图片的alt、css的class、id等等，因为但获取DOM里面的属性里面的时候，存在干扰的缺陷

元素：标签 + 内容  `<div>我是内容</div>`
标签: <div></div> 
演进历史：XML > XHTML > HTML
```



#### 引入外部文件

```html
'每一个script标签包括起来的脚本称为代码块，代码块之间独立，会不干扰'
<script src="xxxx">
    document.write('xxx'); // 注意，这样只会执行src引入的文件
</script>

// 故意写错type，里面作为一个模板。需要用到的时候，使用document.getElementById('scriptID')，通过
// 一个compiler函数渲染模板。
<script type="text/tpl" id="scriptID">
	<div>{{ name }}</div>
	<div>{{ sex }}</div>
</script>
```



#### DOM不能直接操作`css`样式表

```javascript
# DOM可以操作HTML和XML，但是不能直接操作CSS
只能操作DOM上的style属性，跟css样式表没有联系，没有直接办法更改样式表，只能通过内联样式覆盖样式表。
解决办法是：更重要一点就是可以通过添加删除类来操作伪元素和css样式表
```



#### 遍历元素树与遍历节点树

```javascript
html的父节点是document，document的父节点document.parentNode元素是null

# 节点数的方法
parentNode 父级元素                                // 兼容性好
childNodes包含元素节点(1)、注释节点(8)、文本节点(3)  // 兼容性好
firstChild和lastChild都会获取到文本节点             // 兼容性好
previouSibling和nextSibling上一个和下一个节点       // 兼容性好

# 元素树的方法
html的父元素html.parentElement是null    // IE9及以下不支持
children 获取子元素                     // IE7及以下不支持
childElementCount === children.length  // IE9及以下不支持
firstElementChild和lastElementChild    // IE9及以下不支持
nextElementSibling和preElementSibling  // IE9及以下不支持
```



#### 了解节点

```javascript
node.nodeName 获取节点的名字(大写),只读属性
node.nodeValue 文本、注释节点、属性节点都有nodeValue值，且可读可写，元素节点没有nodeValue
node.getAttributeNode.[nodeValue/value] // 获取属性节点的nodeValue
node.attributes[n][nodeValue/value] // 也是获取属性的方法
node.nodeType // 获取节点的类型
node.hasChildNodes // 判断是否有子节点
```



### 节点类型常量[节](https://developer.mozilla.org/zh-CN/docs/Web/API/Node/nodeType#节点类型常量)

| 常量                               | 值   | 描述                                                         |
| :--------------------------------- | :--- | :----------------------------------------------------------- |
| `Node.ELEMENT_NODE`                | `1`  | 一个 [`元素`](https://developer.mozilla.org/zh-CN/docs/Web/API/Element) 节点，例如 [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/p) 和 [``](https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/div)。 |
| `Node.TEXT_NODE`                   | `3`  | [`Element`](https://developer.mozilla.org/zh-CN/docs/Web/API/Element) 或者 [`Attr`](https://developer.mozilla.org/zh-CN/docs/Web/API/Attr) 中实际的  [`文字`](https://developer.mozilla.org/zh-CN/docs/Web/API/Text) |
| `Node.CDATA_SECTION_NODE`          | `4`  | 一个 [`CDATASection`](https://developer.mozilla.org/zh-CN/docs/Web/API/CDATASection)，例如 `<!CDATA[[ … ]]>`。 |
| `Node.PROCESSING_INSTRUCTION_NODE` | `7`  | 一个用于XML文档的 [`ProcessingInstruction`](https://developer.mozilla.org/zh-CN/docs/Web/API/ProcessingInstruction) ，例如 `<?xml-stylesheet ... ?>`声明。 |
| `Node.COMMENT_NODE`                | `8`  | 一个 [`Comment`](https://developer.mozilla.org/zh-CN/docs/Web/API/Comment) 节点。 |
| `Node.DOCUMENT_NODE`               | `9`  | 一个 [`Document`](https://developer.mozilla.org/zh-CN/docs/Web/API/Document) 节点。 |
| `Node.DOCUMENT_TYPE_NODE`          | `10` | 描述文档类型的 [`DocumentType`](https://developer.mozilla.org/zh-CN/docs/Web/API/DocumentType) 节点。例如 `<!DOCTYPE html>`  就是用于 HTML5 的。 |
| `Node.DOCUMENT_FRAGMENT_NODE`      | `11` | 一个 [`DocumentFragment`](https://developer.mozilla.org/zh-CN/docs/Web/API/DocumentFragment) 节点 |



#### 节点继承机制DOM结构树的顶点

```javascript
真相预警：浏览器中的Document和元素是两码事，它们独立区别，关系就像Array构造函数和Function构造函数

Node // 注：这里的Node表示一个root节点，它是以下四种构造函数的源头。
     //这里不是nodejs，而是node节点，-> 表示继承的意思
# Document
document -> HTMLDocument -> `Document` -> Node -> EventTarget -> Object.prototype -> null
		   XMLDocument  -> `Document` -> Node -> EventTarget -> Object.prototype -> null

# CharacterData 字符数据，也称为文本数据
Text 
Comment

# Element
div -> HTMLDivElement -> HTMLElement -> Element -> Node -> EventTarget -> ...
					   XMLElement  -> Element -> Node -> EventTarget -> ...

# Attribute
id、class...

# 继承
元素访问getElementById、getElementsByName的方法会报错，因为这两方法只有Document才有
平时的获取DOM节点底层经过了这两个步骤
1. 选择元素 // 注意，当前元素是没有经过HTMLElement构造函数实例化的，这里的每种标签都有不同的HTMLElement构造函数，例如<div></div>对应着HTMLDivElement构造函数
2. 将元素通过HTMLElement构造函数实例化出来一个对象 // 一般而言我们没有太细纠DOM元素和元素的区别，没有明确说明一般默认的都是已经经过构造函数实例化的元素

获取DOM元素的步骤有点类似字面量声明一个数组或者对象，其实JS Engine 低下帮我们做了两个步骤。
let arr = [];   -> let arr = new Array();
let div = document.getElementsByTagName('div')[0];

# Document构造函数和Element构造函数的原型都有以下四种方法
    - getElementsByTagName 
    - getElementsByClassName
    - querySelector
    - querySelectorAll

document.getElementsByTagName('*') // 选取所有的元素

# HTMLDocument
    - body 获取body元素  document.body // 知道了这点的小伙帮可以废弃docuemnt.getElementsByTagName('body')[0]。
    - head 获取head元素  document.head
    - document.documentElement 直接访问html元素 
    - document.title 获取title里面的文本 // 注意，这里是获取innerText数据，不是元素
```







#### HTML DOM 对象 - 方法和属性

```javascript
# 一些常用的 HTML DOM 方法：
getElementById(id) - 获取带有指定 id 的节点（元素）
appendChild(node) - 插入新的子节点（元素）
removeChild(node) - 删除子节点（元素）从页面上拿掉节点，内存的节点还存在，
node.remove() - 也是删除子节点(元素),不单止在页面上拿掉节点，还把内存中的节点也干掉

# 一些常用的 HTML DOM 属性：
innerText  - 节点（元素）的文本值
innerHTML  - 节点 (元素) 的元素值
parentNode - 节点（元素）的父节点
childNodes - 节点（元素）的子节点
attributes - 节点（元素）的属性节点
```



| 方法                      | 描述                                                         |
| :------------------------ | :----------------------------------------------------------- |
| getElementById()          | 返回带有指定 ID 的元素。                                     |
| getElementsByTagName()    | 返回包含带有指定标签名称的所有元素的节点列表（集合/节点数组）。 |
| getElementsByClassName()  | 返回包含带有指定类名的所有元素的节点列表。                   |
| appendChild()             | 把新的子节点添加到指定节点。（包含增加和剪切两个操作） 该方法在Node.prototype里面 |
| c.insertBefore(a,b)       | 父节点c下在节点b之前插入a。在node.prototype                  |
| removeChild()             | 删除子节点。在node.prototype里面。并不能释放内存空间         |
| c.remove()                | 元素自杀。                                                   |
| replaceChild(new, origin) | 替换子节点。                                                 |
| insertBefore()            | 在指定的子节点前面插入新的子节点。                           |
| createAttribute()         | 创建属性节点。                                               |
| createElement()           | 创建元素节点。                                               |
| createTextNode()          | 创建文本节点。                                               |
| getAttribute()            | 返回指定的属性值。                                           |
| setAttribute()            | 把指定属性设置或修改为指定的值。                             |
| innerText()/textContent   | 把对应的标签转换为字符实体                                   |
| createComment()           | 增加注释节点                                                 |
| dataset                   | 自定义属性,data-name="xxx",data-age="66",存放在dataset的对象里面。可以通过getAttribute和setAttribute。兼容性，IE9以下均不兼容 |



#### 复制选中的文本

```javascript
methods: {
    CopyUrl(){
        let url = document.querySelector('#copyObj');
        url.select(); // 选择对象
        document.execCommand("Copy");
    },
}

# 注意事项
1、input 不可以添加 disabled 属性；
2、input的 width 和 height 不能为0；
3、input框不能有hidden属性；
4、input框必须必须挂到页面上才能被select，放在内存也不行 // 这句话的意思是将创建的元素放在document.createDocumentFragment创建的片段里面也不行
但是可以设置opacity。
```



#### 获取元素的时候要注意

```html
<form id="myForm">
    <input id="id">
</form>
<script>
	let form = document.getElementsByTagName('form')[0];
    console.log(form.id); // input，这就是基础篇章里面说的为什么不要命名那些W3C已存在的attribute原因
</script>
```



#### 绑定事件

```javascript
如果给DOM绑定元素，那么有三种方法
 - 内联事件，直接将onclick写在DOM上面 // 最早开始使用 DOM0层面
 - 在JS里面写DOM.onclick事件执行函数 // 有覆盖嫌疑 DOM0层面
 - 给DOM添加事件监听器 DOM.addEventListener(EventName, fn, Boolean) // 目前最佳，第二个参数是相同引用只用执行一次 DOM2
```



#### Event propagation

```javascript
During event propagation ,there are 3 phase: capturing, target, and bubbling. By default, event handlers executed in the bubbling phase(unless you set use capture to true).It goes from the deepest nested element outwards.Event.target was which DOM clicked;

# prevent bubbling
e.stopPropagation()、e.cancelBubble()
w3c regular: e
IE8 : window.event;
so : let e = e || window.event

# prevent default event
inline Event: direct return false;
w3c: e.preventDefault()
ie9: e.returnValue = false
```



#### EventFlow

```javascript
事件流: 描述从页面中接受事件的顺序 冒泡、捕获、目标
	- IE 提出事件冒泡流(Event Bubbling)
	- Netscape 事件捕获流(Event Capturing)
```



#### Event Loop

```javascript
Stack Event // Hight priority
Task Queue
	- macro [setTimeout、setInterval] // Lowest priority
	- micro [new promise、new Mutation observer] // Low priority
这里简单提一下事件循环的优先级以及在开发过程中遇到它们的地方，详情会在ECMAScript基础篇章进行剖析，这里有个大概印象即可
```
