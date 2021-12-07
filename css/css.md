## CSS基本语法

- 选择器 + 声明块

  - 选择器 - 通过CSS选择器选中页面中的指定元素，下面会重点写。
  - 声明块 - 选择器后面跟着的是声明块，使用{}括起来，由一个个声明组成，声明由名值对组成，每一个声明使用；结尾。

- # at 规则

  ### **嵌套规则**

  - 所谓“嵌套规则”，就是带有花括号`{}`, 语法类似下面的规则：

    ```css
    @[KEYWORD] {
      /* 嵌套语句 */
    }
    ```

  - `@keyframes`：用来声明Css3 animation动画关键帧用的

    ```
    @keyframes fadeIn {
         0% {
             opacity: 0;
         }
         100% {
             opacity: 1;
         }
     }
    ```

  - `@media`：媒介查询，响应式宽度

    ```css
    @media all and (min-width: 1280px) {
        /* 宽度大于1280干嘛干嘛嘞... */ 
    }
    @media 
    (-webkit-min-device-pixel-ratio: 1.5), 
    (min-resolution: 2dppx) { 
        /* Retina屏幕干嘛干嘛嘞... */ 
    }
    @media print {
        /* 闪开闪开，我要打印啦！ */ 
    }
    @media \0screen\,screen\9 {
        /* IE7,IE8干嘛干嘛嘞... */ 
    }
    @media screen\9 {
          /* IE7干嘛干嘛嘞... */ 
    }
    ```

  - `@page`：这个规则用在打印文档时候修改一些CSS属性。使用`@page`我们只能改变部分CSS属性，例如间距属性`margin`, 打印相关的`orphans`, `widows`, 以及`page-break-*`, 其他CSS属性会被忽略。

    ```css
      @page :first {
        margin: 1in;
    }
    
    @page的伪类包括：:blank, :first, :left, :right
    ```

  - `@supports`：是否支持某CSS属性声明的AT规则

    ```css
    /* 检查是否支持CSS声明 */ 
      @supports (display: flex) {
        .module { display: flex; }
      }
    
      /* 检查多个条件 */ 
    @supports (display: flex) and (-webkit-appearance: checkbox) {
        .module { display: flex; }
    }
    ```

  - `@font-face`：这个大家可能比较熟，自定义字体用的。IE6也支持。

    ```css
    @font-face {
      font-family: 'MyWebFont';
    src:  url('myfont.woff2') format('woff2'),
            url('myfont.woff') format('woff');
    }
    ```

  - `@document`：CSS 4.0规范有相关说明。如果文档满足给定的一些条件，就可以应用我们指定的一些样式。比如说，这个CSS文件被子站A调用，和被子站C调用，我们可以通过域名匹配来执行不同的CSS样式。这样，我们可以有效避免冲突，或者防止外链之类。

    ```css
    :( 大部分浏览器不兼容
    @document url(http://www.w3.org/),
                url-prefix(http://www.w3.org/Style/),
                domain(mozilla.org),
                regexp("https:.*")
    {
    /* 该条CSS规则会应用在下面的网页:
         + URL为"http://www.w3.org/"的页面.
         + 任何URL以"http://www.w3.org/Style/"开头的网页
         + 任何主机名为"mozilla.org"或者主机名以".mozilla.org"结尾的网页     
         + 任何URL以"https:"开头的网页 */
      /* make the above-mentioned pages really ugly */
      body { 
          color: purple; 
          background: yellow; 
        }
    }
      ### **常规规则**
    
    - 所谓“常规规则”指的是语法类似下面的规则：
    @[KEYWORD] (RULE);
    ```

  - `@charset`：定义字符集。字符设置据说会被HTTP头覆盖。某些软件，例如Dreamweaver新建CSS文件时候，自动会带有下面所示代码，但实际开发时候，作用不大，因为meta中已经有所设置(`<meta charset="utf-`)，会覆盖，所以我都是直接删掉的。

    ```css
     @charset "utf-8";
    ```

  - `@import`：导入其他CSS样式文件。实际上线时候，不建议使用，多请求，阻塞加载之类。但本地开发可以使用，用做CSS模块化开发，然后使用一些(如grunt)工具进行压缩并合并。但是呢，相比less, sass等还是有不足，就是`@import`语句只能在CSS文件顶部，使得文件的前后关系控制，就不那么灵活。

    ```css
    @import 'global.css';
    ```

  - `@namespace`：任何 @namespace 规则都必须在所有的 @charset 和 @import 规则之后, 并且在样式表中，位于其他任何 style declarations 之前。

    ```css
    @namespace url(http://www.w3.org/1999/xhtml);
    @namespace svg url(http://www.w3.org/2000/svg);
    
      /* 匹配所有的XHTML  元素, 因为 XHTML 是默认无前缀命名空间 */
    a {}
    
      /* 匹配所有的 SVG  元素 */
      svg|a {}
    
      /* 匹配 XHTML 和 SVG  元素 */
      *|a {}
    ```

  

#### css选择器

```javascript
1.元素选择器
语法：标签名{}
eg：p{} // 为所有的p元素设置样式。

2.ID选择器
语法：#id{} // id值唯一，不能重复
ed：#box{} // 为id为box的元素设置样式。

3.类选择器
语法：.class{}
eg：.box{} // 为所有的class值为box的元素设置样式。

4.分组选择器（也叫并集选择器）
语法：选择器1，选择器2，选择器N{}
eg: #box1,.box2,p{} // 为id为box1，class为box2和p的元素共同设置样式。

5.交集选择器
语法：选择器1选择器2选择器3{}
eg：p.box1{} 为class值为box1的p元素设置样式，注意id为唯一值，一般id选择器不会存在于交集选择器中（没必要）。

6.后代选择器
语法：选择器1 选择器2{}
eg：p .box{} // 选中指定祖先元素p的指定后代.box。

7.子元素选择器
语法：父元素>子元素{}
eg：p>.box{} // 选中制定父元素p的制定子元素。box。**注意与后代元素选择器的区别**

8.伪类选择器
- 伪类可以用来表示一些特殊的状态：
  ：link - 未访问过的超链接。
  ：visited - 已访问过的超链接。
  ：hover - 鼠标移入的元素。
  ：active - 正在点击的元素。
  由于选择器优先级的问题，给超链接a设置伪类时，需要注意他们的顺序，一般的顺序是：love hate 记作（爱与恨）,方便记忆
  :link > :visited > :hover > :active

9.兄弟选择器
 p + div：p后面的第一个div // 不受文本节点的影响，受其元素节点的影响
 p ~ div：p后面的所有div  // 不受文本节点和元素节点的影响

它们和子元素选择器的区别是：它们都是p与div是同级的，而子元素选择器是有嵌套关系的。

选择器最主要的功能就是跟对应的元素在时机恰当的时候添上对应的样式。那么日常开发过程中如何保证准确定位到那个所谓【对应的元素呢？】
BEM命名规范  -- 最常用
scoped     --原理就是在每一个Dom节点添加唯一哈希值，缺点就是解析慢，文件大
module     -- 将所有的样式放在一个对象$style里面管理,而且在使用前需要在css-loader配置里面启用modules: true。一般在style 标签里面加上module即可，如果要区分模块使用module='b'
```



## 选择器的优先级

为同一个元素设置多个样式时，此时哪个样式生效由选择器的优先级确定：

- 选择器的优先级（权重）：

|   ·    | 内联样式 | id选择器 | 类和伪类选择器 | 元素选择器 | 统配选择器 | 继承的样式 |
| :----: | :------: | :------: | :------------: | :--------: | :--------: | :--------: |
| 优先级 |   1000   |   100    |       10       |     1      |     0      |     无     |

- 当一个选择器中含有多个选择器时，需要将所有的选择器的优先级进行相加，然后再进行比较，优先级高的优先显示，选择器的计算不会超过其最大的数量级（10个id选择器的优先级不能达到1000）分组选择器（并集选择器）的优先级单独计算，不会相加。
- 样式后面加！important，该样式获取最高优先级，内联样式不能加！important属性。
- 样式相同的谁在下面执行谁（样式的覆盖）。



#### 伪元素与伪类

```javascript
伪元素 after、before、first-letter、first-line

1. 伪对象要配合content属性一起使用
2. 伪对象不会出现在DOM中，所以不能通过js来操作，仅仅是在 CSS 渲染层加入
3. 伪对象的特效通常要使用:hover伪类样式来激活

伪类 active、focus、hover、link、visited、:first-child、:lang

区别：其中伪类和伪元素的根本区别在于：它们是否创造了新的元素,, 这个新创造的元素就叫 "伪无素" 
伪元素/伪对象：不存在在DOM文档中，是虚拟的元素，是创建新元素。 这个新元素(伪元素) 是某个元素的子元素，这个子元素虽然在逻辑上存在，但却并不实际存在于文档树中. 伪类：存在DOM文档中，(无标签,找不到, 只有符合触发条件时才能看到 ), 逻辑上存在但在文档树中却无须标识的“幽灵”分类可以同时使用多个伪类，而只能同时使用一个伪元素；CSS3中伪类和伪元素的语法不同

使用场景：
- 清除浮动 (在父元素里面设置after伪元素，而且记住位元素要给content和display: block;)
- 面包屑、连接多个项目
    .jack:not(:last-child)::after
- 三角形 border:6px solid rgba(0,0,0,0.7);    # 注意，这里要加上绝对定位，不然会有问题
    border-color:transparent rgba(0,0,0,0.7) transparent transparent
- 阴影
	box-shadow搭配transform里面的rotate
- 字体图标
	iconfont或者awesome-font
```



#### css可继承的常用属性

```html
<style>
    body {
        你可以设置可继承的属性在body元素上，这样样式就可以被所有子代应用
    }
    .inherit {
	1、字体系列属性
        font-family：字体系列
        font-weight：字体的粗细
        font-size：字体的大小
        font-style：字体的风格
        
    2、文本系列属性
        text-indent：文本缩进
        text-align：文本水平对齐
        line-height：行高
        word-spacing：单词之间的间距
        letter-spacing：中文或者字母之间的间距
        text-transform：控制文本大小写（就是uppercase、lowercase、capitalize这三个）
        color：文本颜色
        
	4、列表布局属性：
        list-style: <list-style-type> | <list-style-position> | <list-style-image>
            
    5、光标属性：
		cursor：光标显示为何种形态
    }
  可使用inherif继承属性
</style>
```

#### `CSS`盒模型，在不同浏览器的差异

```javascript
w3c: width = (border + padding) + contentWidth    -- 也称为标准模型
ie:	 width = contentWidth                         -- 也称为怪异模型在低版本IE5/6默认就会使用这种模式
   box-sizing控制到底是`w3c`还是`ie`的盒模型`content-box(w3c)、border-box(ie)`
   
特别地要注意区分：
<!DOCTYPE> 声明不是HTML标签，指示web浏览器关于页面使用哪个HTML版本进行编写的指令。在 HTML 4.01 中，<!DOCTYPE> 声明引用 DTD，因为 HTML 4.01 基于 SGML。DTD 规定了标记语言的规则，这样浏览器才能正确地呈现内容。HTML5 不基于 SGML，所以不需要引用 DTD。
简而言之，<!DOCTYPE>规定了浏览器文档使用哪种html或者xhtml规范

常用：`<!DOCTYPE html>`
```



#### `HTML`文档流的排版规则，`CSS`几种定位的规则、定位参照物、对文档流的影响

```javascript
"排版规则"
标准流/常规流指的是在不使用其他的与排列和定位相关的特殊CSS规则时，各种元素的排列规则。HTML文档中的元素可以分为两大类：`行内元素`和`块级元素`。 在`标准流`中，盒一个接着一个排列;
# 在块级格式化上下文里面， 它们竖着排列；
# 在行内格式化上下文里面， 它们横着排列;
# 当 position 为 static 或 relative，并且 float 为 none 时会触发常规流；
# 对于静态定位(static positioning)， position:static，盒的位置是常规流布局里的位置；
# 对于相对定位(relative positioning)， position:relative，盒偏移位置由 top、 bottom、 left、 right 属性定义。即使有偏移，仍然保留原有的位置，其它常规流不能占用这个位置。
       
// 盒子在标准流中的定位原则
margin控制的是盒子与盒子之间的距离，padding存在于盒子的内部它不涉及与其他盒子之间的关系和相互影响问题，因此要精确控制盒子的位置，就必须对margin有更深入的了解。下面分四种情况对margin调整盒子的位置进行解说。
1. 行内元素之间的水平margin
当两个行内元素紧邻时，它们之间的距离为第一个元素的右margin加上第二元素的左margin。 `IFC`
2. 块级元素之间的竖直margin
两个竖直排列的块级元素，它们之间的垂直距离不是上边的第一个元素的下margin和第二个元素的上margin的总和，而是两者中的`较大`者。这在实际制作网页的时候要特别注意。 `BFC`
3. 嵌套盒子之间的margin
这时子块的margin以父块的content为参考进行排列,说白了，所有的元素都把父元素的content作为参照物
4. margin设为负值
会使设为负数的块向相反的方向移动，甚至会覆盖在另外的块上。

"定位规则"
CSS position 属性值：
absolute：生成绝对定位的元素，相对于 static 定位以外的第一个父元素进行定位。元素的位置通过 "left", "top", "right" 以及 "bottom" 属性进行规定。`会脱离文档流`
relative：生成相对定位的元素，相对于其正常位置进行定位。因此，"left:20" 会向元素的 LEFT 位置添加 20 像素。元素的位置通过 "left", "top", "right" 以及 "bottom" 属性进行规定。
fixed：生成绝对定位的元素，相对于浏览器窗口进行定位。`会脱离文档流，以window作为参照物`
static：默认值。没有定位，元素出现在正常的流中（忽略 top, bottom, left, right 或者 z-index 声明）。
inherit：规定应该从父元素继承 position 属性的值。
sticky: ----
最常用的的就是 absolute 和 relative 两种方式

float(浮动)
# 浮动会将元素从文档流中删除,俗称脱离文档流，原空间被其它元素补上。左浮动元素尽量靠左、靠上，右浮动同理；
# 浮动的参数物是父元素，是在父元素这个容器中飘。同margin，参照物也是父元素的content。会脱离文档流
# 为了清除浮动造成的对浮动元素之后元素的影响，我们在浮动元素之后加一个div，并将这个div的clear设置为both。
# 如果两个元素都设置了浮动，则两个元素并不会重叠，第一个元素占据一定空间，第二个元素紧跟其后。如果不想让第二个元素紧跟其后，可以对第二个浮动的元素使用clear。
# 清除浮动的方法
	- 父级内部使用一个专门清除浮动的标签并设置其为clear:both；
	- 父元素使用伪元素进行清除，不过要注意伪元素的display和content设置
	- 父元素使用overflow:hidden;
	- 子元素使用高度撑开(注意，这是规避方案，根本上没有清除浮动，实际上父元素的高度还是Zero)

彩蛋:雪碧图实现原理 --- background-position

2019年9月21日：阅读完，可以从侧面了解BFC和IFC，block element 在排版上是从上到下，而margin对盒子之间的影响主要是top和bottom，当相邻的两个block element设置了重复的margin，那么会优先使用margin值大的
而inline element在排版上是从左往右，所以其margin奏效的只有left和right，当相邻的inline elment的margin重叠了，会累加
```



#### 水平垂直居中的方案、可以实现`6`种以上并对比它们的优缺点

```css
"方案一"
father {
    display: flex;
    align-items: center;
    justify-content: center;
}

"方案二"
father {
    position: relative;
}
son {
    position: absolute;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
}

"方案三"
son {
    line-height: **;
    text-align: center;
}

"方案四"
father {
    text-align: center;
}
son {
    line-height: *
}

```



#### 【input的宽度】💗并不是给元素设置display:block就会自动填充父元素宽度。input 就是个例外，其默认宽度取决于size特性的值,如果要其填充满父元素，还要加上width:100%

#### 绝对定位和固定定位时，同时设置 left 和 right 等同于隐式地设置宽度

#### 相邻兄弟选择器之常用场景 ul>li + li 这样可以避免第一个li应用到对应的样式

#### 要使模态框背景透明，用rgba是一种简单方式 ，父级元素的opacity会影响子代元素，所以一般modal和mask是没有血缘关系

#### 【定宽高比】♥css实现定宽高比的原理：padding的百分比是相对于其包含块的宽度，而不是高度 

#### IE11下的flex: space-evenly 会有兼容性问题，最好使用space-around或者space-between

### **CSS**

- 6.`BFC`实现原理，可以解决的问题，如何创建`BFC`
- 7.可使用`CSS`函数复用代码，实现特殊效果
- 8.`PostCSS`、`Sass`、`Less`的异同，以及使用配置，至少掌握一种
- 9.`CSS`模块化方案、如何配置按需加载、如何防止`CSS`阻塞渲染
- 10.熟练使用`CSS`实现常见动画，如渐变、移动、旋转、缩放等等
- 11.`CSS`浏览器兼容性写法，了解不同`API`在不同浏览器下的兼容性情况
- 12.掌握一套完整的响应式布局方案

### **手写**

- 1.手写图片瀑布流效果
- 2.使用`CSS`绘制几何图形（圆形、三角形、扇形、菱形等）
- 3.使用纯`CSS`实现曲线运动（贝塞尔曲线）
- 4.实现常用布局（三栏、圣
