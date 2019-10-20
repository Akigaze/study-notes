# Object

## Object.prototype
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
