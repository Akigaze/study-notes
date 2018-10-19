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

# 事件循环（Event Loop）

# 异步操作的模式
## 回调函数(callback)
## 事件监听
## 发布/订阅（publish-subscribe）
