1. 在`a`标签中，有一个`target`属性，它的`value`分别有`_self`、`_parent`、`_blank`、`_top`

   其中`_parent`、`_top`代表着框架的层级，究竟是在父框架里面进行展开还是在最外层框架展开新`Tag`

2. 如何适配移动端？

   ```html
   <meta name="viewport">
   ```

   

3. 由于众所周知的情况，国内的主流浏览器都是双核浏览器：基于Webkit内核用于常用网站的高速浏览。基于IE的内核用于兼容网银、旧版网站。以360的几款浏览器为例，我们优先通过Webkit内核渲染主流的网站，只有小量的网站通过IE内核渲染，以保证页面兼容。在过去很长一段时间里，我们主要的控制手段是一个几百k大小网址库，一个通过长期人工运营收集的网址库。

   尽管我们努力通过用户反馈、代码标签智能判断技术提高浏览器的自动切核准确率。但是在很多情况下，我们仍然无法达到百份百正确。因此，我们新增加了一个控制手段：内核控制Meta标签。只要你在自己的网站里增加一个Meta标签，告诉360浏览器这个网址应该用哪个内核渲染，哪么360浏览器就会在读取到这个标签后，立即切换对应的内核。并将这个行为应用于这个二级域名下所有网址。
   目前该功能已经在所有的360安全浏览器实现。我们也建议其它浏览器厂商一起支持这个实现。让这个控制标签成为行业标准。

   content的取值为webkit,ie-comp,ie-stand之一，区分大小写，分别代表用webkit内核，IE兼容内核，IE标准内核。
   若页面需默认用极速核，增加标签：`<meta name="renderer" content="webkit">`
   若页面需默认用ie兼容内核，增加标签：`<meta name="renderer" content="ie-comp">`
   若页面需默认用ie标准内核，增加标签：`<meta name="renderer" content="ie-stand">`

#### 元素节点内联样式

- style对象是个CSSStyleDeclaration对象，它不仅提供了单个CSS属性的访问方式，也提供setPropertyValue(propertyName)、getPropertyValue(propertyName)及removeProperty()方法来操作某个元素节点上的单个CSS属性。
- style获取的样式仅限于通过style设置的元素（内联样式），如果想要获取到class定义的样式的话，那么就需要使用到getComputedStyle（DOM，pre）

#### 文本节点

- textContent与innerText的区别，textContent是DOM规范，关注的仅仅是文本，innerText不是，会将元素内部所有的东西都吐出来，包括DOM结构。
- DOM.normalize() API可以合并兄弟节点为一个节点
- temp3.nextSibling.nextSibling === temp3.nextElementSibling   // true

#### CSS样式表与CSS规则

- 访问DOM中所有样式表(即CSSStyleSheet对象)document.styleSheets，样式表里每条CSS规则（body {background-color: red;}）都表示为一个CSSStyleRule对象

#### DOM 中的JavaScript

- 试图用同一个<script>元素引入外部JavaScript文件并且在它里面编写页面内联JavaScript，将导致该页面内联JavaScrpt被忽略，而引入的外部JavaScript文件会被下载并执行

- <script>元素支持一个加载事件处理程序（即onload），一旦外部JavaScript文件被加载并执行完毕，此回调即执行。同样的document.body.onload也支持

#### DOM事件概览

- 三种方式：1. HTML内联属性事件处理程序 2. 属性事件处理程序 3. addEventListener()方法布置事件回调。
- 传给事件监听函数的事件对象有个eventPhase属性，内含一个数字表示事件是在哪个阶段触发的.1表示在捕捉阶段，2表示在目标阶段，3表示在冒泡阶段。一般而言，开发者希望事件在冒泡阶段触发，从而对象的事件监听函数可以在事件沿DOM树往上冒泡之前处理掉。因此，addEventListener传的最后一个参数都是false值





### **HTML**

- 1.从规范的角度理解`HTML`，从分类和语义的角度使用标签
- 2.常用页面标签的默认样式、自带属性、不同浏览器的差异、处理浏览器兼容问题的方式
- 3.元信息类标签(`head`、`title`、`meta`)的使用目的和配置方法
- 4.`HTML5`离线缓存原理
- 5.可以使用`Canvas API`、`SVG`等绘制高性能的动画
