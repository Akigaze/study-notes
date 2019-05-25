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
* 创建只有一个元素的tuple时，元素后面要加逗号 `tuple1 = (4,)`
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

### dict()

- `dict()` 创建一个空的字典对象
- `dict([("key": value), ...])` 接收一个tuple的list，将tuple的第一个元素作为key，第二个元素为value

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
- 当 **tuple** 作为方法参数时，如果只有一个元素，可以省略括号

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

#### 1. import 模块

```python
import sys  # 导入python内置的sys模块
from functools import reduce  # 导入模块中的某个变量后方法
import 模块 as 模块别名  # 是指模块别名
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

# 常用模块

## 1. datetime

`datetime` 模块中的 `datetime` 类用于创建时间的对象：`from datetime import datetime`

- `datetime.now()` : 获取当前时间的datetime对象
- `datetime(year, month, day, hour, minute, second,  millisecond)` : 创建指定时间的datetime对象
- `datetime` 对象是有时区概念的，不指定时区的datetime对象时区是服务器时区

#### 时间戳 timestamp

- python的时间戳是一个浮点数，小数的部分表示毫秒数
- 1970年1月1日 00:00:00 UTC+00:00 这个时间的时间戳记为 **0**
- 与datetime对象不同，时间戳是没有时区概念的
- 使用datetime对象的 `timestamp()` 方法可以获得该对象的时间戳
- `datetime.fromtimestamp(timestamp)` : 将时间戳转成datetime对象
- `datetime.utcfromtimestamp(timestamp)` : 将时间戳转成utc 的 datetime对象

#### datetime与字符串的转换

- `datetime.strptime('datetimeStr', 'format')` : 字符串转时间对象
- `datetimeObj.strftime('format')` : 时间对象转字符串
- 时间格式占位符：`%Y 年` `%m 月` `%d 日` `%H 小时` `%M 分钟` `%S 秒` `%a 星期` `%b 英文月份`

#### datetime运算

- 时间的加减需要用到 `datetime` 模块中的 `timedelta` 类：`from datetime import timedelta`
- `timedelta` 函数提供了多种时间参数，`days` `seconds` `microseconds` `milliseconds` `minutes` `hours` `weeks` ，指定不同的时间进行加减
- 运算时只需使用 加号或减号进行运算即可：`datetimeObj - timedelta(hours=10)`

#### 时区

- datetime对象的 `tzinfo` 属性记录时区信息，但是这个属性的值必须手动指定，否则为 `None`
- `datetime` 包的 `timezone` 类用于创建timezone对象：`from datetime import timezone`
- `timezone` 对象需要一个 `timedelta` 对象，用于指明时间差：`timezone(timedelta(hours=8))`
- 使用datetime 对象的 `replace` 方法可以设置datetime对象的各种属性，其中就包括 `tzinfo` : `datetimeObj.replace(tzinfo=timezoneObj)`
- `datetime.utcnow()` 方法获取当前的UTC时间对象
- `timezone.utc` UTC的timezone对象
- `tzinfo` 只是设置时区信息而已，并不会改变时间的表示
- datetime对象的 `astimezone` 方法可以输出对象在不同时区的当地时间：`datetimeObj.astimezone(timezoneObj)`

```python
from datetime import datetime, timedelta, timezone

now = datetime.now()
a_datetime = datetime(2019, 1, 1, 12, 30, 10, 22)
now_stamp = now.timestamp()
b_datetime = datetime.fromtimestamp(10001901902.0909)
utc_now = datetime.utcfromtimestamp(now_stamp)

print(now)
print(a_datetime)
print(now_stamp)
print(b_datetime)
print(utc_now)
print(a_datetime.astimezone())
print("----------")
print(now.strftime("%Y-%m-%d %H:%M:%S"))
print(now.strftime("%a, %b %d %H:%M"))
print(datetime.strptime("Mon, May 05 16:28", "%a, %b %d %H:%M"))
print("----------")
print(now - timedelta(hours=10))
print(now.tzinfo)
print("***********")
# now.replace(tzinfo=timezone.utc)
# print(now.astimezone())
# now.replace(tzinfo=timezone(timedelta(hours=3)))
print(now.astimezone(timezone.utc))
print(now)
```

## 2. collections

### 2.1 namedtuple()

- `from collections import namedtuple` : `namedtuple` 方法可以创建具名的tuple封装类
- 规定了tuple封装类的类名，每个值对用的属性名
- 用一个对象接受 `namedtuple` 函数返回的类，就可以创建具名的tuple对象了
- `ClassName = namedtuple("ClassName", ["field1", "field2", ...])`
- 使用tuple封装类创建tuple对象的方法和创建类的对象一样
- 可以使用索引访问tuple中的元素，也可已使用属性名
- 具名的tuple对象的 `_asdict()` 方法可以将tuple对象转成一个 `OrderedDict` 对象

```python
from collections import namedtuple

Point = namedtuple("Points", ["x", "y"])
p1 = Point(x=1, y=3)

print(p1)
print(p1.y + p1.x)
print(p1[0] - p1[1])
print(p1._asdict())
```

### 2.2 deque()

- `deque` 方法可以把一个list对象转成一个队列
- 队列对象除了 `append()` 和 `pop()` 外，还支持 `appendleft()` 和 `popleft()` ，从头部添加或删除元素

```python
from collections import deque

queue = deque([2, 4, 6, 1])

queue.pop()
queue.append("x")
queue.appendleft("Y")
print(queue)
queue.popleft()
print(queue)
```

### 2.3 defaultdict

- `from collections import defaultdict` 
- `defaultdict` 类用于创建字典对象
- 接收一个函数作为参数，当访问的属性在创建的字典对象中不存在时，会执行该函数
- 作为参数的函数貌似不能接收任何参数
- 只在使用索引访问属性时生效，使用 `get` 方法不生效

### 2.4 OrderedDict

- `from collections import OrderedDict`
- 普通的字典对象中的键值对是会根据key进行排序，而 `OrderedDict` 类可以根据键值对设置的顺序，创建键值对有序的字典对象

### 2.5 ChainMap

- `from collections import ChainMap`

### 2.6 Counter

`from collections import Counter`

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
- python 的类对象和普通对象一样，可以在类定义之外，任意访问对象的属性或添加，修改属性
- 如果访问一个不存在的属性，会抛出异常

### 私有属性

- 在python中，使用命名的方式来是指属性的访问级别
- 私有属性的命名，以 双下划线 `__` 开头，python的解释器会识别这样的属性名，将其设置成私有属性
- 然而，python并没有绝对的私有属性，只是python的解释器在对外暴露属性时，给将私有属性换了个名字而已，不同的解释器更换属性名的方式不一样

```python
class Student(object):
    def __init__(self, name, address):
        self.name = name
        self.__address = address  # 私有属性

    def get_address(self):
        return self.__address

    def set_address(self, address):
        self.__address = address

ming = Student("小明", "广州市")
print(ming.name)
print(ming.get_address()
print(ming.__address)  # Error and return None
ming.__address = "北京市"
print(ming.__address)  # 北京市 不是类内部的__address 属性
print(ming._Student__address)  # 被重命名的__address 属性
```

### 继承与多态

- python的继承是在类定义时，类名后面的括号指明父类
- python的类继承同样支持多态，重载，子类可以调动，重写父类的方法

### 获取对象信息

#### 1. 对象类型

##### 1.1 type(obj)

- `type` 方法可以返回指定对象的 **Class** 类型
- `types` 模块提供了 **Class** 类型的定义，可以与对象类型的判断：`FunctionType` `BuiltinFunctionType` `LambdaType` `GeneratorType`

##### 1.2 isinstance(obj, type_tuple)

- `isinstance` 方法可以判断对象是否为指定的 **Class** 类型， 返回 `True` 或 `False`
- 第二个参数是一个tuple，所以可以传多种类型，判断是否是其中一种

#### 2. 对象信息

##### 2.1 dir(obj)

- `dir` 方法会返回一个字符串的list，里面包含了对象所有属性的名称，包括普通属性，内置属性，私有属性和方法

##### 2.2 hasattr(obj, 'attr')

- 判断对象是否有指定名称的属性或方法

##### 2.3 getattr(obj, 'attr')

- 获取指定对象指定属性或方法的值
- 试图获取不存在的属性，会抛出 `AttributeError` 的错误

##### 2.4 setattr(obj, 'attr', value)

- 为对象设置指定的属性和属性值

### 类属性

- 类属性类似于静态属性，但又不同于静态属性
- 类属性的定义就是在类的作用域中定义变量，与定义局部变量的方式一样
- 通过类或类的实例都可以访问到类属性
- 如果实例属性和类属性同名，实力属性的优先级高于类属性
- 类的实例可以获得类属性，但通过 `obj.classAttr = value` 的方式无法修改类属性，这种方式会添加一个域类属性同名的实例属性，将类属性屏蔽掉

```python
class Student(object):
    school = "SCAU"  # 类属性

    def __init__(self, name):
        self.name = name

ming = Student("小明")
print(ming.school)  # SCAU
print(Student.school)  # SCAU
ming.school = "ABC"  # 添加实例属性，屏蔽类属性
print(ming.school)  # ABC
print(Student.school)  # SCAU
del ming.school  # 删除实例属性，重新使用类属性
Student.school = "XYZ"  # 修改类属性
print(ming.school)  # XYZ
print(Student.school)  # XYZ
del Student.school  # 删除类属性
print(ming.school)  # AttributeError
print(Student.school)  # AttributeError
```

### 绑定属性

#### 1. \_\_slots__

- `__slots__` 是python类的一个内置属性，用于指定类的实例可以自定义哪些属性
- `__slots__ = ("name", "age")` 赋值一个字符串的tuple，这样类的实例就只能定义或添加属性，添加其他属性时会抛出 `AttributeError` 异常
- 该属性只会限制使用 `self` 添加的属性和 使用类实例动态添加的属性，而不会限制类中方法的定义和类属性的定义

### 方法装饰器 @property

- `@property` 装饰器，能够将类的方法转换成属性，在类的内部或者是实例都变成了属性使用
- `@property` 装饰后的属性名与方法名相同，所以方法名通常定义成属性名
- `@property` 装饰一个方法的同时，会自动生成一个与该方法同名的装饰器，新的装饰器提供了 `setter` 等装饰器，用于为属性指定setter方法
- 通常 `@属性名装饰器.setter` 这个装饰器装饰的方法名，与属性名相同，这样才能保持属性的访问和赋值时名称的一致
- `@property` 装饰的一般是属性的getter方法， `@属性名装饰器.setter` 装饰setter方法，这种情况下，这两个方法可以同名
- `@property` 装饰后的方法将不能在当做方法使用

```python
class Book(object):
    def __init__(self, name, price):
        self.name = name
        self.__price = price

    @property  # 提供属性访问器
    def price(self):
        return self.__price

    @price.setter  # 提供属性设置器，并有校验条件
    def price(self, price):
        if isinstance(price, int):
            if price <= 0:
                raise ValueError('price must bigger than 0!')
            else:
                self.__price = price
        else:
            raise ValueError('price must be an integer!')
            
     def reset(self):
        self.price = 100  # OK
        self.price(100)  # TypeError: 'int' object is not callable


book1 = Book("东野圭吾", 100)
print(book1.name)
print(book1.price)
book1.name = "米泽"
book1.price = 100.1  # 异常：price must bigger than 0!
print(book1.name)
print(book1.price)
book1.price(20)  # TypeError: 'int' object is not callable
```

### 多重继承

- python的类是支持多继承的，只需在类名后面的括号用逗号分隔多个父类即可
- 当多个父类有相同属性或方法时，按继承的顺序从 **左到右**，优先级逐渐降低
- 设计多继承时，会考虑一个主要的父类，其他的父类相当于是功能的辅助，在python中称为 `MixIn`，就是在类命名时以 `MixIn` 结尾，依次类表示是一种辅助型的父类

#### 1. super()

- 在子类中，可以使用 `super()` 方法获取父类对象的引用，以此来调用父类的方法
- `super()` 实际是 `super(子类, self)` 的简写，第一个参数是一个类，第二个参数是该类的一个实例，`super` 方法会返回给定类的一个父类实例

### 定制类，内置属性和方法

- python的类有许多内置的属性和方法，这些其实都是继承自 `object` 基类的，都可以重写以更好的定制类

#### 1. \__str__()

`__str__` 类似于 `toString` 方法

#### 2. \__repr__()

`__repr__` 的默认实现是对 `__str__` 方法的调用，可以在不用 `print` 方法的情况下输出对象的信息

#### 3. \__len__()

python内置的 `len()` 方法，返回对象的长度，实际上就是调用对象的 `__len__` 方法

#### 4. \_\_iter__() 与 \_\_next\_\_()

如果一个类想要支持 `for...in...` 的遍历，就必须实现 `__iter__`  和 `__next__` 方法

-  `__iter__`  用于返回一个 `Iterator` 对象，当变量被放到 `for...in...` 的 `in` 之后时，就回调用该变量的 `__iter__` 方法，返回一个可遍历的对象
-  `__next__` 方法作用域 `for...in...` 的 `for` 和 `in` 之间，每次迭代时，会调用 `__iter__` 方法返回的对象的 `__next__` 方法，获取当前遍历的值，直到遇到 `StopIteration` 异常为止
- 所以想要实现一个支持 `for...in...` 的类，需要同时实现 `__iter__` 和 `__next__` 方法， 且 `__iter__` 方法通常返回 `self` ，这样才能保证在迭代时调用的是该类的 `__next__` 方法

```python
class Fibonacci(object):
    def __init__(self, length=0):
        self.pre = 0
        self.cur = 1
        self.cursor = 0
        self.length = length

    def __iter__(self):
        # return iter([1, 2, 3])
        return self

    def __next__(self, i):
        if self.cursor >= self.length:
            self.cursor = 0
            raise StopIteration()
        else:
            self.pre, self.cur = self.cur, self.pre + self.cur
            self.cursor += 1
            return self.pre


fib = Fibonacci(10)
for f in fib:
    print(f)
```

![](F:\学习\study-notes\Python\pic\iter and next.png)

#### 5. \__getitem__(n)

- `__getitem__` 方法可以实现对象像列表那样支持使用索引(`[index]`)或切片(`[a:b]`)取值

- 参数 `n` 可以是一个数字 `int` ，也可以是一个切片`slice`，所以需要在方法内部进行判断，选择处理方式

```python
class Fibonacci(object):
    def __getitem__(self, item):
        a, b = 1, 1
        # 普通索引取值
        if isinstance(item, int):
            for n in range(item):
                a, b = b, a + b
            return a
        # 切片取值
        if isinstance(item, slice):
            start = item.start
            stop = item.stop
            if start is None:
                start = 0
            result = []
            for n in range(stop):
                if n >= start:
                    result.append(a)
                a, b = b, a + b
            return result
        

fib = Fibonacci()
print(fib[0])  # 1
print(fib[1])  # 1
print(fib[2])  # 2
print(fib[2:10])  # [2, 3, 5, 8, 13, 21, 34, 55]
```

与 `__getitem__()` 一起的，还有 `__setitem__()` 和 `__delitem__()` 等方法

#### 6. \__getattr__(n)

- python的对象可以直接用 `obj.attr` 的形式访问属性值，而当访问的属性不存在时，会抛出 `AttributeError` 异常
- `__getattr__` 方法只在访问的属性不存在时别调用，可用于处理对不存在的属性的访问
- 参数 `n` 是访问的属性名的字符串

```python
class Book(object):
    def __init__(self, name, price):
        self.name = name
        self.__price = price

    def __getattr__(self, item):
        if item == "real_price":
            return 10000
        # return 0
        raise AttributeError('%s no attribute %s' % (self.__class__.__name__, item))

        
book1 = Book("东野圭吾", 100)      
print(book1.name)  # 东野圭吾
print(book1.real_price)  # 10000
print(book1.abc)  # AttributeError
```

#### 7. \__call__(*args, **kwargs)

- python中处理函数可以调用之外，对象也是可以被调用的，即把对象当成方法，此时只需要实现 `__call__` 方法即可

- 使用python内置的 `callable(obj)` 函数可以判断一个对象是否可以被调用

```python
class Book(object):
    def __init__(self, name, price):
        self.name = name
        self.__price = price
        
    def __call__(self, *args, **kwargs):
        print("%s's price is %d, %s, %s" % (self.name, self.__price, args, kwargs))
        
book1 = Book("东野圭吾", 100)
book1("123", a=100)  # 东野圭吾's price is 100, ('123',), {'a': 100}
```

### 枚举(Enum)

- python 的枚举类位于 `enum` 包中：` from enum import Enum`
- `Enum` 也是一个类，所以要得到一个枚举类型，就要编写一个继承 `Enum` 的类， 或直接使用 `Enum` 的构造方法创建枚举类型

#### 1. 直接使用 `Enum` 构造枚举

`Enum("enum_name", ("member1", "member2", ...))`

```python
Month_12 = Enum('Month', ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
```

`Month_12` 只是对枚举类的引用，正面的枚举名称是 `Month`

#### 2. 继承 `Enum` 类

```python
from enum import Enum, unique

@unique
class Weekday(Enum):
    SUN = 0
    MON = 1
    TUE = 2
    WEN = 3
    THU = 4
    FRI = 5
    SAT = "6"
    
print(Weekday.WEN)  # Weekday.WEN
print(Weekday["FRI"])  # Weekday.FRI
print(Weekday("6"))  # Weekday.SAT
print(Weekday(1))  # Weekday.MON
```

- 直接像定义类属性一样，定义枚举的成员
- `enum` 包的 `@unique` 装饰器可以检查是否有值重复的枚举成员

#### 3. 获取枚举成员

- `枚举类.成员名称`
- `枚举类.["成员名称"]`
- `枚举类(成员的值)`
- `Weekday.__members__["成员名称"]` : 枚举类的 `__members__`  属性可以返回所有成员的一个 `OrderedDict` 对象

#### 4. 获取枚举成员的值

通过枚举成员的 `value` 属性可以获取成员的值

#### 5. 枚举类的属性

- `__member__` : 返回所以成员的一个 `OrderedDict` 对象，这种字典类型是有序的，且只能用索引的方式取值

### 元类

#### 1. type()

- `type()` 函数不仅可以获取对象的类型，还能用于创建类
- `AClass = type("className", (superClass1, superClass2,...), {attr1: value1, attr2: value2,...})`

```python
def fn(self, name="world"):
    print("hello %s" % name)

Hello = type('Hello', (object,), {"hello": fn})

h1 = Hello()
h1.hello()
h1.hello("QQ")
```

#### 2. metaclass

- python的metaclass使用与动态定制类的，在实现 **ORM** 框架是有重要作用
- **metaclass** 也是一种类，只是它继承的是 `type` 父类，而不是 `object` ，一般元类命名会以 **MetaClass** 结尾
- 元类可以在类定义时动态地为类添加属性和方法，可以理解为元类是类的构造方法
- 类定义时在父类列表后面添加 `metaClass` 参数指定元类
- 在元类中需要实现 `__new__` 方法对要创建的类进行处理

![](F:\学习\study-notes\Python\pic\metaclass.png)