## TypeScript
### 安装
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
`any` `boolean` `number` `string` `void` `never` `Enum` `Tuple` `Array`

### void
表示方法没有返回值

### never
表示方法永远不会有返回值，用于抛出异常的方法

### Enum
`Enum choose{yes, no}`

### Tuple
类似于数组的字面量
`["a", "b", "c", "d"]`

### Array
有两种形式：`Array<string>` 和 `string[]`

### 声明变量
在变量名后面使用 `:` 指定数据类型

### 类型强转
1. 使用 `<>` 在变量前面指定强转的数据类型 `<type>variable`
2. 在变量后面使用 `as` 指定强转的数据类型 `variable as type`


## 接口 interface
TypeScript中的接口只是用来定义一种数据结构

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

#### 扩展属性[]
在接口定义中，可以使用 `[]` 声明扩展属性，创建接口的对象时，可以任意添加属性；  
`[index:string]: number | string` 在 `[]` 指明属性名的数据类型， `[]` 外指定属性值的数据类型；

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