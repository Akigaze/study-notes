# JavaScript this 的使用和理解

## Link
1. [阮一峰 - Javascript 的 this 用法](http://www.ruanyifeng.com/blog/2010/04/using_this_keyword_in_javascript.html)
2. [阮一峰 - JavaScript 的 this 原理](http://www.ruanyifeng.com/blog/2018/06/javascript-this.html)
3. [IBM - 深入浅出 JavaScript 中的 this](https://www.ibm.com/developerworks/cn/web/1207_wangqf_jsthis/)
4. [MDN - JavaScript this](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Operators/this)
5. [Yehuda Katz blog - Understanding JavaScript Function Invocation and "this"](https://yehudakatz.com/2011/08/11/understanding-javascript-function-invocation-and-this/)

## 1. 简单理解
1. `this` 指向调用其所在方法的对象，即方法所在的环境对象。`this.xxx` 的 **xxx** 就是在该对象所形成的作用域中都变量
2. `this` 只能在函数中使用，其使用有一下4中情形：  
    1. 全局函数变量的调用
    2. 对象方法的调用
    3. 函数做为构造方法的调用
    4. 使用函数的 `apply` 方法调用  
3. 使用 `var` `let` `const` 声明的变量在作用域上也有所不同，`var` 定义的变量是全局变量，而 `let` 和 `const` 只在各自的作用域起作用，且 *不会被自动绑定到任何对象上*

### 1.1 全局变量调用
在全局变量中，`this` 指向 `window` 对象，而 `var` 定义的变量都会被绑定到 `window` 对象上
```javascript
let owner = {
    foo: function() { console.log(this.bar) },
    bar: "I am foo Owner."
}
var bar = "I am Global."

let foo = owner.foo
let fuzzy = function() { console.log(this.bar);}

fuzzy()  //I am Global.
foo()  //I am Global.
```

`let` 或者 `const` 定义的变量都不会被自动绑定到任何对象上，因此即使是在全局环境中，`let` 或者 `const` 定义的变量也不是 `window` 变量的属性
```javascript
let owner = {
    foo: function() { console.log(this.bar) },
    bar: "I am foo Owner."
}
let bar = "I am Global."

let foo = owner.foo
let fuzzy = function() { console.log(this.bar) }

fuzzy()  //undefine
foo()  //undefine
```

在不使用 `this` 的情况下，js解释器会在上下文环境中找到最近的一个定义的同名变量
```javascript
let owner = {
    foo: function() {let bar = "..."; console.log(bar) },
    bar: "I am foo Owner."
}
let bar = "I am Global."

let foo = owner.foo
let fuzzy = function() { console.log(bar) }

fuzzy()  //I am Global.
foo()  //...
```

### 1.2 对象方法调用
当使用 `object.func()` 的形式调用方法时，方法中的 `this` 就指向该对象
```javascript
let apple = {
    color: "red",
    mature: function(){ console.log(`The apples are ripe and ${this.color}.`) }
}

color = "green"
apple.mature() // The apples are ripe and red.
```

在对象方法调用中，也可以通过 `this` 新增或修改对象的属性
```javascript
let worker = {
    age: 20,
    report: function(){
        this.age = 30
        this.name = 'Xiao Ming'
        console.log(`I am ${this.name}, ${this.age} years old.`);
    }
}

worker.report()  // I am Xiao Ming, 30 years old.
console.log(worker.age);  // 30
console.log(worker.name);  // Xiao Ming
```

### 1.3 函数做为构造方法调用
函数作为构造方法使用时，函数中的 `this` 就指定构造出来的对象，通过 `this` 访问和操作的都是该对象自己的属性
```javascript
let dog = function(){
    console.log(this.type);  // undefine
    this.type = 'Corgi'
    console.log(this.type);  // Corgi
}

var type = 'papillon'
let corgi = new dog()
console.log(corgi.type);  // Corgi
console.log(type);  // papillon
```

### 1.4 使用函数的 `apply` 方法调用
`Function` 对象的 `apply` 方法用于调用所属方法，第一个参数是调用函数的对象，第二个是函数调用所需的参数，函数会将第一个参数作为作用域，当不指定调用对象时，默认为 `window` 对象
```javascript
let book = {
    totalPages: 100,
    message: function(){console.log(`I have total ${this.totalPages} pages.`)}
}
var totalPages = 200
book.message.apply()  // I have total 200 pages.
book.message.apply(book)  // I have total 100 pages.
```
