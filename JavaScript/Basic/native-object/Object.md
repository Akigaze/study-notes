# Object

## 一、Object.prototype
### 1. valueOf()
> `valueOf()` 方法返回指定对象的原始值。

通常是返回对象本身或者其字面量值

### 2. toString()
默认情况下，返回 `[object type]` 的字符串，其中 `type` 为对象构造方法的名字

**使用 `toString` 进行类型检查**
```javascript
Object.prototype.toString.call(123); //"[object Number]"
Object.prototype.toString.call(false); //"[object Boolean]"
Object.prototype.toString.call('str'); // [object String]
Object.prototype.toString.call(Symbol('id')); //"[object Symbol]"
Object.prototype.toString.call([]); //"[object Array]"
Object.prototype.toString.call(new Set()); //"[object Set]"
Object.prototype.toString.call(new Map()); //"[object Map]"

Object.prototype.toString.call(new Date()); // "[object Date]"
Object.prototype.toString.call(Math); // "[object Math]"

//Since JavaScript 1.8.5
Object.prototype.toString.call(undefined); // "[object Undefined]"
Object.prototype.toString.call(null); // "[object Null]"

Object.prototype.toString.call(window); // "[object Window]"
```

### 3. toLocalString()
> `toLocaleString()` 方法返回一个该对象的字符串表示。此方法被用于派生对象为了特定语言环境的目的（locale-specific purposes）而重载使用。

根据浏览器或服务器所在的地区返回特定格式的字符串，与 `toString` 相似，只是带有地区特性

### 4. hasOwnProperty(prop)
> `hasOwnProperty()` 方法会返回一个布尔值，指示对象自身属性中是否具有指定的属性（也就是，是否有指定的键）。

只有当属性或方法是对象自身拥有的才会返回 `true`，从 **原型** 继承的属性或方法会返回 `false`
**注意：** JavaScript 并没有保护 `hasOwnProperty` 这个属性名，所以运行对象重写覆盖该方法

### 5. isPrototypeOf(object)
> `isPrototypeOf()` 方法用于测试一个对象是否存在于另一个对象的原型链上。

该方法不要求是直接原型，只要是原型链上的其中一节，都返回 `true`
```javascript
function Foo() {}
Object.prototype.isPrototypeOf(Foo) // true
let foo = new Foo()
Object.prototype.isPrototypeOf(foo) // true
Foo.prototype.isPrototypeOf(foo) // true
let nx = Object.create(null)
Object.prototype.isPrototypeOf(nx) // false
```

### 6. propertyIsEnumerable(prop)
> `propertyIsEnumerable()` 方法返回一个布尔值，表示指定的属性是否可枚举

> 每个对象都有一个 `propertyIsEnumerable` 方法。此方法可以确定对象中指定的属性是否可以被 `for...in` 循环枚举，但是通过原型链继承的属性被排除在检查范围除外，所以返回 `false`。如果对象没有指定的属性，则此方法返回 `false`。


## 二、属性描述符
> 对象里目前存在的属性描述符有两种主要形式：**数据描述符** 和 **存取描述符** 。**数据描述符** 是一个具有值的属性，该值可能是可写的，也可能不是可写的。**存取描述符** 是由 *getter-setter* 函数对描述的属性。

**数据描述符** 和 **存取描述符** 通俗讲就是对象的属性，对于属性，JS提供了一些键值用于配置属性的特征.

**两种描述符都有的可选键值：**  
- `configurable` : 当且仅当属性的 `configurable` 为 `true` 时，该属性(描述符)才能够被改变，同时该属性也能从对应的对象上被删除。默认为 `true`。
- `enumerable` : 当且仅当属性的 `enumerable` 为 `true` 时，该属性才能够出现在对象的枚举属性中(循环 `for-in`)。默认为 `true`。

**只有数据描述符才有的可选键值：**
- `value` : 属性对应的值。可以是任何有效的 JavaScript 值（数值，对象，函数等）。默认为 `undefined`。
- `writable` : 当且仅当属性的 `writable` 为 `true` 时，`value` 才能被赋值运算符改变。默认为 `true`。

**只有存取描述符才有的可选键值：**
- `get` : 一个给属性提供 getter 的方法，如果没有 getter 则为 `undefined`。当访问该属性时，该方法会被执行，方法执行时没有参数传入，但是会传入this对象（由于继承关系，这里的this并不一定是定义该属性的对象）。默认为 `undefined`。
- `set` : 一个给属性提供 setter 的方法，如果没有 setter 则为 `undefined`。当属性值修改时，触发执行该方法。该方法将接受唯一参数，即该属性新的参数值。默认为 `undefined`。

|类型|configurable|enumerable|value|writable|get|set|
|:--|:--|:--|:--|:--|:--|:--|
|数据描述符|Yes|Yes|Yes|Yes|No|No|
|存取描述符|Yes|Yes|No|No|Yes|Yes|

### 1. 数据描述符属性(flags/descriptors)
**查看属性的描述符：**
- `Object.getOwnPropertyDescriptor(obj, propertyName)` : 会返回一个包含 `value`、`enumerable`、`configurable`、`writable` 四个属性的对象
```javascript
let man = {name: 'John'}
Object.getOwnPropertyDescriptor(man, 'name') // {value: "John", writable: true, enumerable: true, configurable: true}
```

- `Object.getOwnPropertyDescriptors(obj)` : 获取对象全部属性的配置信息，该方法通常可以用来赋值对象的属性和配置 `let clone = Object.defineProperties({}, Object.getOwnPropertyDescriptors(obj));`
```javascript
let devil = {}
Object.defineProperty(devil, 'mp', {configurable: false, value:100})
devil.level = 99
Object.getOwnPropertyDescriptors(devil)
// {
//     level: {value: 99, writable: true, enumerable: true, configurable: true}
//     mp: {value: 100, writable: false, enumerable: false, configurable: false}
// }
```

**修改或添加数据描述符：**
- `Object.defineProperty(obj, propertyName, descriptor)` ：当指定的属性(`propertyName`)在对象中已经存在时，会更新相应的 `descriptor`；若属性不存在，则创建该属性，`descriptor` 中没有指明的描述符属性会赋予默认值 `false`，`value` 属性默认值为 `undefined`  
```javascript
let man = {name: 'John'}
Object.getOwnPropertyDescriptor(man, 'name')// {value: "John", writable: true, enumerable: true, configurable: true}  
Object.defineProperty(man, 'name', {value: 'Lee', enumerable: false})
Object.getOwnPropertyDescriptor(man, 'name') // {value: "Lee", writable: true, enumerable: false, configurable: true}
Object.defineProperty(man, 'home', {value: 'Hong Kong', enumerable: true})
Object.getOwnPropertyDescriptor(man, 'home') // {value: "Hong Kong", writable: false, enumerable: true, configurable: false}
Object.defineProperty(man, 'home', {value: 'Hong Kong', enumerable: true}) // Error
Object.defineProperty(man, 'country', {writable: true, enumerable: true})
Object.getOwnPropertyDescriptor(man, 'country') // {value: undefined, writable: true, enumerable: true, configurable: false}
man // {age: 15, country: undefined, name: "Lee", home: "Hong Kong"}
```

- `Object.defineProperties` : `Object.defineProperty` 的升级版，运行同时配置多个属性
```javascript
Object.defineProperties(obj, {
      prop1: descriptor1,
      prop2: descriptor2
      // ...
});
```

**只读(writable)**  
当 `writable` 被设置为 `false` 时，对相应属性的修改都无效，但并不会抛出任何异常
```javascript
let king = {name: 'Saber'}
Object.defineProperty(king, 'name', {writable: false})
king.name // "Saber"
king.name = 'Archer'
king.name // "Saber"
Object.defineProperty(king, 'weapon', {value: 'sword', writable: false})
king.weapon // "sword"
king.weapon = 'bow'
king.weapon // "sword"
```

**不可枚举(enumerable)**  
`enumerable` 决定了对象的属性可否在 `for...in` 或 `Object.keys()` 等遍历到，当 属性的 `enumerable` 被设置为 `false` 时，将不会被 `for...in` 或 `Object.keys()` 遍历出来；JS许多内置对象的原型的属性和方法 `enumerable` 都设置为 `false`
```javascript
let user = {
  name: "John",
  toString() {
    return this.name;
  }
};
for(let key in user) {console.log(key)} // name toString
Object.keys(user) // ["name", "toString"]
Object.defineProperty(user, 'toString', {enumerable: false})
for(let key in user) {console.log(key)} //name
Object.keys(user) // ["name"]
```

**不可配置(configurable)**  
当属性的 `configurable` 被设置成 `false` 时，此时该属性将无法从对象被删除，且无法再将配置键值从 `false` 改为 `true` ，但可以从 `true` 改为 `false`；许多JS内置的变量和方法就都是不可配置的，如 `Math.PI`
```javascript
let devil = {};
Object.defineProperty(devil, 'level', {configurable: false, value: 100})
Object.defineProperty(devil, 'level', {configurable: false, writable: true, value: 100}) // Error
Object.defineProperty(devil, 'level', {configurable: false, value: 200}) // Error
Object.defineProperty(devil, 'level', {configurable: true, value: 100}) // Error
```

```javascript
let devil = {};
Object.defineProperty(devil, 'mp', {configurable: false, writable: true, value: 100})
devil.mp = 200
devil.mp // 200
Object.defineProperty(devil, 'mp', {configurable: false, writable: false, value: 100})
{mp: 100}
devil.mp // 100
devil.mp = 200
devil.mp // 100
Object.defineProperty(devil, 'mp', {configurable: false, writable: true, value: 100}) // Error
Object.defineProperty(devil, 'mp', {configurable: false, enumerable: true, value: 100}) // Error
Object.defineProperty(devil, 'mp', {configurable: false, enumerable: true}) // Error
Object.defineProperty(devil, 'mp', {configurable: false})
```

**数据描述符配置相关的函数：**  
- `Object.preventExtensions(obj)` : 禁止向对象添加属性。
- `Object.seal(obj)` : 禁止添加/删除属性，为所有现有的属性设置 `configurable: false`。
- `Object.freeze(obj)` : 禁止添加/删除/更改属性，为所有现有属性设置 `configurable: false, writable: false`。
- `Object.isExtensible(obj)` : 如果添加属性被禁止，则返回 `false`，否则返回 `true`。
- `Object.isSealed(obj)` : 如果禁止添加/删除属性，则返回 `true`，并且所有现有属性都具有 `configurable: false`。
- `Object.isFrozen(obj)` : 如果禁止添加/删除/更改属性，并且所有当前属性都是 `configurable: false, writable: false`，则返回` true`。

### 2. 存取描述符属性(accessor property: getter/setter)
> 访问器属性（accessor properties）本质上是获取和设置值的函数，但从外部代码来看像常规属性。

访问器属性有两种：**getter** 和 **setter** ，在对象字面量中，它们用 `get` 和 `set` 关键字，既可以在定义对象时定义 getter 和 setter，也可以在 `Object.defineProperty` 中定义
```javascript
// 定义对象时添加getter和setter
let obj = {
  get propName() {
    // getter, the code executed on getting obj.propName
  },
  set propName(value) {
    // setter, the code executed on setting obj.propName = value
  }
}
// 使用Object.defineProperty添加getter和setter
let user = {
  name: "John",
  surname: "Smith"
};
Object.defineProperty(user, 'fullName', {
  get() {
    return `${this.name} ${this.surname}`;
  },
  set(value) {
    [this.name, this.surname] = value.split(" ");
  }
});
```

访问器属性在使用时当成普通属性使用: 读取 `obj.propName`，赋值 `user.fullName = 'James'`

getter 没有参数，setter 会将等号右边的值作为参数；当缺少 getter 或 setter 的定义时，属性将不能读取或无法修改

存取描述符(访问器属性)除了 **getter** 和 **setter** 外，还有 `enumerable` 和 `configurable` 两个属性，这两个的使用与数据描述符相同

#### 属性可以是 *数据描述符* 或 *存取描述符*，不能同时属于两者


## 三、Object函数方法
- `Object.preventExtensions(obj)`
- `Object.seal(obj)`
- `Object.freeze(obj)`
- `Object.isExtensible(obj)`
- `Object.isSealed(obj)`
- `Object.isFrozen(obj)`


- `Object.defineProperty()`
- `Object.defineProperties()`
- `Object.getOwnPropertyDescriptor(obj, propName)`
- `Object.getOwnPropertyDescriptors(obj)`
- `Object.getOwnPropertyNames(obj)` : 返回给定对象自身 **可枚举** 和 **不可枚举** 属性的名称字符串数组，不包含原型链上的属性
- `Object.getOwnPropertySymbols(obj)` : 在给定对象自身上找到的所有 Symbol 属性的数组
- `Object.getPrototypeOf()`
- `Object.setPrototypeOf()`


- `Object.is(v1, v2)` : 相当于 `===` 判断相等，但是它可以不区分 `NaN`，区分 `0` 和 `-0`
- `Object.create(prototype, props)` : 以指定对象作为原型创建对象，同时为对象自身添加属性；`props` 是一个对象，key为属性名，value为属性的描述符
- `Object.assign(target, ...sources)` :  
将所有自身可枚举属性的值从一个或多个源对象复制到目标对象，修改并返回目标对象；  
如果目标对象中的属性具有相同的键，则属性将被源对象中的属性覆盖。后面的源对象的属性将类似地覆盖前面的源对象的属性；  
如果源包含了getter，该方法会创建一个同名属性并赋值getter返回的值；  
该方法的拷贝是浅拷贝。
- `Object.entries(obj)` : 返回一个给定对象自身可枚举属性的键值对数组 `[[key, value],...]`，包括getter的属性名和返回的值；属性输出的顺序与使用 `for...in` 相同
- `Object.keys(obj)` : 返回一个由一个给定对象的自身可枚举属性组成的数组，即仅返回 `Object.entries` 返回的每个数组中的第一个元素key
- `Object.values(obj)` : 返回一个给定对象自身的所有可枚举属性值的数组，即仅返回 `Object.entries` 返回的每个数组中的第二个元素value
- `Object.fromEntries()` : 相当于 `Object.entries` 的反转，能将数组或者Map转成具有相应key-value的对象
```javascript
const map = new Map([ ['foo', 'bar'], ['baz', 42] ]);
Object.fromEntries(map); //{ foo: "bar", baz: 42 }
const arr = [ ['0', 'a'], ['1', 'b'], ['2', 'c'] ];
Object.fromEntries(arr); //{ 0: "a", 1: "b", 2: "c" }
```
