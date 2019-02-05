# Groovy
---

# 数据操作(Operators)
## 数学操作符(Arithmetic operators)
### 普通运算符
- \+ ：加(addition)
- \- ：减(subtraction)
- \* ：乘(multiplication)
- / ：除(division)
- % ：模，余数(remainder)
- ** ：指数(power)

```groovy
assert  1  + 2 == 3
assert  4  - 3 == 1
assert  3  * 5 == 15
assert  3  / 2 == 1.5
assert 10  % 3 == 1
assert  2 ** 3 == 8
```

### 一元运算符(Unary operators)
- \+ : 正
- \- : 负
- \++ : 自增(右结合)
- \-- : 自减(右结合)

### 赋值算数运算符(Assignment arithmetic operators)
- \+=
- \-=
- *=
- /=
- %=
- **=

## 关系运算符(Relational operators)
- == : equal
- != : different
- < : less than
- <= : less than or equal
- \> : greater than
- \>= : greater than or equal

## 逻辑运算符(Logical operators)
- && : logical "and"
- || : logical "or"
- ! : logical "not"

优先级(Precedence)：`!` > `&&` > `||`

`&&` 和 `||` 同样有 **短路(Short-circuiting)** 的特征。

## 位运算符(Bitwise operators)
- & : bitwise "and"
- | : bitwise "or"
- ^ : bitwise "xor" (exclusive "or")
- ~ : bitwise negation

## 条件运算符(Conditional operators)
### 取反操作(Not operator)
`!` 反转true或false的值。

在Groovy中，与JS相似，`null`，`""` 都会被当成false的结果。

### 三元运算符(Ternary operator)
`if(...){...}else{...}` 等同于 `condition ? resultA : resultB`

### Elvis operator
对于 `A ? A : B` 这类操作，Groovy有更为简便的表示方式：`A ?: B`。

```groovy
def displayName = user.name ? user.name : 'Anonymous'   
def displayName = user.name ?: 'Anonymous'  
```

## 对象操作(Object operators)
### 安全导航(Safe navigation operator)
> The `Safe Navigation operator` is used to avoid a `NullPointerException`. The safe navigation operator will simply return `null` instead of throwing an exception.

使用 `?.`操作符代替直接的 `.`，可以在访问对象的属性或方法之前，像判断对象是否为空(null)，若对象为空，直接返回 `null` ,而不是抛空指针异常。

```groovy
def person = Person.find { it.id == 123 }    
def name = person?.name                      
assert name == null  
```

### 直接访问属性(Direct field access operator)
在Groovy中，使用 `A.field` 的形式访问对象的属性时，Groovy在解释时不会去访问对象的属性，而是会调用该属性的 `Getter` 方法。Groovy会自动为对象的属性创建 `Getter` 方法。

想要直接访问对象的属性值，应使用 `.@` 代替 `.`.

```groovy
class User {
    public final String name                 
    User(String name) { this.name = name}
    String getName() { "Name: $name" }       
}
def user = new User('Bob')
assert user.name == 'Name: Bob'  //Getter
assert user.@name == 'Bob' //field
```

### 方法指针(Method pointer operator)
`.&` 操作符可以获取对象中指定方法的引用，方便方法作为参数进行传递。

```groovy
def str = 'example of method reference'            
def fun = str.&toUpperCase                         
def upper = fun()                                  
assert upper == str.toUpperCase()  

def transform(List elements, Closure action) {                    
    def result = []
    elements.each {
        result << action(it)
    }
    result
}
String describe(Person p) {                                       
    "$p.name is $p.age"
}
def action = this.&describe                                       
def list = [
    new Person(name: 'Bob',   age: 42),
    new Person(name: 'Julia', age: 35)]                           
assert transform(list, action) == ['Bob is 42', 'Julia is 35']    
```

## 正则表达式(Regular expression operators)
- ~
- =~
- ==~

## 扩展操作符(Spread operator)
`*.` 用于数组，列表或实现`Iterable`接口的对象，将集合展开，并提取元素指定属性的值。

```groovy
class Car {
    String make
    String model
}
cars = [
   new Car(make: 'Peugeot', model: '508'),
   null,                                              
   new Car(make: 'Renault', model: 'Clio')]
assert cars*.make == ['Peugeot', null, 'Renault']     
assert null*.make == null   
```

```groovy
class Component {
    Long id
    String name
}
class CompositeObject implements Iterable<Component> {
    def components = [
        new Component(id: 1, name: 'Foo'),
        new Component(id: 2, name: 'Bar')]

    @Override
    Iterator<Component> iterator() {
        components.iterator()
    }
}
def composite = new CompositeObject()
assert composite*.id == [1,2]
assert composite*.name == ['Foo','Bar']
```

`*` 可用于展开数组向方法传递参数，或将元素传给其他数组。
```groovy
int function(int x, int y, int z) {
    x*y+z
}

def args = [4,5,6]
assert function(*args) == 26

args = [4]
assert function(*args,5,6) == 26
```

```groovy
def items = [4, 5]                      
def list = [1, 2, 3, *items, 6]            
assert list == [1, 2, 3, 4, 5, 6]
```

`*:` 可以展开map对象，将元素传入其他map。
```groovy
def m1 = [c:3, d:4]                   
def map = [a:1, b:2, *:m1]            
assert map == [a:1, b:2, c:3, d:4]  

def m1 = [c:3, d:4]                   
def map = [a:1, b:2, *:m1, d: 8]      
assert map == [a:1, b:2, c:3, d:8]
```

## 范围运算符(Range operator)
`..` 通过指定起点和终点(数字或字母)，以返回连续数字或字母集合，使用 `.collect()` 返回List。

```groovy
def range = 0..5                                    
assert (0..5).collect() == [0, 1, 2, 3, 4, 5]       
assert (0..<5).collect() == [0, 1, 2, 3, 4]         
assert (0..5) instanceof List                       
assert (0..5).size() == 6
assert ('a'..'d').collect() == ['a','b','c','d']
```

## 飞船操作符(Spaceship operator)
`<==>` 是 `compareTo` 的简便写法: 对于 `a <=> b`
- a > b: return 1
- a < b: return -1
- a = b: return 0
```groovy
assert (1 <=> 1) == 0
assert (1 <=> 2) == -1
assert (2 <=> 1) == 1
assert ('a' <=> 'z') == -1
```

## 成员运算符(Membership operator)
`in` 可以判断一个元素是否在某个集合中
```groovy
def list = ['Grace','Rob','Emmy']
assert ('Emmy' in list)
```

## 恒等运算符(Identity operator)
- `==`: 只判断内容
- .is(obj): 判断是否是同一个引用

```groovy
def list1 = ['Groovy 1.8','Groovy 2.0','Groovy 2.3']
def list2 = ['Groovy 1.8','Groovy 2.0','Groovy 2.3']
assert list1 == list2                                   
assert !list1.is(list2)
```

---
# Link
### Offical
http://www.groovy-lang.org/index.html
### SmartThings
https://docs.smartthings.com/en/latest/getting-started/overview.html
### Learn Groovy in Y minutes
https://learnxinyminutes.com/docs/groovy/
### TutorialsPoint Groovy
https://www.tutorialspoint.com/groovy/index.htm
