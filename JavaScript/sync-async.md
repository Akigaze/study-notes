# Asynchronous 异步
JS是同步编程的语言,但同时也支持异步操作  
JS引擎执行JS代码是只要一个主线程,主线程只会按顺序执行代码  
JS引擎会把所谓的异步操作先存放到任务队列(task queue)中,等待主线程空闲时(主线程代码执行完毕),再取出任务队列中的异步操作进行执行  

## 示例1：
```javascript
setTimeout(() => {
    console.log("1. run asynchronous function")
}, 1000)
console.log("2. run synchronous")
```
结果：  
> 1. run synchronous  
> 2. run asynchronous function

## 示例2：
```javascript
setTimeout(() => {
    console.log("1. run asynchronous function")
}, 0)
console.log("2. run synchronous")
```
结果：
> 2. run synchronous  
> 1. run asynchronous function

由于每一种浏览器对于定时器(`setTimeout`, `setInterval`)都有一个最小等待时间(3~10ms),所以即使设置等待时间为0,也会有等待时间.

## 示例3：
```javascript
setTimeout(() => {
    console.log("1. run asynchronous function")
}, 0)
console.log("2. run synchronous")
while (true) { }
```
结果：
> 2. run synchronous  

由于`while`循环是一个死循环,所以主线程的执行永远不会结束,这样即使定时器的时间到了,到时因为主线程没有空闲执行异步操作,所以回调函数不会被执行.

## 示例4：
```javascript
setTimeout(() => {
    console.log("1. run timeout-1")
}, 6)
setTimeout(() => {
    console.log("2. run timeout-2")
}, 5)
for (let index = 0; index < 100000000; index++) { }
console.log("3. run synchronous")
```
结果：
> 3. run synchronous
> 2. run timeout-2
> 1. run timeout-1

在JS引擎的任务队列中,会按照任务达成执行条件的时间为异步任务安排执行顺序,先达到条件的优先执行,所以实例中第2个setTimeout的等待明显比第1个先结束,所以不论for循环的执行时间是否超过6ms,都是第2个setTimeout的任务先执行.

## 示例5：事件机制
```javascript
let btnList = [btn1, btn2, btn3]
for (var index = 1; index < btnList.length; index++) {
    btnList[index].onclick = () => {
        console.log(index)
    }
}
```

结果：
> no matter which button was clicked, the log is 3

因为JS的事件都是异步的,只有达到触发条件才会执行相应的事件函数,所以当按钮被点击时,for循环早已,执行结束,index的值已经变成了3.

---

# 回调地狱(callback hell)
## 示例1：

```javascript
ajax("url1", function(){
    B()
    ajax("url2", function(){
        C()
    })
    D()
})
```

# 事件循环(Event Loop)
只有`主线程`中的所有`同步任务`都执行完毕,系统才会读取任务队列,看看里面的`异步任务`哪些可以执行,然后那些对应的`异步任务`,结束等待状态,进入主线程,开始执行  
* 主线程：负责执行主要的JS代码,在空闲时会从消息队列中取出消息执行
* 工作线程：负责处理异步任务,待异步任务结束后,异步结果和回调函数封装成消息发送到消息队列

## 示例1：封装消息
```javascript
$.ajax('http://segmentfault.com', (response) => {
    console.log('我是响应：', response)
})

let message = () => {
    callbackFn(response)
}
```
![事件循环](pic\event-loop.png)

---
# 异步操作的模式
* 回调函数(callback)
* 事件监听
* 发布/订阅(publish-subscribe)
* Promise
* async/await

---
# Promise
## API
### Constructor
```javascript
new Promise(function(resolve, reject) { ... })
```
| Name  | Attributes | Description |
| :---- | :--------- | :---------- |
| function | necessary | async function |
| resolve | necessary | resolve signal function |
| reject | optional | reject signal function |

### object function
* Promise.all
* Promise.race
* Promise.reject
* Promise.resolve

### prototype function
* catch
* then

## Promise 的执行流程图
![Promise 的执行流程](pic\promises.png)

## Promise对象有三种状态：
* pending: 等待中,或者进行中,表示还没有得到结果
* resolved(Fulfilled): 已经完成,表示得到了我们想要的结果,可以继续往下执行
* rejected: 也表示得到结果,但是由于结果并非我们所愿,因此拒绝执行

`Promise` 创建时的参数函数的两个参数 `resolve` 和 `reject` 的作用就是要将 `Promise` 的状态修改为 `resolved` 或 `rejected` .

> new Promise((resolve,reject) => {})  

## .then
> promise.then(resolveFn, rejectFn)  // return Promise  

Promise 对象中的 `then` 方法,可以接收构造函数中处理的状态变化,并分别对应执行.  
`then` 方法有2个参数,第一个函数接收 resolved 状态的执行,第二个参数接收 rejected 状态的执行.  
**可以理解为：**  
1. 在 Promise 的参数函数中,若执行了 `resolve` ,则会发出一个 resolved 的信号,同时可以传递信号的参数.此时 `then` 的第1个参数函数就会接收到 resolved 信号和参数,就会被执行.
2. 对于 `then` 的第2个函数参数也是如此,只有接收到 `reject` 的信号和参数才会执行

`then`方法的执行结果也会返回一个Promise对象,因此我们可以进行 `then` 的链式执行;若 `then` 的 `resolve` 函数的返回值并不是一个 Promise 对或没有返回值,则 `then` 返回的 Promise 会立即立即执行回调 `resolve()`.  
`then`链式中的第二个 `then` 开始,它们的 `resolve` 中的参数,是前一个 `then` 中 `resolve` 的 `return` 语句的返回值.  

构造函数中的`resolve`和`reject`都是异步的函数，在使用构造方法创建Promise对象时，会直接执行构造方法中的函数，`resolve`和`reject`和其他一步操作都会被放入异步工作线程等待被执行；只有当主线程执行完毕，且有调用`then`为`resolve`和`reject`传递函数时，构造函数中的`resolve`和`reject`回调才会被真正执行。

在Promise对象前使用`await`关键字，该表达式会返回该Promise对象`resolve`的值，若该Promise对象一直没有`resolve`，则会保持pending状态直到timeout

### 示例1：
```javascript
let getPromise = (num) => {
    return new Promise((resolve, reject) => {
        typeof num == 'number' ? resolve() : reject()
    })
}
let excutePromise =(num) => {
    getPromise(num).then(() => {
            console.log('参数是一个number值')
        }, () => {
            console.log('参数不是一个number值')
        }
    )
}
excutePromise('hahha')
excutePromise(1234)
```

Promise 实例在生成后会立即执行,而 `then` 方法只有在所有同步任务执行完后才会执行
### 示例2：
```javascript
const promise = new Promise((resolve, reject) => {
  console.log('async task begins!') //1
  setTimeout(() => {
    resolve('done, pending -> resolved!') //6
  }, 1000)
})
console.log('new promise') //2
promise.then(value => {
  console.log(value) //7
})
console.log('1.please wait') //3
console.log('2.please wait') //4
console.log('3.please wait') //5
```
结果：
> async task begins!  
new promise  
1.please wait  
2.please wait  
3.please wait  
done, pending -> resolved!  

### 示例3：
不是异步的条件执行`resolve`
```javascript
const promise = new Promise((resolve, reject) => {
  console.log('async task begins!') //1
  resolve('done, pending -> resolved!') //2
})
console.log('new promise') //3
promise.then(value => {
  console.log(value) //5
})
console.log('1.please wait') //4
```

结果：
> async task begins!  
new promise  
1.please wait   
done, pending -> resolved!  

## .catch
用于捕获异常  
`catch(function() {})` 就相当于 `then(null, function() {})`

## Promise.all
`Promise.all` 接收一个 `Promise` 对象组成的数组作为参数,返回一个 `Promise` 对象.  
当这个数组所有的 Promise 对象状态都变成 `resolved` 或者 `rejected` 的时候,它才会去调用 `then` 方法.  
传递到 `then` 方法的参数是所有 `Promise` 信号参数组成的数组.  

### 示例3：  
```javascript
function renderAll() {
    return Promise.all([getPromise(url), getPromise(url1)])
}

renderAll().then((value) => {
    console.log(value)
})
```

## Promise.race
* 与 `Promise.all` 相似的是,`Promise.race` 都是以一个 `Promise` 对象组成的数组作为参数,不同的是,只要当数组中的其中一个 `Promsie` 状态变成 `resolved` 或 `rejected` 时,就可以调用 `.then` 方法了.  
* 传递给 `then` 方法的值也会有所不同.


## 更多教程
```javaScript
let promise = new Promise(function(resolve, reject) {
  // executor (生产者代码，"singer")
});
```

传递给 `new Promise`的函数称之为 **executor**。当 promise 被创建时，它会被自动调用。

promise 对象有内部属性：

- state —— 最初是 “pending”，然后被改为 “fulfilled” 或 “rejected”，
- result —— 一个任意值，最初是 undefined。

当 executor 完成任务时，应调用下列之一：

- resolve(value) —— 说明任务已经完成：
将 state 设置为 "fulfilled"，
sets result to value。
- reject(error) —— 表明有错误发生：
将 state 设置为 "rejected"，
将 result 设置为 error。

Promise 结果应该是 resolved 或 rejected 的状态被称为 `settled`

![](./pic/promise-resolve-reject.png)

Promise 的 `state` 和 `result` 属性是内部的。我们不能从代码中直接访问它们，但是我们可以使用 `.then/catch` 来访问

对于一个Promise对象，只能被resolve或者是reject一次，因此如果已经出现了resolve或者reject，则后面的所有resolve和reject都会被忽略

---
# async/await
* 只要在函数名之前加上`async`关键字,就表明这个函数内部有异步操作.  
* async函数返回一个`Promise`对象,如果函数的 return 不是Promise对象,也会返回一个Promise,而这个返回值,会成为 `then` 方法中回调函数的参数.
* 在 async函数返回的结果调用 then 时,只有当 async 函数完全执行结束才会执行then中的回调函数.    
* 在异步操作前面可以用`await`关键字标注,函数执行的时候,一旦遇到`await`,就会先执行`await`后面的表达式中的内容(异步),不再执行函数体后面的语句.  
* `await` 后面应该写一个Promise对象,如果不是Promise对象,那么会被转成一个立即 `resolve` 的Promise.  
* 等到异步操作执行完毕后,再自动返回到函数体内,继续执行函数体后面的语句.

### 示例1：
```javascript
async function asyncFn(){
    console.log(0)
    let num = await 1  // 相当于耗时的请求
    console.log(1)
    // 相当于异步请求的回调
}
asyncFn()
console.log(2)
```
结果：
> 0  
2  
1

## async与Generator(ES6)
* async 函数就是 Generator 函数的语法糖,是对 Generator 函数的改进  .
* `yield` 命令后面只能是 `Thunk` 函数或 `Promise` 对象,而 `async` 函数的 `await` 命令后面,可以跟 `Promise` 对象和原始类型的值(数值、字符串和布尔值,但这时等同于同步操作).

## Generator的编程方式
### 示例2：generator 编程
```javascript
let readFile = (fileName) => {
  return new Promise((resolve, reject) => {
    fs.readFile(fileName, (error, data) => {
      if (error) reject(error)
      resolve(data)
    })
  })
}
// generator函数
let gen = function* (){
  let f1 = yield readFile('/etc/fstab')
  let f2 = yield readFile('/etc/shells')
  console.log(f1.toString())
  console.log(f2.toString())
}
// 执行
let runReadFiles = gen()
runReadFiles.next()
runReadFiles.next()
```
## async的编程方式
###示例3： async 编程:
```javascript
let asyncReadFile = async () => {
  let f1 = await readFile('/etc/fstab')
  let f2 = await readFile('/etc/shells')
  console.log(f1.toString())
  console.log(f2.toString())
};
// 执行
let result = asyncReadFile()
```

---
# Link
### SegmentFault
JavaScript：彻底理解同步、异步和事件循环(Event Loop)
https://segmentfault.com/a/1190000004322358    
JS 异步(callback→Promise→async/await)  
https://segmentfault.com/a/1190000013141641
### 阮一峰：
Javascript异步编程的4种方法
http://www.ruanyifeng.com/blog/2012/12/asynchronous%EF%BC%BFjavascript.html  
异步操作概述  
http://javascript.ruanyifeng.com/advanced/single-thread.html  
async 函数的含义和用法  
http://www.ruanyifeng.com/blog/2015/05/async.html  
理解async/await  
https://segmentfault.com/a/1190000015488033  
### 简书  
前端基础进阶(十三)：透彻掌握Promise的使用,读这篇就够了  
https://www.jianshu.com/p/fe5f173276bd
### MDN
Promise  
https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Promise  
### Microsoft
Promise 对象 (JavaScript)  
https://msdn.microsoft.com/zh-cn/library/dn802826.aspx
### 现代 Javascript 教程
Promises, async/await  
https://zh.javascript.info/promise-basics  
