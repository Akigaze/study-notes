Python基础
===

# 数据结构
## 1. list(列表)
```
a = [...]
 ```
* 元素可变，元素类型随意
* 支持排序
* 按值查找麻烦
## 2. tuple(序列，元组)
```
B = (...)
```
* 不可变
* 本身不排序
* 适合存放不可变的内容
## 3. dic(字典)
```
C = {key:value,...}
```
* 键值对的形式存储数据
# 流程控制语句
## 1. if...else
```python
age = 20
if age <= 18:
    print("未成年人。")
elif age<=40:
    print("中年人。")
else:
    print("老年人。")
```

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
