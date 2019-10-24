## 如何引用JavaScript
* 内部引用
```javascript
    <script type="text/javascript">
      document.write("Hello World!");
    </script>
  ```
* 外部引用
```javascript
    <script type="text/javascript" src="./main.js"></script>
```
---
## 创建变量
* 方式一
```javascript
    var name = 'Bob';
    var age = 16;
    var stuNo = 0012323;
```
* 方式二
```javascript
    var name = 'Bob',
        age = 16,
        stuNo = 0012323;
```
---
## 数据类型
JavaScript是一种 *弱类型* 或者说 *动态语言*  
### 1. 原始类型
    1. Boolean（布尔类型）：包括true和false
    2. Null类型：null，表示空值
    3. Undefined类型：Undefined，表示未定义或未赋值
    4. Number(数字类型)：除了数字还包括 **+Infinity**（正无穷），**-Infinity**（负无穷）和 **NaN**（非数字）
    5. String（字符串类型）：用 **""**（双引号）或 **''**（单引号）包起来

### 2. 对象类型：Object
  1. 使用构造函数创建对象
```javascript
      var o = new Object();
```
  2. 直接创建对象
  ```javascript
      var person = {
          name: 'Bob',
          age: 20,
          gender: 'male'
      };
```

### 3. typeof 操作符
对一个值使用typeof操作符可能返回下列某个字符串：
  * 'undefined' —— 未定义
  * 'boolean' —— 布尔值
  * 'string' —— 字符串
  * 'number' —— 数字值
  * 'object' —— 对象或null
  * 'function' —— 函数

使用 `typeof` 的示例：
```javascript
var message = 'some string';
alert(typeof message); // "string"
alert(typeof(message)); // "string"
alert(typeof 95); // number
```

|类型                       |结果       |
|:--------------------------|:----------|
|数字，Number，NaN，Infinity |'number'   |
|布尔，Boolean               |'boolean'  |
|字符串，String              |'string'   |
|方法，Function              |'function' |
|Symbol                     |'symbol'   |
|undefined                  |'undefined'|
|null                       |'object'   |
|其他                       |'object'   |

### 4. instanceof 操作符
> `instanceof` 运算符用于检测构造函数的 prototype 属性是否出现在某个实例对象的原型链上。

该操作符并不是简单判断函数的 `prototype` 属性对象是否在对象的原型链上，而要求要使用 `Object.create` 或构造方法；使用字面量创建的基本数据类型的对象，并不算其包装类型的实例，因为不是用构造方法创建的

```javascript
let primitiveStr = 'I am string'
Object.getPrototypeOf(primitiveStr) === String.prototype //true
primitiveStr instanceof String  //false
primitiveStr instanceof Object  //false

let objStr = new String('I am string')
objStr instanceof String  //true
objStr instanceof Object  //true

let obj = {}
obj instanceof Object  //true
let noPrototype = Object.create(null)
noPrototype instanceof Object  // false

let sp = Object.create(String.prototype)
sp instanceof String  // true
```

---
## 运算符
* 算数运算符
  * 加：+
  * 减：-
  * 乘：*
  * 除：/
  * 取模：%
  * 自增：++，右结合
  * 自减：--，右结合
* 赋值：=
* 算数运算与赋值结合
  * 加等于：+=
  * 减等于：-=
  * 乘等于：\*=
  * 除等于：/=
  * 取模等于：%=
* 关系运算符
  * 等于：==（只比较值，不比较类型）、===（严格等于）
  * 大于或大于等于：>、>=
  * 小于或小于等于：<、<=
* 逻辑运算符
  * 逻辑与运算符：&&
  语法: 运算结果 = 表达式1 && 表达式2
  只有两个表达式同为true，结果才能为true
  * 逻辑或运算符：||
  语法: 运算结果 = 表达式1 || 表达式2
  只有两个表达式只要有一个为true，结果就是true
  * 逻辑非运算符：!
  语法: 运算结果 = !表达式
  把true变成false，false变成true
* 非boolean类型转boolean类型
  * 转为false：null , NaN , 0 , 空字符串("") , undefined
  * 转为true：除以上的所有

## 条件分支
----
* if语句
  ```javascript
    if (condition){
      // 当 condition==true 时执行的语句块
    }
  ```
* if-else语句
  ```javascript
    if (condition){
      // 当 condition==true 时执行的语句块1
    } else {
      // 当 condition==false 时执行的语句块2
    }
  ```
* if-else if-else语句
  ```javascript
    if (condition1){
      // 当 condition1==true 时执行的语句块1
    } else if (condition2){
      // 当 condition2==true 时执行的语句块2
    } else {
      // 当 condition1==false && condition2==false 时执行的语句块3
    }
  ```
* switch语句
```javascript
switch(n){
    case n1:
    //执行代码块 1
    break;
    case n2:
    //执行代码块 2
    break;
    default:
    //与 case n1 和 case n2 不同时执行的代码块3
}
```

--------
## 循环遍历
#### 1. for
```javascript
for ([initialization]; [condition]; [final-expression])
   [statement]
```
- `initialization` : 初始化条件语句，可以声明变量
- `condition` : 是否继续执行循环体的条件，会将表达式结果转化为布尔值；`true` 则继续执行循环；缺省则默认为 `true`
- `final-expression` : 每次循环体执行结束后的后置操作
- `statement` : 循环体语句块

以上四个部分均可以省略

#### 2. for...in
> 以任意顺序遍历一个对象的除 `Symbol` 以外的可枚举属性，包括从原型链上继承的可枚举属性

```javascript
for (variable in object)
  statement
```

- `variable` : 为属性名或索引
- `object` : 为要进行遍历的对象或数组

`for...in` 不能保证遍历的属性或者索引的顺序，因此对数组进行遍历时不一定按索引顺序来，在遍历的同时对对象或数组添加或删除属性(元素)也不能保证属性一定会被遍历到；使用 `Array.prototype.forEach()` 或 `for...of` 则能保证顺序

通常 `for...in` 会和 `hasOwnProperty()` 配合使用，过滤对象自身的属性

#### 3. for...of
> 对可迭代对象（包括 `Array`，`Map`，`Set`，`String`，`TypedArray`，`NodeList`，`arguments` 对象等等）中的元素进行迭代遍历

```javascript
for (variable of iterable)
    statements
```

`for...of` 只能遍历可迭代对象，实现 `[Symbol.iterator]` 属性的对象，普通的 `Object` 无法使用；且它只遍历对象定义的迭代值，而不是属性

#### 4. do...while

#### 5. while...


## 变量声明(var,let,const)
#### 0.
可以不使用 `var`、`let`、`const` 任何一个，直接像python一样声明变量，此时该变量为全局变量

#### 1. var
1. `var` 为方法作用域，并且可作用于子作用域，不能作用于兄弟作用于和父作用域
2. 在上级作用域定义的变量，子作用域可以直接读取并修改
3. 当父子作用域同时定义了同名的变量时，子作用域的变量将独立于父作用域的变量，它(子)的变化不会影响父作用域中的变量，不管该变量是在修改前定义还是修改后定义
4. 当父子作用域同时定义了同名的变量时，则在子作用域声明变量前该变量都被认为是未定义
5. `var` 声明的变量会成为所在作用域(`this`)的属性
6. `var` 定义的变量会在上下文的开始就执行，优先于其他语句，但是赋值语句则要在具体赋值的地方才能执行
7. 可以在任何位置重复声明同一变量

#### 2. let
1. `let` 声明的变量只在其声明的 **块** 或 **子块** 中可用，这一点，与 `var` 相似，但 `var` 声明的变量的作用域是 **整个封闭函数**
2. `let` 声明的变量不会为所在作用域(`this`)添加属性
3. `let` 声明的变量在具体声明的地方执行，不会提前
4. 只有在代码块(函数)中，才能重复声明同名变量，父子作用域也可以声明同名变量
5. `let` 声明的变量在子作用域中也可以被检测到，这与 `var` 相似

#### 3. const
与 `let` 相似，但是所定义的变量无法重新赋值，且声明语句与定义语句必须同时执行

同一作用域中，同一变量无法用 `var`、`let`、`const` 不同关键字重复声明


## 判断一个对象是否为空对象
无法使用 obj === {} 进行判断，对象是引用类型，是根据地址判断的
1. `JSON.stringify(obj) === "{}"`
2. `Object.keys(obj) === 0`

## 正则表达式
在JS中正则表达式是一种对象，不是字符串，所以使用时不加引号，而是用斜杠(/)表示，如：
```javascript
const regx = /\.js$/;
```

## 集合操作
#### Array.from(obj, fn = (o) => o )
相当于 `obj.map(o => fn(o))`

#### Array.prototype.slice(begin = 0, end = this.length)
左闭右开的集合截取

#### Array.prototype.reverse()
集合元素顺序反转


## RegExp (正则表达式)
`RegExp` 是JavaScript中正则表达式的构造方法，也有一种使用双反斜杠(`\\`)包含起来的语法糖写法，因此，正则表达式在JavaScript中是对象的数据类型
```javascript
let regex1 = /\w+/;
let regex2 = new RegExp('\\w+');
console.log(regex1 === regex2); //output: false
```

### 创建方式：
1. `/pattern/flags`
2. `new RegExp("pattern" [, "flags"])` 或 `new RegExp(/pattern/ [, "flags"])`

参数：
1. `pattern`: 正则表达式文本
2. `flags`: 可以由以下值的任意组合
    - `g`: 全局匹配，找到所有匹配，而不是在第一个匹配后停止
    - `i`: 忽略大小写
    - `m`: 启动多行，将开始和结束字符（`^`和`$`）视为在多行上工作
    - `u`: Unicode，将模式视为Unicode序列点的序列
    - `y`: 粘性匹配，仅匹配目标字符串中此正则表达式的lastIndex属性指示的索引，并且不尝试从任何后续的索引匹配

当使用构造函数创造正则对象时，需要常规的字符转义规则，即 `\w` 等匹配符要写成 `\\w`，而使用 `//` 语法糖的就不用

### 正则表达式属性
> `RegExp` 对象的几个属性既有完整的长属性名，也有对应的类 Perl 的短属性名。两个属性都有着同样的值。JavaScript 的正则语法就是基于 Perl 的

- `RegExp.prototype.constructor`  
创建该正则对象的构造函数
- `RegExp.prototype.global`  
是否开启全局匹配，也就是匹配目标字符串中所有可能的匹配项，而不是只进行第一次匹配
- `RegExp.prototype.ignoreCase`  
在匹配字符串时是否要忽略字符的大小写
- `RegExp.prototype.lastIndex`  
下次匹配开始的字符串索引位置
- `RegExp.prototype.multiline`  
是否开启多行模式匹配（影响 `^` 和 `$` 的行为）
- `RegExp.prototype.source`  
正则对象的源模式文本
- `RegExp.prototype.sticky `  
是否开启粘滞匹配

### 正则表达式方法
- `RegExp.prototype.exec()`    
在目标字符串中执行一次正则匹配操作
- `RegExp.prototype.test()`  
测试当前正则是否能匹配目标字符串
- `RegExp.prototype.toSource()`  
返回一个字符串，其值为该正则对象的字面量形式,覆盖了 `Object.prototype.toSource()` 方法
- `RegExp.prototype.toString()`  
返回一个字符串，其值为该正则对象的字面量形式,覆盖了 `Object.prototype.toString()` 方法

### 匹配的使用
1. string.match(regex)
使用字符串的 `match` 方法，参数为以一个正则表达式，返回字符串中匹配中的子串的数组.

若不是全局匹配，返回的数组会包括分组的子串和相关的其他信息，若是全局匹配，则返回匹配的字符串数组
```javascript
let str = "aa bb cc dd ee hh"
let regex = /(\w+) (\w+)/
str.match(regex)
// return ["aa bb", "aa", "bb", index: 0, input: "aa bb cc dd ee hh", groups: undefined];

regex = /(\w+) (\w+)/g
str.match(regex)
// return ["aa bb", "cc dd", "ee hh"];
```

2. regex.exce(string)
使用正则表达式对一个字符串进行一次匹配，返回一次匹配的结果字符串的 **数组**，包括分组分组字符串和其他相关信息(返回的数组将完全匹配成功的文本作为第一项，将正则括号里匹配成功的作为数组填充到后面)，并更新正则表达式对象的属性

如果匹配失败，返回 `null`

`lastIndex` 属性会记录当前匹配中的子串的最后一个字符的索引，若设置全局匹配，则下一次匹配会从 `lastIndex` 之后的字符开始匹配，不论是否更换匹配的字符串
```javascript
let myRe = /ab*/g;
let str = 'abbcdefabh';
let myArray;
while ((myArray = myRe.exec(str)) !== null) {
  let msg = 'Found ' + myArray[0] + '. ';
  msg += 'Next match starts at ' + myRe.lastIndex;
  console.log(msg);
}
/*
output：
Found abb. Next match starts at 3
Found ab. Next match starts at 9
*/
```

3. regex.test(string)
检测字符串中是否有匹配的子串，返回 `true` 或 `false`

如果正则表达式设置了全局标志，`test()` 的执行会改变正则表达式   `lastIndex` 属性。连续的执行`test()`方法，后续的执行将会从 `lastIndex` 处开始匹配字符串，(`exec()` 同样改变正则本身的 `lastIndex` 属性值).
```JavaScript
let str = 'hello world!';
let result = /^hello/.test(str); // true

let regex = /foo/g;
// regex.lastIndex is at 0
regex.test('foo'); // true
// regex.lastIndex is now at 3
regex.test('foo'); // false
```

### 获取分组值
使用正则表达式匹配后，使用 `$n` 的形式获取分组匹配到的值， 其中n为分组的序号，从1开始
```javascript
let re = /(\w+)\s(\w+)/;
let str = "John Smith";
let newstr = str.replace(re, "$2, $1");
console.log(newstr); //output: "Smith, John"
```
`````



nf-mdi-music_note_quarter
