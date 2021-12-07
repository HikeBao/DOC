> 小总结： 在`echart`图标库中，除了对一些关键点，`setOption`的设置和`registerMap`、`resize`外，很大部分都是对一些样式位置的改动，当获取数据的时候的改动，比较有意思的就是在一些地方(要在`nextTick`里面对地图宽高进行设置),也就是需要考虑地图描绘的时机
>
> 有事没事上官网的常见问题看看，学习一下别人踩过的坑。`https://www.echartsjs.com/faq.html`
>
> 还可以上一下版本记录，观摩产品进化过程`https://echarts.baidu.com/changelog.html`
>
> 参考一下:`https://gallery.echartsjs.com/explore.html#sort=rank~timeframe=all~author=all`

> Echarts: 组件、图类、接口、基础库

### 组件

-  Axis：坐标轴
-  Grid：网格
-  Polar：极坐标  - 
-  Title：标题 
-  Tooltip：提示
-  Legend：图例
-  DataZoom：数据区域缩放 -
-  DataRange：值域漫游 -
-  Toolbox：工具箱 -
-  Timeline：时间轴

### 图类

- Bar：柱状图
- Line：折线图
- Scatte：散点图
- K：K线图
- Pie：饼图
- Rader：雷达图
- Chord：和玄图
- Force：力导布局图
- Map：地图
- Gauge：仪表盘
- Funnel：漏斗图

#### 多级控制设计

简单的说，你可以通过这三级满足不同level的定制和个性化需求：

- 通过 option.* 设置全局统一配置；
- 通过 option.series.* 设置特定系列特殊配置，其优先级高于 option 内的同名配置；
- 通过 option.series.data.* 设置特定数据项的特殊配置，最高优先级



#### mapData:https://code.highcharts.com.cn



