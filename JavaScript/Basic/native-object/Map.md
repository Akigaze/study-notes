# Map

## Link
- [MDN - 迭代协议](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Iteration_protocols)
- [MDN - Iterator](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Iterator)

JS 是的 `Map` 与 `Object` 相似，都是以键值对的形式保存数据，唯一不同的是 `Map` 可以用任何类型的值(对象、原始值、函数) 为键或值，而 `Object` 只能用字符串或 Symbol 做键

## 一、定义声明
```javascript
new Map(iterable)
// iterable like [['A', 'a'], ['B', 'b']]
```

`iterable` : 为一个可迭代对象(数组等)，且其元素为键值对的形式(`[key,value]` 等)，构造方法会提取这些键值对作为 `Map` 中的元素。
```javascript
let m1 = new Map([['A', 'a'], ['B', 'b']])
m1 // Map(2) {"A" => "a", "B" => "b"}
let m2 = new Map([[undefined, 'u'], ['N', null], ['U', undefined], [null, 'n']])
m2 // Map(4) {undefined => "u", "N" => null, "U" => undefined, null => "n"}
m2.get(undefined) // "u"
m2.get(null) // "n"
m2.get("U") // undefined
m2.get("N") // null
```

`Map` 对象在迭代时会根据对象中元素的插入顺序来进行，`for...of` 循环在每次迭代后会返回一个形式为 `[key，value]` 的数组。
```javascript
let m1 = new Map([['A', 'a'], ['B', 'b']])
for(let entry of m1) { console.log(entry); } // log: ["A", "a"]  ["B", "b"]
`````

对于普通的 `Object` 转 `Map`，要先用 `Object.entries` 将对象转数组，再使用 `Map` 构造方法

## 二、特点
- `Map` 的键可以是任意值，包括函数、对象、基本类型
- `Map` 中的键值是有序的，当对它进行遍历时，`Map` 对象是按插入的顺序返回键值
- 通过 `size` 属性直接获取一个 `Map` 的键值对个数
- `Map` 可直接进行迭代(`for...of`)，而普通对象只能先获取key再对key进行迭代(`for...in`)  

## 三、属性
- `Map.prototype.size` : 返回 Map 对象的键值对的数量。

## 四、方法
#### 1. Map.prototype.set(key, value)
添加指定的键值对，如果 `key` 已经存在，则会将原有的 `value` 替换掉；返回添加键值对后的 `Map` 对象，可以使用链式调用
```javascript
let user = {name: "Jone"}
let m1 = new Map([[user, 'JJJJ'], ['X', 'x'], [100, 'hundred']])
m1 // {user => "JJJJ", "X" => "x", 100 => "hundred"}
m1.set(false, 'wrong') // {user => "JJJJ", "X" => "x", 100 => "hundred", false => "wrong"}
m1.set(false, 'cuo') // {user => "JJJJ", "X" => "x", 100 => "hundred", false => "cuo"}
m1.set(user, {age: 18}) // {user => {age: 18}, "X" => "x", 100 => "hundred", false => "cuo"}
```

#### 2. Map.prototype.get(key)
获取指定 `key` 的键值对的 `value`，若 `key` 不存在，则返回 `undefined`

#### 3. Map.prototype.delete(key)
从 `Map` 对象中删除指定 `key` 的键值对，删除成功返回 `true`，若键不存在或删除失败返回 `false`

#### 4. Map.prototype.has(key)
判断指定 `key` 在 `Map` 对象中是否存在，存在返回 `true`，否则返回 `false`

#### 5. Map.prototype.clear()
移除 `Map` 对象中所有元素

#### 6. Map.prototype.forEach(fn, thisArg)
与数组、Set 的 `forEach` 相似，`fn` 函数接收三个参数：`value`、`key`、`map`
```javascript
let user = {name: "Jone"}
let m1 = new Map([[user, 'JJJJ'], ['X', 'x'], [100, 'hundred']])
m1.forEach((v, k) => console.log(k, v))
// log: {name: "Jone"} "JJJJ"
// log: "X" "x"
// log: 100 "hundred"
```

#### 7. Map.prototype.keys()
与 Set 的 `values` 相似，返回一个新的 `Iterator` 对象，包含按照顺序插入 `Map` 对象中每个元素的key值

#### 8. Map.prototype.values()
与 Set 的 `values` 相似，返回一个新的 `Iterator` 对象，包含按照顺序插入 `Map` 对象中每个元素的value值

#### 9. Map.prototype.entries()
与 `Set` 的 `entries` 相似，返回一个新的包含 `[key, value]` 对的 `Iterator` 对象
