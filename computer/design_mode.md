- [EventEmitter](#事件分发)
- [单例模式](#单例模式)
- [观察者模式](#观察者模式)



#### 设计模式

> 一些经过验证，对某种场景具有最佳实践的设计，一般代码效益被认为是最优解，一般会处理三种情景。
>
> - 创造型设计模式，负责解决某种场景下对对象创建的要求，常见的有构造器模式，工厂模式、抽象工厂模式、原型模式以及建造者模式
> - 结构设计模式，有助于在系统的某一部分发生改变，整个系统不需要改变，该某事有助于对系统中某部分没有达到某一目的的部分进行重组，长江的有：装饰模式、外观模式、享元模式，适配器模式何代理模式。
> - 行为设计模式，关注改善或精简在系统中不同对象间通信，常见有迭代模式，中介者模式、观察者模式和访问者模式



#### 事件分发

```javascript
# es6实现方式
class EventEmitter {
    constructcor () {
        this.emitter = Object.create(null);
    }
    
    on (eventName, callback) {
        if (!this.emitter[eventName]) {
            this.emitter[eventName] = [];
        }
        this.emitter[eventName].push(callback);
    }
    
    emit (eventName, ...resetParameter) {
        if (!this.emitter[eventName]) {
            console.log(`Event ${eventName} is no exist!`);
            return;
        }
        
       	this.emitter[eventName].forEach(EventCallback => {
            if (typeof EventCallback === 'function') {
                EventCallback(...resetParameter)
            }
        })
    }
}

# es5实现方式
function EventEmitter () {
    this.emitter = Object.create(null);
    this.on = function (eventName, callback) {
        if (!this.emitter[eventName]) {
            this.emitter[eventName] = [];
        }
        this.emitter[eventName].push(callback);
    }
    
    this.emit = function (eventName) {
        var that = this;
        var arg = arguments;
        if (!this.emitter[eventName]) {
            console.log(eventName + ' is no exist!');
            return;
        }
        
        /**
        * 这里要注意slice的使用，需要使用到call对this定位
        **/
       	this.emitter[eventName].forEach(function (EventCallback) {
            if (typeof EventCallback === 'function') {
                EventCallback.apply(that, Array.prototype.slice.call(arg, 1));
            }
        })
    }
}

测试用例：
let ev = new EventEmitter();
ev.on('connect', (...arg) => console.log(arg));
ev.emit('connect', 1,2,3); // [1, 2, 3]

Summary：这里要思考一个问题，平时我们使用的on监听事件，使用emit分发事件，那么on和emit就是事件分发中重点实
现的函数，而且如果使用到es5以前的实现方式的话，就需要关注this指向问题、apply以及call使用问题
```



#### 单例模式

```javascript
class Singleton {
    static instance = null;
	constructor (options) {
        
    }

    static getInstnce () {
        if (!this.instance) {
            this.instance = new Singleton(opt);
        }
        return this.instance;
    }
}
```



#### 观察者模式

```javascript
# 被观察者维护一组观察者对象。当有新的信息到来的时候，被观察者通过广播的方式告诉已经在注册的观察者。

收益：保持对象之间的信息一致性，而且观察者随时可以脱离被观察只要它愿意，当然随时也可以接受被观察的广播的信息，只要它已经注册

所以，观察者需要实现两个接口：
 - 增加观察者接口
 - 删除观察者接口

被观察者需要实现一个接口
 - 用于更新数据的接口

class Subject {
    constructor () {
        this.observerList = new Map();
    }
    add (observer) {
        this.observerList.set(observer);
    }
    delete (observer) {
        this.observerList.delete(observer);
    }
    notify (...opt) {
        for (let [observer] of this.observerList) {
            observer.update && observer.update();
        }
    }
}
let oberser1 = {
    update (...opt) {
        // 这里处理oberser1的逻辑
    }
}
let oberser2 = {
    update (...opt) {
        // 这里处理oberser2的逻辑
    }
}

# 测试用例
let subject = new Subject();
subject.add(observer1);
subject.add(observer2);
subject.notify(111,2,3,4);
```

