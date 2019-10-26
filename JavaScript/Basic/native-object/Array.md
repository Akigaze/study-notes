# Array 数组

## Link
1. [JavaScript.info - Arrays](http://javascript.info/array)
2. [JavaScript.info - Array methods](http://javascript.info/array-methods)
2. [MDN - Array](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Array)


## 一、声明定义
> 数组(Array)用于存储有序的集合

**声明并初始化：**
```javascript
let arr1 = new Array();
let arr2 = [];
let fruits = ["apple", "orange", "pear"];
```

数组的索引从 **0** 开始，使用 `arr[index]` 的形式访问指定索引的元素，同时也能对指定索引添加元素或替换元素
```javascript
let fruits = ["Apple", "Orange", "Plum"];
//访问元素
fruits[0]; // Apple
fruits[2]; // Plum
//替换元素
fruits[2] = "Pear"
fruits[2]; // Pear
//添加元素
fruits[3] = "Kiwi"
fruits[3] // Kiwi
```

数组的元素可以是任何类型的数据，使用 `length` 属性可以数组中元素的总数，它是一个 **可修改** 但是 **不可枚举** 的属性:
```javascript
let fruits = ["Apple", ["Orange"], {name:"Plum"}];

fruits.length // 3
Object.getOwnPropertyDescriptor(fruits, "length") // {value: 3, writable: true, enumerable: false, configurable: false}
```

## 二、构造函数
```javascript
new Array(el1, el2,...eln);
new Array(size);
```

`Array` 接受多个参数，根据参数个数和类型不同，会采用不同的方式构建数组：
1. 一个参数且是数字字面量：此时 `Array` 会把数字参数作为数组的 `length` ，而不是元素；此时JS会为数组的每个元素分配空间，但是并不会创建索引
```javascript
let a1 = new Array(10) //等价于 let a1 = [,,,,,,,,,]
a1.length // 10
a1[0] // undefined
a1.hasOwnProperty(0) // false
a1.hasOwnProperty('length') // true
for(let i in a1){ console.log(i, a1[i]) }// undefined
for(let v of a1){ console.log(v) }// undefined x 18
```
2. 多个参数或参数不是数字字面量时：此时 `Array` 会将参数作为数组的元素，为元素分配索引和值
```javascript
let arr1 = new Array(5,2,4)
arr1 // [5, 2, 4]
let arr2 = new Array('5')
arr2 // ["5"]
let arr3 = new Array(new Number(5))
arr3 // [Number]
```
## 三、length属性
```javascript
let fruits = []
Object.getOwnPropertyDescriptor(fruits, "length") // {value: 0, writable: true, enumerable: false, configurable: false}
```
> 当我们修改数组的时候，`length` 属性会自动更新。准确来说，它实际上不是数组里元素的个数，而是最大的数字索引值。

数组的 `length` 属性是运行修改的，在修改的同时，也会影响数组中的元素：
1. 增大 `length` : JS会为新的元素分配空间，但是并不会分配索引和值
1. 减小 `length` : 相当于将数组从头截取指定长度的部分，剩余的部分直接丢弃

```javascript
let arr = ["apple", "orange", "lemon"]
arr.length // 3
arr.length = 5
arr // ["apple", "orange", "lemon", empty × 2]
arr[4] // undefined
arr.hasOwnProperty(4) // false
arr.length = 1
arr // ["apple"]
arr[1] // undefined
arr.length = 3
arr // ["apple", empty × 2]
```

## 四、元素添加删除
- `Array.prototype.push(element)` : 在数组的末尾添加元素，返回添加元素后的数组长度
- `Array.prototype.pop()` : 移除数组末尾的元素，返回被移除的元素
- `Array.prototype.shift()` : 移除数组最前面的元素，返回被移除的元素
- `Array.prototype.unshift(element)` : 在数组最前面添加元素，返回添加元素后的数组长度

```javascript
let fruits = ["apple", "orange", "lemon"]
fruits.push("pear") // 4
fruits // ["apple", "orange", "lemon", "pear"]
fruits.pop() // "pear"
fruits // ["apple", "orange", "lemon"]
fruits.shift() // "apple"
fruits // ["orange", "lemon"]
fruits.unshift("bananer") // 3
fruits // ["bananer", "orange", "lemon"]
```

`push` 和 `shift` 类似于队列的操作，先进先出，一端进另一端出  
`push` 和 `pop` 就类似于栈的操作，后进先出，只能在同一端进出

就性能而言，`push/pop` 方法运行的比较快，而 `shift/unshift` 比较慢，因为从头增减元素还需要调整后续元素的顺序

## 五、打印输出
数组的 `toString` 方法会将每个元素转成字符串，再使用逗号 `,` 连接成字符串
```javascript
let fruits = ["apple", "orange", "lemon"]
fruits.toString() // "apple,orange,lemon"
String(fruits) // "apple,orange,lemon"
```

## 六、数组对象方法
### 1. 修改数组
- `Array.prototype.push(element)`
- `Array.prototype.pop()`
- `Array.prototype.shift()`
- `Array.prototype.unshift(element)`

- `Array.prototype.splice(startIndex. deleteCount, ...elements)` :  
`splice` 能做到删除元素，替换元素和插入元素，会修改到原有数组；起运行顺序为 **删除元素-插入新元素-返回被删除的元素组成的数组**
    - `startIndex` : 指定修改的开始位置。如果超出了数组的长度，则从数组末尾开始添加内容；如果是负值，则表示从数组末位开始的第几位；如果负数的绝对值大于数组的长度，则表示开始位置为第0位。
    - `deleteCount` : 要删除的元素总数，缺省是表示要删除 `startIndex` 后的所有元素
    - `...elements` : 使用这些元素替换被删除部分的元素   

```javascript
let users = ["Jane", "Tom", "Lee", "Rose"]
users.splice(1,2) // ["Tom", "Lee"]
users // ["Jane", "Rose"]

users = ["Jane", "Tom", "Lee", "Rose"]
users.splice(2) // ["Lee", "Rose"]
users // ["Jane", "Tom"]

users = ["Jane", "Tom", "Lee", "Rose"]
users.splice(5, 2) // []
users // ["Jane", "Tom", "Lee", "Rose"]

users = ["Jane", "Tom", "Lee", "Rose"]
users.splice(-2,1) // ["Lee"]
users // ["Jane", "Tom", "Rose"]
users = ["Jane", "Tom", "Lee", "Rose"]

users.splice(-5,1) // ["Jane"]
users // ["Tom", "Lee", "Rose"]

users = ["Jane", "Tom", "Lee", "Rose"]
users.splice(1,2, "Mocha", "Jest") // ["Tom", "Lee"]
users // ["Jane", "Mocha", "Jest", "Rose"]

users = ["Jane", "Tom", "Lee", "Rose"]
users.splice(5,2, "Mocha", "Jest") // []
users // ["Jane", "Tom", "Lee", "Rose", "Mocha", "Jest"]
users = ["Jane", "Tom", "Lee", "Rose"]
users.splice(5,1, "Mocha", "Jest") // []
users // ["Jane", "Tom", "Lee", "Rose", "Mocha", "Jest"]

users = ["Jane", "Tom", "Lee", "Rose"]
users.splice() // []
users // ["Jane", "Tom", "Lee", "Rose"]
users.splice(undefined) // ["Jane", "Tom", "Lee", "Rose"]
users // []
```

- `Array.prototype.slice(start, end)` : 从元素的的索引范围 `[start, end)` **浅拷贝** 一份子数组；原始数组不会被改变。`slice` 的切片功能与 `splice` 的删除功能相似
```javascript
let fruits = ['Banana', 'Orange', 'Lemon', 'Apple', 'Mango'];
fruits.slice(1,3) // ["Orange", "Lemon"]
fruits // ["Banana", "Orange", "Lemon", "Apple", "Mango"]
fruits.slice(2) // ["Lemon", "Apple", "Mango"]
fruits.slice(-2) // ["Apple", "Mango"]
fruits.slice(2, 10) // ["Lemon", "Apple", "Mango"]
fruits.slice(10) // []
fruits.slice(-10) // ["Banana", "Orange", "Lemon", "Apple", "Mango"]
```

- `Array.prototype.concat(arg1, arg2...)` : 使用浅拷贝合并两个或多个数组。此方法不会更改现有数组，而是返回一个新数组。如果参数不是一个数组或者 `[Symbol.isConcatSpreadable]` 属性值不为 `true`，则直接添加参数本身为结果的元素
```javascript
let arr = ['q', 'k', 'h']
arr.concat(['a', 'b'], ['x', 'y']) // ["q", "k", "h", "a", "b", "x", "y"]
arr // ["q", "k", "h"]
arr.concat(['a', 'b'], 'bb', 'gg') // ["q", "k", "h", "a", "b", "bb", "gg"]
arr.concat(['a', ['s', 'i']], {go: true}) // ["q", "k", "h", "a", ['s', 'i'], {go: true}]
arr.concat() // ["q", "k", "h"]
```
- `Array.prototype.copyWithin(target, start, end])` : 浅复制数组的一部分替换同一数组中的另一个部分(等长)，并返回它，不会改变原数组的长度，但会改变数组内容
```javascript
let arr = ['a', 'x', 't', 's', 'g']
arr.copyWithin(0, 2, 4) // ["t", "s", "t", "s", "g"]
arr // ["t", "s", "t", "s", "g"]
arr = ['a', 'x', 't', 's', 'g']
arr.copyWithin(0, 1, 4) //  ["x", "t", "s", "s", "g"]
arr = ['a', 'x', 't', 's', 'g']
arr.copyWithin(10, 1, 4) // ["a", "x", "t", "s", "g"]
arr.copyWithin(4, 2, 4) // ["a", "x", "t", "s", "t"]
arr = ['a', 'x', 't', 's', 'g']
arr.copyWithin(0, 2) // ["t", "s", "g", "s", "g"]
```
    - `targer` : 要被替换掉的那部分元素的开始索引
    - `start` : 要拷贝的那部分元素的开始索引，包含在拷贝范围内
    - `end` : 要拷贝的那部分元素的结束索引，不包含在拷贝范围内

### 2. 元素查找
- `Array.prototype.indexOf(item, from)` : 从指定索引开始，向后(右)查找元素，返回第一个匹配的元素的索引，找不到则返回 **-1**；使用 `===` 进行匹配
- `Array.prototype.lastIndexOf(item, from)` : 与 `indexOf` 相似，只是是从索引开始向前(左)查找
- `Array.prototype.includes(item, from)` : 判断元素是否在数组中，返回 `true`/`false`，相当于 `indexOf(item, from) !== -1`；但是该方法可以判断 `NaN` ，而 `indexOf` 和 `lastIndexOf` 不能

### 3. 数组转换
- `Array.prototype.reverse()` : 将数组中元素的顺序颠倒，并返回该数组；该方法会改变原数组。
```javascript
let arr = [3,5,6]
let reversed = arr.reverse()
reversed // [6, 5, 3]
arr // [6, 5, 3]
reversed === arr // true
```
- `Array.prototype.join(separator)` : 将一个数组（或一个类数组对象）的所有元素(`toString`)使用指定连接符连接成一个字符串并返回这个字符串。对于 `null` 和 `undefined` 会自动转换成空字符串；`separator` 的默认值为逗号 `,`
```javascript
[1,4,56].join() //"1,4,56"
[1,4,56].join("+") // "1+4+56"
 [1,4,56].join("") //"1456"
[].join("+") // ""
[1,4,undefined].join("-") // "1-4-"
[1,4,false].join("-") // "1-4-false"
```

- `Array.prototype.fill(value, start, end)` : 用一个固定值填充(替换)一个数组中索引 `[start, end)` 范围内的全部元素；该方法并不会因为 `start` 或 `end` 的值大于数组长度就为数组添加新的元素；`value` 默认值为 `undefined`
```javascript
["a", "b"].fill("x", 1, 10) // ["a", "x"]
arr = new Array(3)
arr.fill("a") // ["a", "a", "a"]
arr // ["a", "a", "a"]
arr.fill("x", 1) // ["a", "x", "x"]
arr.fill("yy", 1, 2) // ["a", "yy", "x"]
arr = new Array(3)
arr.fill("yy", 1, 2) // [, "yy", ]
arr = new Array(3)
let man = {}
arr.fill(man) // [{}, {}, {}]
arr[0] === man // true
arr[1] === man // true
arr[2] === man // true
```
- `Array.prototype.flat(depth)` : 将嵌套数组扁平化，同时会消除空项，不会修改原有数组；`depth` 指定处理的嵌套深度，默认为 **1**
```javascript
[[2,4],5,[{},"x"]].flat() //[2, 4, 5, {}, "x"]
[[2,4],5,["a", ["x", "y"]]].flat() // [2, 4, 5, "a", Array(2)]
[[2,4],5,["a", ["x", "y"]]].flat(2) // [2, 4, 5, "a", "x", "y"]
let arr = new Array(3).fill([3,5], 1, 2)
arr // [empty, Array(2), empty]
arr.flat() // [3, 5]
arr // [empty, Array(2), empty]
```

- `Array.prototype.entries()` :
- `Array.prototype.keys()` :
- `Array.prototype.values()` :

### 4. 迭代
- `Array.prototype.forEach(fn, thisArg)` : 对数组的每个元素执行一次提供的函数
 - `fn` 为一个函数，会接收 `currentValue`、`index`、`array` 三个参数
    - `currentValue` : 当前迭代到的元素的值
    - `index` : 当前元素的索引
    - `array` ：当前正在迭代的数组对象
 - `thisArg` : 作为 `fn` 函数中 `this` 引用的对象
- `Array.prototype.map()` : 创建一个新数组，其结果是该数组中的每个元素都调用一个提供的函数后返回的结果，参数与 `forEach` 相同；该函数不会改变数组的长度，所以对于数组中的空元素，会直接保留返回
- `Array.prototype.filter(fn, thisArg)` : 创建一个新数组, 其包含所有调用指定函数后返回 `true` 元素；能取出数组中的空元素
- `Array.prototype.find(fn, thisArg)` : 返回第一个调用指定函数后返回 `true` 元素的值，否则返回 `undefined`；当找到满足条件的元素时，该函数会立马终止遍历
```javascript
[2,4,6,8,9].find(v => {console.log(v); return v > 5})
//log: 2 4 6
// return: 6
```
- `Array.prototype.findIndex(fn, thisArg)` : 与 `find` 相似，只是这个函数返回的是索引，没有满足条件的元素时返回 **-1**
- `Array.prototype.some(fn, thisArg)` : 判断数组中是否有满足给定添加的值，即执行给定函数返回 `true` 的元素；但数组为空或者只有空元素时，返回 `false`；当找到满足条件的元素时，该函数会立马终止遍历
- `Array.prototype.every(fn, thisArg)` :判断数组中是否所有元素都满足给定条件，即执行给定函数后所有元素都返回 `true`；但数组为空或者只有空元素时，返回 `true`；
- `Array.prototype.flatMap(fn, thisArg)` : 相当对 `map` 的结果使用 `flat`，只扁平化一层嵌套

- `Array.prototype.reduce(reducer, initialValue)` : 对每个元素执行一个由您提供的 **reducer** 函数(升序执行)，将其结果汇总为单个返回值；  
当指定 `initialValue` 时，迭代次数为数组的长度，不指定 `initialValue` 时；`previousValue` 的初始值为数组的第一个元素，相应的 `currentValue` 第一次迭代的值也会变成数组的第二个值，所以迭代次数为数组长度减一 ；  
执行顺序：`previousValue` 赋值，检查数组剩余元素，执行 `reducer` 函数
```javascript
[1, 2, 3, 4, 5].reduce((sum, current) => sum + current, 0) // 15
[1, 2, 3, 4, 5].reduce((sum, current) => sum + current) // 15
[].reduce((sum, current) => sum + current) // Error
[].reduce((sum, current) => sum + current, 0) // 0
[,,,1,2,3].reduce((sum, current) => {console.log("Y"); return sum + current}) // log: Y x 3 result: 6
```
 - `reducer` 为一个函数，会接收 `previousValue`、`currentValue`、`index`、`array` 四个参数
   - `previousValue` : 上一次迭代的返回值，初始值为 `initialValue` 参数值
   - `currentValue` : 当前迭代到的元素的值
   - `index` : 当前元素的索引
   - `array` ：当前正在迭代的数组对象
 - `initialValue` : `previousValue` 在第一次迭代时的初始值
- `Array.prototype.reduceRight()` : 与 `reduce` 相似，只是迭代的方向相反，从后往前

- `Array.prototype.sort(fn)` : 根据给定的排序规则为数组排序，返回排序后的数组，会修改原有数组；  
当不指定 `fn` 时，默认使用数字升序、Unicode 码升序等方式排序，并且会将元素转换成一致的类型在进行排序  
当 `fn` 返回值 **>0** 则 `v1 -> v2`；**<0** 则 `v2 -> v1`后；**===0** 则 `v1` `v2`顺序不变  
```javascript
[45,2,67,3,2].sort() // [2, 2, 3, 45, 67]
['S', 'a', 'A', '45', '('].sort() // ["(", "45", "A", "S", "a"]
[,null,45,undefined, 2,null,67,3,2].sort() // [2, 2, 3, 45, 67, null, null, undefined, empty]
['S', 'a', 3, true, 'A', null,, '45', '('].sort() // ["(", 3, "45", "A", "S", "a", null, true, empty]
```
 - `fn` 定义元素比较规则的函数，接受数组中任意两个元素作为参数，返回值会被转换成一个数字
    - v1
    - v2

> 没有办法中止或者跳出 `forEach`，`map`等 循环，除了抛出一个异常。`every`，`some`，`find`，`findIndex` 这些数组方法可以对数组元素判断，以便确定是否需要继续遍历

对于数组中的空元素，这些遍历函数会直接跳过这些元素，并不会对这部分元素调用函数


## 七、Array方法
- `Array.isArray(obj)` : 判断对象是否是一个数组Array，包括字面量或使用构造方法创建的对象
- `Array.of(...elements)` : 用于创建数组对象，将参数作为数组的元素创建数组，区别于 `new Array(size)`
- `Array.from(arrayLike, mapFn, thisArg)` : 从一个类似数组或可迭代对象创建一个新的，浅拷贝的数组元素；并可以传递一个转换函数(类似`map`) 对元素进行转换
```javascript
Array.from("hello") // ["h", "e", "l", "l", "o"]
Array.from("hello", v => v+"y") // ["hy", "ey", "ly", "ly", "oy"]
Array.from([3,2,5,6], v => v*2) // [6, 4, 10, 12]
```
    - `arrayLike` : 可以是数组，字符串等
    - `mapFn` : 类似于 `map` 函数的 `fn` 参数，对 `arrayLike` 的每个元素进行转换
    - `thisArg`
