# Set

## 一、定义声明
`Set` 是一个值的集合，这个集合中所有的值仅出现一次。

## 二、构造方法
```javascript
new Set(iterable);
```
将可迭代对象的元素加入到 `Set` 对象中，同时去除重复的元素，使用 `===` 判断元素是否重复，多个 `NaN` 也被视为相同的值
```javascript
let user = {name: "Jone"}
let set = new Set([1,"a",4,user,6,4,NaN, user,"a"])
set // Set(6) {1, "a", 4, {name: "Jone"}, 6, NaN}
```

若作为参数的可迭代对象存在空元素，`Set` 会将空元素转换成 `undefined`
```javascript
let set = new Set([1,1,,,3,4,,3])
set // Set(4) {1, undefined, 3, 4}
```

## 三、Set迭代
使用 `for..of`、`forEach` 等遍历 `Set` ，按照元素添加的顺序进行遍历

## 四、属性
- `Set.prototype.size` : 记录元素的个数
- `[Symbol.iterator]` : `Set` 是可迭代的数据类型，因此支持 `for...of`、`...` 展开等操作
```javascript
let set = new Set([1,1,3,4,3])
for(let v of set){console.log(v)}
// log: 1 undefined 3 4
let arr = [...set]
arr // [1, undefined, 3, 4]
```

## 五、方法
#### 1. Set.prototype.add(element)
向一个 `Set` 对象的末尾添加一个指定的值，如果添加的值已经存在，则不会对 `Set` 进行任何操作；返回添加元素后的 `Set` 对象本身，因此支持链式操作
```javascript
let set = new Set([1,4,6])
set.add(8) // Set(4) {1, 4, 6, 8}
set.add(8) // Set(4) {1, 4, 6, 8}
set // Set(4) {1, 4, 6, 8}
```
#### 2. Set.prototype.delete(element)
从一个 `Set` 对象中删除指定的元素，删除成功返回 `true`，删除失败或元素不存在返回 `false`
```javascript
let set = new Set([1,4,6])
set.delete(8) // false
set.delete(6) // true
set // Set(2) {1, 4}
```
#### 3. Set.prototype.clear()
清空一个 `Set` 对象中的所有元素

#### 4. Set.prototype.has(element)
判断一个元素是否在 `Set` 中
```javascript
let set = new Set([1,4,6])
set.has(1) // true
set.has(0) // false
set.has(undefined) // false
set.has(null) // false
```

#### 5. Set.prototype.forEach(fn, thisArg)
`Set` 对象的 `forEach` 方法与数组的相似，唯一不同的是 `Set` 没有索引，所以 `fn` 函数的第一二个参数的值相同，都是指 `Set` 中的元素的值
```javascript
let set = new Set([1,1,,,3,4,,3])
set.forEach((v, i) => console.log(v, i))
// log: 1 1
// log: undefined undefined
// log: 3 3
// log: 4 4
```

#### 6. Set.prototype.values()
方法返回一个 `Iterator`  对象，该对象按照原 `Set` 对象元素的插入顺序返回其所有元素。`Interator` 对象主要是使用 `.next().value` 访问元素。`keys` 是该方法的别名。
```javascript
var mySet = new Set(["foo", "bar", "baz"])
var setIter = mySet.values();

setIter.next().value; // "foo"
setIter.next().value; // "bar"
setIter.next().value; // "baz"
```

#### 7. Set.prototype.entries()
方法返回一个 `Iterator`  对象，对象的每一个元素为一个 `[value, value]` 的数组，按照原 `Set` 对象元素的插入顺序返回。
```javascript
var mySet = new Set(["foobar", 1, "baz"])
var setIter = mySet.entries();

setIter.next().value; // ["foobar", "foobar"]
setIter.next().value; // [1, 1]
setIter.next().value; // ["baz", "baz"]
```

`Set` 的 `values` 和 `entries` 和 `Object` 的不同，并不是返回数组，所以使用上不一样
