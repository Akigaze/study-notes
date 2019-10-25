## call/apply/bind
### 1. Function.prototype.call(obj, ...args)
强制执行一个函数，将 `obj` 参数作为函数中的 `this` 引用，`...args` 部分为调用函数所需的参数

当 `obj` 指定为 `null` 或 `undefined` 时会自动替换为指向全局对象(`window`)

### 2. Function.prototype.apply(obj, [...args])
强制执行一个函数，将 `obj` 参数作为函数中的 `this` 引用，`[...args]` 部分为调用函数所需的参数，它会将列表中的元素按顺序作为函数的形参

**\*** `call` 与 `apply` 的作用基本相同，只是传递函数参数的方式不同

### 3. Function.prototype.bind(obj, ...args)
绑定函数调用时 `this` 所引用的对象 `obj` ，返回绑定后原函数的拷贝，不改变原有函数；

但是如果 `this` 绑定的是一个引用类型，在绑定之后改变对象属性，对函数的 `this` 也是有影响的

`...args` 是预先设置好的参数，在真正执行函数时，这部分参数会自动添加但实际调用的参数前面



## function函数
#### 1.声明定义函数
函数声明:
```javascript
// function functionName(params) { statement }
function sayHi() {
  alert( "Hello" );
}
```

函数表达式
```javascript
// var/let/const functionName = function(params) { statement }
let sayHi = function() {
  alert( "Hello" );
};
// 函数表达式的末尾会有一个;，是因为这是一个赋值语句 let x = ...;
```

- 函数声明的方式定义的函数，对整个作用域可见，即会优先创建函数
- 函数表达式的方式定义函数，只有在运行到定义的那一行代码时，才创建函数




## 箭头函数(Arrow Function)
> **箭头函数** 的语法比 **普通函数** 更简洁，并且没有自己的 `this`，`arguments`，`super` 或 `new.target`，这些函数表达式更适用于那些本来需要匿名函数的地方，并且它们 **不能用作构造函数**

```javascript
(param1, param2, …, paramN) => { statements }
// 不加花括号时表达式的结果默认作为返回值
(param1, param2, …, paramN) => expression // equivalent to: => { return expression; }
// 只有一个参数时可以省略括号
singleParam => { statements } // equivalent to: (singleParam) => { statements }
// 没有参数时不能省略括号
() => { statements }
```

普通函数参数列表适用的 **默认参数**，**剩余参数**，**解构** 等在箭头函数中也适用

**特点：**
- 更简短的函数并且不绑定 `this`，箭头函数不会创建自己的 `this`，它只会从定义时的上一层作用域(函数作用域/全局)继承 `this`
- 由于箭头函数没有自己的 `this` 指针，通过 `call`、`apply` 或 `bind` 方法调用一个箭头函数时，只能传递参数，作为调用对象的第一个参数会被忽略
- 箭头函数不绑定 `Arguments` 对象，`arguments` 只能使用上一级函数的 `arguments`，或者为 `undefined`；箭头函数更多的还是使用 **剩余参数**
- 箭头函数不能用作构造器，和 `new` 一起用会抛出错误
- 箭头函数没有 `prototype` 属性
-  `yield` 关键字通常不能在箭头函数中使用（除非是嵌套在允许使用的函数内）。因此，箭头函数不能用作 **生成器**。

**注意：**
1. `params => {key:value}` 这种简单的语法返回对象字面量是行不通的，因为 `{}` 会被认为是一个语句块，而不是对象；直接返回对象字面量时需要添加括号 `params => ({key: value})`
2. 箭头函数在参数和箭头之间不能换行
