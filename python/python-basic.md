Python基础
===

### 输入与输出

1. 输出：`print(a, b, c, ...)`
2. 输入：`input('tip')` ，`'tip'` 是在输入用户之前打印的文本，为可选参数

### 注释

```python
# 这是python注释
```

标注文档的作者：

```python
__author__ = 'Akigaze Hwang'
```

### 数据类型

#### 1. 整数(int)，浮点数(float)

- python 没有 `++` 或者 `--` 的操作

#### 2. 字符串(str)

1. python的字符串类型表示为 `str`
2. 同时支持 **单引号** 和 **双引号** 编写字符串
3. 多行字符串可以使用 **三个单引号** `'''...'''`
4. `r''` 可以让 `''`  引号中的内容不用转义，对 **三个单引号** 也适用：`print(r'\\\t\\')` --> `\\\t\\`
5. 与JS一样，字符串不是引用类型
6. 采用 **Unicode** 编码
7. 不能使用 `+` 拼接字符串和数字(异常：`TypeError: must be str, not int`)

#### 字符串编码

- `ord(char)` 获取单个字符对应的十进制的Unicode码
- `chr(number)` 获取Unicode对应的字符
- `'\u4e2d\u6587'` 直接使用Unicode的字符串，返回对应的字符 `中文`
- `b'...'` 将字符串中的每个字符都以单个字节的形式存储，所以中文等需要用到多个字节存储的字符不适用
- `str.encode('编码类型')` 用指定字符集编码字符串，字符集有 `utf-8`, `ascii` 等
- `b'..'.decode('编码类型')` 将字节码按指定字符集解码成字符串
- 在 `.py` 文件开头添加 `# -*- coding: utf-8 -*-` 指定文件的编码类型

#### 字符串方法

1. `len(str)` 返回字符的个数，如果参数是字节类型(`b'as'` 等) ，则返回字节数
2. `%` 格式化字符串：`'Hi, %s, you have $%d.' % ('Michael', 1000000)` ，格式化字符串中的 `%` 字符使用 `%%` 进行输出
3. `str.format()` 格式化字符串，在字符串中使用 `{数字}` 的形式作为占位符，`{数字：x}` x 为一些格式约束

![字符串占位符](F:\学习\study-notes\Python\pic\python格式化字符串.png)

#### 3. 布尔值(bool)

1. `True` 和 `False`
2. 运算符：`and` `or` `not`

#### 4. 空值

1. `None`

#### 5. 类型转化

- str --> int：`int(str)` 将字符串转化成正数，参数必须是一个整数的字符串 (异常：`ValueError`)
- float --> int: `int(float)`
- str --> float: `float(str)`
- any --> str: `str(any)`
- any --> bool: `bool(any)`

#### 6. 类型检查

`isinstance(data, (type1, type2,..))`

### 运算符

#### 1. 除法

1. `/` 普通除法
2. `//` 地板除法，即只取整数部分

# 数据结构

## 1. list(列表)
```
a = ['a', 'b', ...]
```
* 元素可变，元素类型随意
* 支持排序
* 使用索引查找元素(`list[0]`) , 正数表示正序查找，负数为倒叙查找
* 使用 `len()` 函数获取列表长度：`len(list)`
* 按值查找麻烦
#### 生成list

1. `list(序列)` : 将 `range` 函数等生成的序列转换成一个list
2. `range(start, end)` : 生成一个整数序列，包头不包尾，但注意返回的不是一个list，只是一个序列

#### list 相关方法

- `.append(element)` : 追加元素
- `.insert(index, elemrnt)` : 在指定索引的位置插入元素
- `.pop()` : 删除末尾的元素
- `.pop(index)` : 删除指定索引的元素
- `.sort()` : 排序，默认正序

## 2. tuple(序列，元组)
```
B = ('a', 'b', ..)
```
* 相当于不可变list
* 长度不可变，索引的对象地址不变
* 本身不排序
* 适合存放不可变的内容
* 定义指定长度的tuple，需要在长度后面加上逗号：`tuple1 = (4,)`
#### 2.1利用tuple对多个变量进行赋值

python的tuple中的值可以通过一个赋值表达式赋值给多个变量

```python
tuple = (1, 3, 5)
a, b, c = tuple
# a=1, b=3, c=5
```

这种方式可以直接省略tuple的定义，用一个等号对两边的变量和值按顺序进行赋值

```python
a, b, c = 1, 3, 5
# a=1, b=3, c=5
```

## 3. dict(字典)

```
C = {key:value,...}
```
- 键值对的形式存储数据，类似于json对象
- `key` 必须是不可变的值

#### 取值

1. `[key]` : 使用索引的形式获取值，当指定的 `key` 不存在时，抛异常：`KeyError`
2. `.get(key)` ：获取指定 `key`对应的值，当 `key` 不存在时，返回 `None`
3. `key in dist` : 判断指定 `key`  在字典中是否存在

#### dict的方法

- `.pop(key)` : 删除指定 `key` 的键值对
- dict 的key应写成字符串形式，若直接写变量名，python会将变量的值作为key

```python
# dist 字典,类似于json对象
persons = {"Newton": 10, "Galileo": 45, "Einstein": 57, "Edison": 67}

# in 判断是否存在指定key
print("Newton" in persons)
print("Marx" in persons)

# [] 取值
print(persons["Einstein"])
print(persons["Marx"]) # KeyError

# .get 取值
print(persons.get("Edison"))
print(persons.get("Marx"))  # None

# .pop 删除
persons.pop("Galileo")
```

### 4. set 集合

```python
set1 = {"a", "b", ...}
```

- 相当于一个 **无序** **不重复** 的list
- 实现原理与 dict 相同，只有 `key` 没有 `value`
- 自动去重

#### 创建set

1. `set(list)` ：`set`  函数将一个 list 转换成 set
2. `{key1, key2,...}` ：类型定义dict的形式，不指定 value

#### set的方法

- `.add(key)` : 添加元素
- `.remove(key)` ：删除指定元素，当指定的 `key` 不存在时，抛出异常：`KeyError`
-  `&` : 对两个set取交集
- `|` : 对两个set 取并集

```python
set1 = set(["Einstein", "Newton", "Galileo", "Newton", "Einstein", "Edison"])
set2 = {"Einstein", "Newton", "Galileo", "Newton", "Einstein", "Edison"}

set1.add("Marx")
print(set1)

set2.remove("Galileo")
# set2.remove("Washington")  # KeyError
print(set2)

num1 = {1, 3, 5, 7}
num2 = {1, 5, 2, 6}
print(num1 & num2)
print(num1 | num2)
```

### 5. 空代码块 pass

因为python中没有 `{}` 表示代码块，所以要设置 **空循环体**，**方法体**，**if操作** 等，可以用 `pass` 关键字代替

# 流程控制语句
### 1. if...else

- 在 `if` 的条件之后或者 `else` 之后，要带上冒号 `:`
- `else if` 在python中写成 `elif`
- 与JavaScript相似， `if` 的判断条件不一定要是 `True` 或 `False` ，**非零数值**、**非空字符串**、**非空list** 等，就判断为 `True`，否则为 `False`。

```python
age = 20
if age <= 18:
    print("未成年人。")
elif age<=40:
    print("中年人。")
else:
    print("老年人。")
```

### 2. for 循环

- `for i in list:` 的形式，对list或序列(`range`)进行遍历
- 循环声明要以 `:` 结尾，再编写循环体

```python
names = ["Einstein", "Newton", "Galileo", "Edison"]
for name in names:
    print("name: %s\t length: %d" % (name, len(name)))

sum1 = 0
for i in range(0, 5):
    sum1 += i
print("sum1 = %d" % sum1)
```

### 3. while 循环

- `while condition:` 的形式，与其他语言 `while` 循环的用法相同
- 循环条件之后要加 `:` ，在编写循环体

```python
sum1 = 0
cur = 1
while cur < 10:
    sum1 += cur
    cur += 1
print("result %d" % sum1)
```

### 4. break & continue

- `break`: 结束循环
- `continue`: 跳过当前循环

# 函数

### 1. 调用

- 当传参多余定义的参数数量时，会抛出异常：`TypeError`
- 当参数的类型不对时，会抛出异常：`TypeError`
- 与JavaScript相似，函数名只是一个变量的引用而已，可以任意赋值或者赋值给其他变量
- python函数传参可以使用 `参数名 = 值`  的形式，为指定名称的参数赋值，这与R语言类似，但其实JavaScript也支持这样的传参方式

### 2. 定义

- `def funcName(args):` 形式声明一个函数
- `return` 关键字返回值，`pass` 关键字声明空的方法体

```python
#定义函数
def test1():
    print("函数test")
#调用函数
test1()

def test2(a,b):
    print("函数test2",a,b)
test2("hello","world")

def test3(a,b,c):
    d=a+b+c
    print("函数test3",d)
    return d #有返回值
print(test2(1,2,3))
```

#### 返回值

- python的方法支持多返回值，返回值之间用逗号分隔： `return a, b, c`
- 多返回值的实质是返回一个 **tuple**， 只是返回 tuple 时可以省略括号而已
- 调用多返回值的函数是，可以使用一个变量接收所有返回值，此时该变量就是一个 tuple；也可以用多个变量接收返回值，多个变量用逗号分隔，分别接收每一个返回值，此时接收返回值的变量个数必须与返回值个数相同，否则抛出异常：`ValueError: too many values to unpack` 或 `ValueError: not enough values to unpack`

```python
def get_date():
    return 2019, 4, 21

one_date = get_date()
y, m, d = get_date()
print(one_date, y, m, d)

# y, m = get_date()  ValueError: too many values to unpack
# y, m, d, x = get_date()  ValueError: not enough values to unpack
```

#### 默认参数

- 在定义参数时使用 `=` 在参数列表中为参数赋上默认值
- 默认参数要置于非默认参数之后
- python中方法参数列表中的参数也是变量，当多次调用函数使用默认参数时，默认参数引用的是同一个对象
- 默认参数应该的值应该是 **不变对象**

```python
def add_end(name="Marx", li=[]):
    li.append("end")
    return name, li

print(add_end())  # ('Marx', ['end'])
print(add_end())  # ('Marx', ['end', 'end'])
print(add_end())  # ('Marx', ['end', 'end', 'end'])
```

#### 可变参数

- 在参数名前面加上 `*` ，表示后面的变量是一个可变参数，可以接受任意数量的参数
- 可变参数要放在必选参数之后
- 可变参数的参数变量在方法体中是一个 tuple
- 在调用函数时，运行在list 或者 tuple等类型的参数前加 `*` 将其转化成多个参数，相当于 JavaScript的解构
- `*` 的一个作用是将 `1,2,3` 形式的序列转化成tuple `(1,2,3)` ；另一个作用是将 tuple 或list `(1,2,3)` 分解成 序列 `1,2,3`

```python
def get_sum(*params):  # * 参数组装
    sum1 = 0
    for p in params:
        sum1 += p
    return sum1


print(get_sum(1, 2, 4, 5))
list1 = [1, 2, 3, 4]
tuple1 = (0, 2, 4, 6, *lsit1)  # * 参数分解
# * 参数分解
print(get_sum(*list1))
print(get_sum(*tuple1))
```

#### 关键字参数

- 关键字参数使用 `**` 标示，同样在函数定义或者调用时可以使用
- 与可变参数相似，但是关键字参数组装或分解的是 **dict** 结构
- 关键字参数在调用传参时，参数要写成 `key = value` 的形式(**key不能写成字符串形式**)，方法中会将参数转化成指定key和value的一个dict
- 在组装dict对象是，也可以使用 `**` 将另一个dict 的内容复制给目标dict：`{"name":“Marx", **dict2}`
- `def func(name, *, age, gener)` 中的 `*,` 表示后面的参数都是关键字参数(**命名关键字参数**)，即限定了只能传某些特定关键字的参数，并且这些关键字参数也可以设置默认值

```python
# 关键字参数
def enroll(name, gender, **other):
    return {"name": name, "gender": gender, **other}

def hello(name, *, gender, age=6):
    return {"name": name, "gender": gender, "age": age}

print(enroll("Marx", "F"))
print(enroll("Marx", "F", age=10))
ming = {"gender": "F", "name": "Ming", "age":10, "score": 100}
print(enroll(**ming))
print(hello("Ming", gender="F"))
# print(hello("Ming", "F"))  # TypeError: hello() takes 1 positional argument but 2 were given
# print(hello("Ming", gender="F", city="NY"))  #TypeError: hello() got an unexpected keyword argument 'city'
```

#### 组合参数

python中的多种类型的参数，可以在一个方法定义中组合使用，声明的顺序是：

> 必选参数、默认参数、可变参数、命名关键字参数和关键字参数

```python
def f1(a, b, c=0, *args, **kw):
    pass

def f2(a, b, c=0, *, d, **kw):
	pass
```

# list, dict特性

### 切面(slice)
一种数组的截取快捷方法，使用 `list1[m:n:x]` 的形式
- 包头不包尾
- n > m, m 和 n 为元素索引，0 表示第一个元素，-1表示最后一个元素
- m 省略默认是 **0**，n 省略表示 **-1+1**，指 **包括最后一个元素**
- x 为步长，每次取值间隔的个数，从m的位置开始计算，最后一个 `:x` 省略默认是1
- `list1[:]` 表示将原数组拷贝一份(不同实例)

```python
n100 = list(range(0, 100))
print(n100)
print(n100[0:10])
print(n100[:5])
print(n100[10:15])
print(n100[-5:-1])
print(n100[-1:-5]) # []
print(n100[-4:0]) # []
print(n100[-10:])
print(n100[0:20:2])
print(n100[::2])
print(n100[-30::3])
print(n100[:] is n100)
```

对 tuple 和 str 也适用这种操作，并且输入的数据源是什么类型的数据结构，输出的结果是相同类型的数据

### 遍历(iterator)
python 中对数组，列表或字符串的遍历是使用 `for  in` ，而没有使用索引遍历的形式，而这种遍历方式同样可以用于dict

- 遍历key：`for key in dictX`
- 遍历value：`for value in dictX.values()`
- 遍历键值对：`for key, value in dictX.items()`

```python
nameDict = {
    "ming": "XIAO",
    "hong": "DA",
    "gang": "LI",
    "liang": "PIAO"
}

print("------- 按key进行遍历 --------")
for name in nameDict:
    print(name)

print("------- 按value进行遍历 --------")
for value in nameDict.values():
    print(value)

print("------- 按key, value进行遍历 --------")
for key, value in nameDict.items():
    print("%s : %s" % (key, value))
```

### 列表生成式(List Comprehensions)
python中对数组的map和filter操作的一种实现，使用 `[exp for x in list1 if condition]` 的像是
- `exp` 相当于map中的转化规则
- `condition` 就是filter中的过滤条件
- 先执行 **filter**， 再进行 **map**
- 多个`for`嵌套可以用 `[exp for x in list1 for y in list2 if condition]` 的形式，**y** 是内层循环的元素

![列表生成器](pic/列表生成器.png)
```python
n20 = list(range(0, 20))
print("----- 类似于map操作 -----")
halfN20 = [n/2 for n in n20]
print(halfN20)

print("----- 类似于filter操作 -----")
evenOfN20 = [n for n in n20 if n % 2 == 0]
print(evenOfN20)

print("----- 类似于filter + map操作 -----")
evenOfN20PlusOne = [n+1 for n in n20 if n % 2 == 0]
print(evenOfN20PlusOne)

print("----- 嵌套 -----")
print([x + y for x in 'ABC' for y in 'XYZ'])
print([x + y for x in 'ABC' for y in 'XYZ' if x != 'B'])
```

### 生成器(generator)

- 一边循环一边计算
- 减少对不必要的元素的计算和内存存储
- 生成器类似一种数据结构，可以直接遍历

#### 1. 使用列表生成式创建生成器

- 将列表生成式的方括号`[]`换成tuple的圆括号`()`，返回的结果就是一个生成器对象

#### 2. 函数中使用 `yield` 关键字

- 在函数定义中，使用 `yield` 关键字，这样每次函数调用后不会直接返回return的值，而是返回一个生成器对象
- `yield` 关键字的用法与 `return` 相似，它指定每次生成器迭代返回的值
- 一个函数中可以有多个 `yield` 关键字，生成器迭代时会按顺序依次返回每个 `yield` 的值
- 函数中 `return` 的结果将无法正常返回，只能在发生 `StopIteration`  异常时获得

#### 3. `next()` 函数对生成器进行迭代

- 生成器类似于游标，`next` 函数每次执行会返回生成器代签游标所在的值，在将游标向前移动一位
- `next` 函数的参数是一个 生成器对象
- 当前游标没有值是，会抛出 `StopIteration` 异常
- 使用 `yield` 的生成器每次执行 `next` 函数时，会依次返回 `yield` 的值 

#### 4. `for` 循环迭代生成器

- 可以使用 `for` 循环像遍历列表一样遍历生成器，而且不用担心游标越界的问题
- `for` 遍历的起点是生成器当前游标的位置

#### Example

```python
g1 = (x for x in range(10) if x%2 == 0)
print(next(g1))  # 0
print(next(g1))  # 2
print(next(g1))  # 4
print("-------------")

for x in g1:
    print(x)  # 6 8
```

```python
def fibonacci(length):
    n, pre, cur = 0, 0, 1
    while n < length:
        yield cur
        pre, cur = cur, pre + cur
        n = n + 1
    return "done"

fib1 = fibonacci(3)
print(next(fib1))  # 1
print(next(fib1))  # 1
print(next(fib1))  # 2
# print(next(fib1))  # StopIteration: done

for f in fibonacci(8):
    print(f)  # 1 1 2 3 5 8 13 21
```

### 迭代器(Iterator)

- **Iterable**: 可迭代对象，能使用 `for` 进行遍历的对象，包括： `list`，`tuple`，`dict`，`set`，`str` 和 `generator`
- **Iterator**: 迭代器，能使用 `next()` 一次调用返回下一个值的对象，一般只有 `generator`
- Python的 `Iterator` 对象表示的是一个数据流，可以被 `next()` 函数调用并不断返回下一个数据，直到没有数据时抛出 `StopIteration` 错误。可以把这个数据流看做是一个有序序列，但我们却不能提前知道序列的长度，只能不断通过 `next()` 函数实现按需计算下一个数据，所以 `Iterator` 的计算是 **惰性** 的，只有在需要返回下一个数据时它才会计算。
- 迭代器可以减少内存的占用，带相对在使用时计算上会比较耗时

#### isinstance函数判断对象是类型

- `isinstance(对象, 类名)` 判断对象是否为指定的类型，返回 `True` 或 `False`

#### iter 函数将可迭代对象转换成迭代器

- `iter(对象)` 将一个可迭代对象转换成迭代器对象

#### Example

```python
from collections import Iterable, Iterator

list1 = range(8)
tuple1 = ("a", "x", "h")
str1 = "hello world"

print(isinstance(list1, Iterable))  # True
print(isinstance(tuple1, Iterable))  # True
print(isinstance(str1, Iterable))  # True
print(isinstance(list1, Iterator))  # False

print(isinstance(iter(list1), Iterator))  # True
print(isinstance(iter(str1), Iterator))  # True

iterStr1 = iter(str1)
print(next(iterStr1))  # h
for s in iterStr1:
    print(s)  # e l l o   w o r l d
```

# 运行程序

python中类似于 `main` 方法执行程序

```python
if __name__=='__main__':
    test()
    ...
```

当在命令行运行包含这个语句的模块文件时，Python解释器把一个特殊变量 `__name__` 置为 `__main__` ，这样 `if` 语句就能顺利执行，而运行其他引用该模块的模块是，则不会执行

# 模块

### 模块安装

- python的包管理器是 **pip** , 使用方法类似于 node.js 的 **npm**

- python发布的包一般都会在 **[pypi.org](https://pypi.org)** 上进行注册
- **[Anaconda](https://www.anaconda.com)**是一个基于Python的数据处理和科学计算平台，它已经内置了许多非常有用的第三方库

### 引用模块的方法

#### 1. import 内置模块

```python
import sys  # 导入python内置的sys模块
from functools import reduce  # 导入模块中的某个变量后方法
```

导入的 `sys` 相当于一个对象，通过这个对象可以访问模块中的变量和方法

### 作用域

- 在python中，一个文件就相当于一个模块
- 模块中直接定义的变量或者方法都是可以被其他模块引用的
- 正常定义的变量和方法都是 **public** 级别的，可以使用 下划线`_` 或双下划线 `__` 作为前缀定义**private** 的变量或方法
- python中的 **private** 的并不是绝对的私有，在其他模块中依然可以引用，只是习惯将这种形式的作为私有的而已
- 对于每个模块还有一些内置的变量或方法，以 `__` 作为开头和结束，如：`__name__` `__author__` `__doc__`

### 内置属性

#### 1. \_\_name__

每个模块或方法都有一个 `__name__` 属性，方法的 `__name__` 属性是方法名，执行的模块的 `__name__` 属性是 `__main__`

functools 内置模块提供了一个wrap装饰器，可以将装饰的方法的 `__name__` 属性设置为指定方法的 `__name__` 属性：`@functools.wraps(func)`

# 函数式编程

`map` `reduce` `filter` `sorted` 是 python的内建函数，可以从 `functools` 模块中引用得到

### 1. map

- `map(func, Iterable)`  => `Iterator`
- `func` 函数接收列表中的一个元素，输出成另一个值

### 2. reduce

- `reduce(func, Iterable)`  => `any`
- `func` 的第二个参数会依次接收列表中的值，第一个参数为每次函数的返回值

### 3. filter

- `filter(func, Iterable)`  => `Iterator`

### 4. sorted

- `sorted(Iterable, key=func, reverse=bool)` => `Iterable`
- `key` 会作用于列表汇总的每个元素，再根据结果进行排序， 它并不会改变原有列表

### 5. 闭包(Closure) 返回函数

- python同样支持将函数作为返回值，因此可以在函数内使用 `def` 定义新的函数作为返回值

- 与JS一样，python的闭包也同样好用

### 6. 匿名函数 & lambda表达式

- python中使用 **lambda** 关键字编写匿名函数

```python
lambda x: x * 2
lambda x: x > 2
lambda x, y: x + y - 2
```

- lambda 表达式使用 冒号`:` 分隔参数和方法体，左边是参数列表，右边是方法体
- 方法体只能有一个表达式，表达式的结果就是函数的返回值，不用写 `return` 关键字

### 7. 装饰器(decorator)

- 在不改变原有函数的定义语句的情况下，对函数进行进一步的封装
- 能代码运行期间动态增加功能
- 装饰器是一种 **接受函数** 作为参数，同时返回 **函数** 的一种函数，返回的函数对作为参数的函数功能进行了增强
- 注释器返回的函数的参数列表通常是 `*args, **kw` , 以满足原有函数的所有参数需要

```python
# 直接接受方法的装饰器
def log(func):
    def wrapper(*args, **kw):
        print('call %s():' % func.__name__)
        return func(*args, **kw)
    return wrapper

# 代参装饰器
def log_param(text):
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kw):
            print('%s %s():' % (text, func.__name__))
            return func(*args, **kw)
        return wrapper
    return decorator
```

- 可以调用装饰器将目标方法作为参数进行装饰，或者使用注解 `@` 将装饰器对象添加到目标方法上，这两种方式都能返回装饰后的方法

```python
adder = log(add)  # 调用函数的方式添加装饰器

@log  # 注解的方式添加装饰器
def add(a, b):
    return a + b

@log_param("加法")  # 代参的装饰器
def add(a, b):
    return a + b
```

- 装饰器会改变原有函数的 `__name__` 属性，因为装饰器是返回装饰后的函数，可以使用 `functools` 模块的 `wraps` 装饰器，对装饰器返回的函数进行 `__name__` 属性的绑定 ：`@functools.wraps(func)`

### 8. 偏函数(Partial function)

- 把一个函数的某些参数给固定住（也就是设置默认值），返回一个新的函数，调用这个新函数会更简单
- 这个新函数同样支持固定参数值的修改，只需在调用时在参数列表中传递参数即可
- `functools` 模块的 `partial` 函数可以直接创建偏函数： `functools.partial(函数对象, *args, **kw)`

```python
int2 = functools.partial(int, base=2)  # 固定base参数是2
int2("101")  # 5

maxStart10 = functools.partial(max, 10)  # 固定第一个参数是10
maxStart10(3, 9, 5, 7)  # 10
```

# 面向对象(OOP)

### 类与实例

```python
class Student(object):
	def __init__(self, name, age):
		self.name = name
		self.age = age
	def print_info(self):
		print('name: %s age: %s', (self.name, self.age))
 
ming = Student("ming", 18)
ming.print_info()
ming.id = 1234
```

- `class` 关键之定义一个类
- 类名后的括号表示父类，没有指定的父类时，指定父类为 `object`
- `__init__` 为构造方法，不写 `__init__` 方法时，默认有一个无参的构造方法
- 类中定义方法与一般定义方法的方式没有区别，使用 `def` 关键字定义方法
- 类中的每个方法一般情况下第一个参数都是 `self` ，表示类的对象本身，而在调用类的方法时，不必传递 `self` 参数
- 创建类的对象时，直接使用 `类名(参数)` 的形式，不用 `new` 关键字
- python 的类对象和普通对象一样，可以在类定义之外，为对象任意添加属性

------

```python
import 文件名 as 自定义别名
```

## 数据分析依赖：数据质量，静态特征，行为特征
## 数据分析：
1. 了解业务
2. 方法论
3. 分析方法
4. 工具：软件，语言
5. 统计思维
