### Content

- [provide & inject](#inject & provide)
- [$api][#$api]
- [setup](#setup)

> 一直困扰如何将component转换成html然后挂载到页面上，之前的思路一直是render函数进行渲染，方向出现错误，其实一开始就应该要考虑到createApp这个函数的作用。hhhh

#### inject & provide

**先来看一张官方的介绍图**

![](./img/components_provide.png)

> 在vue2里面，需要使用高阶组件的时候就需要使用到inject和provide，这样就可以不用一层一层往下面传属性了，但是这里存在一个弊端，那就是不能使用响应式，只能是一个固定的值，但是情况在vue3里面得到了改善

```typescript
// parent
import { provide, computed, ref, CoumputedRef } from 'vue';
const PROP = Symbol('testProp');
const PropMap = {
    age: CoumputedRef<number>;
    sex: 'male'| 'femle'
}

let count = ref(0);
provide<PropMap>(PROP, {
    age: computed(() => count.value),
    sex: 'male'
});
function add () {count.value++};

// son
import { inject, watch, computed } from 'vue';
let { age, sex } = inject<PropMap>(PROP, { age: computed(() => 0), sex: 'female' });
watch([age], ([ageNewValue], [ageOldValue]) => {
  console.log(ageNewValue, ageOldValue);   // 这里是响应式的
})
```



#### $api

> 想要在全局状态下使用import { login } from '$api'; 那么应该做哪些操作呢？

1. 在`vite.config.ts`里面设置别名

   ```typescript
   {
       resolve: {
           alias: {
               $api: path.join(process.cwd(), "src/api/index.ts")
           }
       }
   }
   其中 src/api/index.ts 是所有api的出口
   ex: 
   export { login, home, info }集合了三个模块，分别是login、home、和info的api接口，那么当我们需要在业务里面使用的使用，可以通过import { home } from '$api';
   ```

2. 那么上面第一步仅仅是让vite打包的时候认识了$api，那么你怎么告诉typescript也认识$api这个模块呢？

   ```typescript
   # 答案就是在d.ts文件里面声明该模块
   declare module "$api" {
       export * from 'src/api/index';
   }
   # 如何让其使得this（vue2）能识别呢？同样的是在d.ts文件里面声明、
   import * as Api from 'src/api/index';
   declare module "@vue/runtim-core" {
       interface ComponentCustomProperties {
           $api: typeof Api
       }
   }
   这样就可以在mounted钩子里使用this.$api.login.xxx啦
   ```

3.  怎样让vue3的`getCurrentInstance` ???



#### setup

```typescript
# emit 在setup中的使用
this.$emit('xxxEvent'， value) // vue2


// vue3
{
    emits: ["xxxEvent"], // 暴露给被调用组件，当其在组件输入@的时候展示在IDE上面的方法
    setup(props, {emit}) {
        emit('xxxEvent', value);
    }
}

# expose和props
如果想要在父组件里面使用子组件里面的属性和方法，就需要在子组件里面expose出来
{
    props: {
        otherProp: {
            type: number
        }
    },
    setup(props, {emit, expose}) {
        expose({
            attribute: 999
        });
        let tempProp = props.otherProp; // 这里使用了prop就需要在setup同级声明下props
    }
}
```



