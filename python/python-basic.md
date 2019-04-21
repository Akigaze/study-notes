Python基础
===

### 输入与输出

1. 输出：`print(a, b, c, ...)`
2. 输入：`input('tip')` ，`'tip'` 是在输入用户之前打印的文本，为可选参数 

### 注释

```python
# 这是python注释
```

### 数据类型

#### 1. 整数，浮点数

- python 没有 `++` 或者 `--` 的操作

#### 2. 字符串

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

#### 3. 布尔值

1. `True` 和 `False`
2. 运算符：`and` `or` `not`

#### 4. 空值

1. `None`

#### 5. 类型转化

- str --> number：`int(str)` 将字符串转化成正数，参数必须是一个整数的字符串 (异常：`ValueError`)

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



# 流程控制语句
### 1. if...else

- 在 `if` 的条件之后或者 `else` 之后，要带上冒号 `:`
- `else if` 在python中写成 `elif`
- 与JavaScript相似， `if` 的判断条件不一定要是 `True` 或 `False` ，**非零数值**、**非空字符串**、**非空list**等，就判断为 `True`，否则为 `False`。

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

# 定义函数

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
导入函数
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
