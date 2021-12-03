#### Map 产生的原因？

```javascript
普通对象的属性命必须是字符串，对于引用类型的键值是不允许的，`Map`却可以。
```



#### 数组去重

```javascript
const set = new Set([1,2,3,4,1]); 
tips：返回值是一个Set类型的{1,2,3,4}，一个类数组，可以通过Array.from或者[...target]转化为数组
```

