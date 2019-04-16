## 安装

- typescript: TypeScript解释器
- ts-node: 直接执行TypeScript文件的工具

> npm install --save typescript ts-node

### 执行.ts文件
> ts-node xxx.ts

### 编译.ts文件
> tsc xxx.ts

生成 `.d.ts` 文件  
> tsc xxx.ts -d

`.d.ts` 文件保存的是TypeScript文件中一些变量，方法等的定义

## 基本数据类型
`any` `boolean` `number` `string` `void` `never` `Enum` `Tuple` `Array` `null` ` undefine` `object`

### void
- 表示方法没有返回值
- 对于一个 `void` 类型的变量，你只能为它赋予 `undefined` 或 `null`

### nul & undefine

- `undefined `和 `null` 两者各自有自己的类型分别叫做 `undefined` 和 `null`，和 `void` 相似
- 默认情况下 `null` 和 `undefined` 是所有类型的子类型
- 当指定 `--strictNullChecks` 标记，`null` 和 `undefined` 只能赋值给 `void` 和它们各自

### never
表示方法永远不会有返回值，用于抛出异常的方法

`never`类型表示的是那些永不存在的值的类型，如：

-  `never` 类型是那些总是会抛出异常
- 不会有返回值的函数表达式或箭头函数表达式的返回值类型

变量也可能是 `never`类型，当它们被永不为真的类型保护所约束时

- `never` 类型是任何类型的子类型，也可以赋值给任何类型
- 没有类型是 `never` 的子类型或可以赋值给 `never` 类型，除了 `never` 本身之外
-  即使 `any` 也不可以赋值给 `never`

```typescript
// 返回never的函数必须存在无法达到的终点
function error(message: string): never {
    throw new Error(message);
}

// 推断的返回值类型为never
function fail() {
    return error("Something failed");
}

// 返回never的函数必须存在无法达到的终点
function infiniteLoop(): never {
    while (true) {
    }
}
```

### object

`object` 表示非原始类型，也就是除 `number`，`string`，`boolean`，`symbol`，`null` 或 `undefined` 之外的类型

### enum
`enum choose{yes, no}` 或 `enum choose{yes=1, no=2}`

使用枚举元素的编号可以从枚举中找到该元素的名称：

```typescript
enum Color {Red = 1, Green, Blue}
let colorName: string = Color[2];//Green
```

对于枚举类型，TypeScript编译成JS后的实现如下：

**TypeScript:**

```typescript
enum Color {
    RED = 1,
    YELLOW = 2,
    BLUE = 3,
    ORANGE = 5
}
```

**JavaScript:**

```javascript
let Color = {};
(function(Color){
    COlor[Color["RED"] = 1] = "RED";
    COlor[Color["YELLOW"] = 2] = "YELLOW";
    COlor[Color["BLUE"] = 3] = "BLUE";
    COlor[Color["ORANGE"] = 1] = "ORANGE";
})(Color||Color = {});
```

### Tuple
- 元组类型允许表示一个已知 **元素数量** 和 **元素类型** 的 **数组** ，各元素的类型不必相同。
- 元组的数据类型使用 `[type1, type2]` 的形式，限定一个数组的元素个数和相应位置的元素的数据类型 

```typescript
let x: [string, number] = ["hello", 1]
```

### Array
- 数组数据类型有两种表示形式：`Array<string>` 和 `string[]`
- 要求数组中每个元素的类型相同
- 数组初始化或赋值的像是和JS的数组一样: `let arr:string[] = ["x", "y", "z"]`

### 泛型对象

声明一个泛型对象的空实例 `<type>{}` ，`type` 通常是对象定义，接口或类

### 声明变量

- 使用 `var` `let` `const`

- 在变量名后面使用 `:` 指定数据类型

### 类型强转
1. 使用 `<>` 在变量前面指定强转的数据类型 `<type>variable`
2. 在变量后面使用 `as` 指定强转的数据类型 `variable as type`


## 接口 interface
TypeScript中的接口只是用来定义一种数据结构，为某些数据结构做一个命名

### 接口定义

对于定义接口，相当于定义一个具有某种结构的对象：

```typescript
interface book{
    name: string;
    author: string
}
//same as
const book = {
    name: string,
    author: string
}
```

<p style="color:blue">TypeScript对接口类型或对象类型进行检查时，会严格要求<b> 属性名</b>，<b>属性类型</b>，<b>属性数量 </b>相同</p>

一个类实现接口时，必须指定实现接口的属性和方法
```typescript
interface Person {
  name: string;
  age: number;
  gender: boolean;
  
  say(other: string): void;
}
class Student implements Person{
    name: string;
    age: any;
    gender: boolean;
    constructor(){
        
    }
    say(other: string): void {
        console.log(`${this.name}say hello to ${other}`);
    }
}
```

### 可选属性

定义接口时，在属性名后面加上 `?` 表示该属性为可选属性，即在对接口类型进行赋值时，值可以没有 **可选属性** 

```typescript
interface book{
    name: string;
    author: string;
    price?: number;
}
let b1:book = {name:"西游记", author："吴承恩"} //OK
```

### 只读属性

在接口的属性定义前加上 `readonly` 修饰，表示该属性为只读属性，只能在创建对象时为该属性赋值，不允许再修改值。

```typescript
interface book{
    readonly name: string;
    price: number;
}
let b1:book = {name:"西游记", price: 100};
b1.price = 200;
b1.name = "三国杀"; //error
```

`ReadonlyArray<T>` 是只读类型的 `Array<T>` ，取消了所有修改数组属性，元素，内容，引用的操作

```typescript
let a: number[] = [1, 2, 3, 4];
let ro: ReadonlyArray<number> = a;
ro[0] = 12; // error!
ro.push(5); // error!
ro.length = 100; // error!
a = ro; // error!
let b = ro; //ok

a = ro as number[]; //ok
```

### 额外类型检查

- 接口会检查赋值的对象的属性签名是否跟定义的完全一致，如不一致会抛出异常
- 但是 `any` 可以兼容接口类型，只要 `any` 对象包含了接口所需的所有属性即可，即使不存在必须的属性，也会添加相应的属性并赋值`undefine`
- `as` 类型断言也会达到最大的兼容，只提取目标接口需要的属性，若不存在目标属性，才抛出异常

```typescript
interface labelValue{ 
    label: string;
}

function printLabel(obj: labelValue){
    console.log(obj.label);
}

printLabel({size: 10, label: "another good day!"}); //error
const label1:any = {size:10, label:"a wonderful day!"}
printLabel(label1); //ok
const label2:labelValue = {size:10, label:"a wonderful day!"} // error
printLabel({size: 10, label: "another good day!"} as labelValue); //ok
// printLabel({size: 10} as labelValue); //error
const label3:any = {size:100}
printLabel(label3); //ok output：undefine
```

### 函数接口

声明函数接口有两种方式：

1. 在接口中定义函数，只需要指定函数的参数列表和返回值类型，然后再创建函数接口对象时，使用函数对接口对象赋值即可
2. 使用 `函数名(参数列表):返回值` 的形式声明函数属性

```typescript
interface SearchFunc {
  (source: string, subString: string): boolean;
}
let mySearch: SearchFunc;
mySearch = function(source: string, subString: string) {
  ......
}
// ---------------------  
interface Study {
    sleep(hours: number);
    read(word: string): string;
}

let ming: Study;
function sleep(hours: number) {
    ......
}
function read(word: string): string {
    return "朗读：" + word;
}

ming = {sleep, read};
ming.sleep(10);
ming.read("sleep");
```

### 索引类型[]

在接口定义中，可以使用 `[]` 声明索引类型的属性，创建接口的对象时，可以任意添加属性

索引的类型有两种：**数字** 和 **字符串**，而 **数字** 的本质也是转换成 **字符串** 再去获取属性值，所以数字索引的值类型要是字符串索引的子类型

数字索引：可以直接使用数组对接口对象进行赋值，只要接口对象就可以得到数字索引类型的值

字符串索引：声明了字符串索引后，要求接口的其他属性的类型也必须是字符串索引的类型或子类

声明索引属性： 

- `[index:number]: number | string` 在 `[]` 指明属性名的数据类型， `[]` 外指定属性值的数据类型
- `[propName: string]:string` 



### 构造方法接口

- 接口也可以有构造方法，但是需要从外部传入实现
- 使用 `new (参数列表):构造对象的类型` 声明接口的构造方法
- 使用 `new 接口名称(参数)` 的方式调用接口的构造方法
- 构造方法接口类型的数据必须是个构造方法，并且参数列表与接口定义的一致

```typescript
interface ClockConstructor {
    new (hour: number, minute: number): ClockInterface;
}
interface ClockInterface {
    tick();
}

function createClock(ctor: ClockConstructor, hour: number, minute: number): ClockInterface {
    return new ctor(hour, minute);
}

class DigitalClock implements ClockInterface {
    hours: number;
    minutes: number;
    constructor(h: number, m: number) {
        this.hours = h;
        this.minutes = m;
    }
    tick() {
        console.log(`beep ${this.hours} beep ${this.minutes}`);
    }
}
class AnalogClock implements ClockInterface {
    constructor(h: number, m: number) { }
    tick() {
        console.log("tick tock");
    }
}

let digital = createClock(DigitalClock, 12, 17);
digital.tick();
let analog = createClock(AnalogClock, 7, 32);
analog.tick();
```

### 接口的继承

有两种情况：接口继承接口 和 类实现接口

接口继承接口使用 `extends`  关键字，继承多个接口时，用逗号分隔不同接口

类实现接口时，使用 `implement` 关键字，并且需要在类中重新声明接口中所用属性和方法

### 接口继承类

- 当接口继承了一个类类型时，它会继承类的成员但不包括其实现

-  接口同样会继承到类的private和protected成员，当创建一个接口继承了一个拥有私有或受保护的成员的类时，这个接口类型只能被这个类或其子类所实现

```typescript
class Control {
    private state: any;
}

interface SelectableControl extends Control {
    select(): void;
}

class Button extends Control implements SelectableControl {
    select() { }
}

class TextBox extends Control {
    select() { }
}

// 错误：“Image”类型缺少“state”属性。
class Image implements SelectableControl {
    select() { }
}
```



## 属性修饰符
### readonly
设置属性为只读，但允许在构造方法中对只读属性进行直接修改

### public
默认的级别

### private

### protected

## 特殊符号
### ? 可选属性
添加在属性名后面，表示在创建对象时，可以不用为该属性赋值

### | 或
用于数据类型之间，表示可以是两种类型中的一种

## Link
[TypeScript精通指南](https://nodelover.gitbook.io/typescript/)  
[Github TypeScript 精通指南](https://github.com/MiYogurt/nodelover-books/tree/master/typescript)