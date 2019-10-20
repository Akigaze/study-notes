# Link
1. [JavaScript.info - Methods of primitives](https://zh.javascript.info/primitives-methods)

# Primitives 基本类型

## 一、基本类型

- 基本类型是原始类型中的一种值。
- 在 JavaScript 中有 6 种基本类型：`string`、`number`、`boolean`、`symbol`、`null` 和 `undefined`。
- `null` 和 `undefined` 是特殊的基本类型，他们没有然和方法，也没有包装类型

**基本类型不是对象，他们不存储数据，所以没有属性和方法**

## 二、包装类型
- 基本类型通过他们的包装类型来获得方法和属性
- “包装对象” 对于每种基本类型调用都是不同的，如 `String`, `Number`, `Boolean` 和 `Symbol`。

### 基本类型调用方法的过程
```javascript
var str = 'hello world'
str.toUpperCase()
```
1. 字符串 `str` 是一个基本类型。所以在访问它的属性时，会即刻创建一个包含字符串字面值的 `String` 包装对象，并且具有有用的方法，例如 `toUpperCase()`。
2. 该方法运行并返回一个新的字符串。
3. String 包装对象被销毁，只留下基本类型 `str`。

```javascript
let str = "Hello";
str.test = 5; // (*)
alert(str.test);
```
上述代码有两种可能结果：
- `undefined`
- 报错

**分析：**
1. 因为基本类型对象本身不存储任何属性或方法，在进行 `str.test = 5` 操作时，会想构建 str 的包装对象，
2. 对包装对象调用或添加 `test` 属性，但对包装对象添加或修改属性有时是不允许的，所以可能报错
3. 对包装对象添加 `test` 属性后，包装对象销毁，再次访问 `str.test` 时会创建新的包装对象，所以返回 `undefined`

### 不推荐使用 `new` 包装类型
- 使用 `new Number(123)` 等 `new`+`包装类型构造方法` 创建的对象，不是基本数据类型的对象，而是一个引用类型的对象
- 包装对象可以进行像基本类型一样的运算操作，但运算的结果会返回一个基本类型
- 包装对象转换的布尔值都是 `true` ，即使是 `new Boolean(false)` 也会转成 `true`，这与基本类型很不一样

***注意：*** 若使用 `String('hello')` 这种直接调用包装类型函数的方式，则可以创建基本类型的对象
