# IO操作

## 文件读写

### 1 open()

- python内置的 `open` 可以打开与磁盘上一个文件的连接，实现文件读写操作：`open("文件路径", "操作标识符")`
- `open` 函数会返回一个文件操作的流对象，是一种 **上下文管理对象** ，所以在使用结束后一定要调用 `.close()` 方法释放资源，或者使用 `with` 语句进行上下文自动管理
- 通过文件流对象读取文件信息有一下方法：
  - `.read()` : 一次性全部读取到内存
  - `.read(size)` : 指定读取的字节数
  - `.readline()` : 只读取一行数据
  - `.readlines()` : 读取所有行，返回一个list，每行为一个元素
- 写入文件数据：
  - `write()` : 将给定的字符串或字节码写入文件，若 `open` 指定了 `encoding` 参数，字符串会做相应的编码再写入文件
- 在读模式下，当 `open` 的文件不存在时，会抛出 `FileNotFoundError` 异常
- 在写模式下，文件不存在时，会自动创建文件

#### 参数

- `encoding` 参数指定文本的编码，以便正确读取内容
- `errors` 参数设置在读取过程中遇到异常的处理方式，有 `strict` 和 `ignore` 两种模式

### 2 file-like Object

具有流操作的 `read()` 方法的对象，如：字节流，网络流，自定义流，StringIO等

### 3 操作表示符

> 'r'       open for reading (default)
> 'w'       open for writing, truncating the file first
> 'x'       create a new file and open it for writing
> 'a'       open for writing, appending to the end of the file if it exists
> 'b'       binary mode
> 't'       text mode (default)
> '+'       open a disk file for updating (reading and writing)
> 'U'       universal newline mode (deprecated)

使用时可以多种模式组合

##### 常用模式

- `r` : 只读，以字符串形式读取，一般只有文本文件才能使用这种模式
- `rb` : 只读，以字节的方式读取文件内容，针对二进制文件使用
- `w` : 写模式，写入字符串，会把原有内容全部覆盖
- `wb` : 写模式，写入字节码，同样会覆盖原有内容
- `a` : 追加写入模式，写文本
- `ab` : 追加写入模式，写二进制

### 4 StringIO和BytesIO

`StringIO` 和 `BytesIO` 是针对 字符串和 字节码在内存中读写的类，用法基本相同，和文件操作相似，但是；位于 `io` 包中：`from io import StringIO, BytesIO`

1. 构造方法创建流对象: `f = StringIO()` `f = StringIO('Hello!\nHi!\nGoodbye!')` `f = BytesIO()`
2. 同样有 `read` 和 `wirte` 相关的方法
3. `getvalue()` 将流中的数据输出为字符串
4. `BytesIO` 读写的是字节码，所以写入或读取输出都要做编码和解码

## 目录操作

python 的 `os` 模块提供了读取操作系统信息和调用操作系统API的方法

- `os.name` : 操作系统名称: `posix`  = Linux/Unix/Mac，`nt` = Windows
- `os.environ` : 环境变量的dict
- `os.path` : 文件目录操作相关的模块
- `os.mkdir()` : 创建目录
- `os.rmdir()` : 删除目录
- `os.rename()` : 文件重命名
- `os.remove()` : 文件删除
- `os.listdir()` : 获取指定路径的子目录，包括文件和目录
- `os.getpid()` : 获取进程的 **PID**

`os.path` 模块根据操作系统提供了跟路径相关的操作，但基本上只是字符串的处理而已，真正要把变化应用到磁盘上还要用 `os` 的方法

- `os.path.abspath()` : 获取给定相对路径的绝对路径， `.` 表示文件所在目录
- `os.path.join(path, *paths)` : 拼接路径，根据操作系统使用拼接符号，返回拼接后的字符串
- `os.path.split()` : 将给定路径中的文件和目录分离，实际上只是把目录的最后一级做为文件而已，返回`("path", "fileName.ext")`
- `os.path.splitext()` : 将给定路径中的文件扩展名和文件目录分离，实际上是分离目录最后一级的`.` 之后的扩展名，返回`("path/fileName", ".ext")`
- `os.path.isfile()` `os.path.isdir()`

```python
import os

print("操作系统：%s" % os.name)
print("PATH 环境变量：%s" % os.environ.get("PATH"))
os.mkdir("E://PythonStation//get-start//123")
for d in os.listdir("E://PythonStation//get-start"):
    print(d)

print("---------------")
os.rmdir("E://PythonStation//get-start//123")
# os.rename("E://PythonStation//get-start//yaya.txt", "E://PythonStation//get-start//123.txt")
for d in os.listdir("E://PythonStation//get-start"):
    if os.path.isdir(d):
        print("dir: %s" % d)
    else:
        print("file: %s" % d)

# os.remove("E://PythonStation//get-start//123.txt")
print("-----------------")
print(os.path.abspath("."))
print(os.path.abspath("test_files/test1.md"))
print(os.path.join("a", "b", "c"))
print(os.path.split("1//2//3//4"))
print(os.path.splitext("1//2//3//4.x//y"))
print(os.path.isdir("4.x"))
print(os.path.isfile("4.x"))
```

## 序列化

### 1 pickle 模块

python内置的pickle模块提供了序列化和反序列化的方法：`import pickle`

序列化后的对象通常要写入到磁盘的文件上

- `pickle.dumps(obj)` : 将对象转换成字节码
- `pickle.dump(obj, stream)` : 直接将对象转成字节码在写到一个文件写入流中
- `pickle.loads(bytes)` : 将字节码转换成对象
- `pickle.load(stream)` : 将一个字节流中的内容读取并反序列化长对象

```python
import pickle

obj1 = {"name": "ming", "age": 18}

obj1_byte = pickle.dumps(obj1)
with open("test_files//dumps.txt", "xb") as stream:
    stream.write(obj1_byte)

copy_obj1 = None
with open("test_files//dumps.txt", "rb") as stream:
    data = stream.read()
    copy_obj1 = pickle.loads(data)

print(copy_obj1)

print("-----------")

obj2 = ["ABC", True, 100]
with open("test_files//dump.txt", "xb") as stream:
    pickle.dump(obj2, stream)

copy_obj2 = None
with open("test_files//dump.txt", "rb") as stream:
    copy_obj2 = pickle.load(stream)

print(copy_obj2)
```

### 2 json 模块

python的json模块提供了python和JSON相互转化的API，这里只的JSON是字符串形式的JSON：`import json` .

方法和用法都与pickle模块相似

- `json.dumps(obj)` ：python对象转JSON字符串
- `json.dump(obj, stream)` ：将转化的JSON字符串序列化到文件中
- `json.loads(JSONStr)` : JSON字符串转python对象
- `json.load(stream)` ：将文件中的JSON字符反串序列化成python对象

这种JSON的序列化只能支持python的 `dict` `list` `str` `int/float` `bool` `None` 这些数据类型

- 若要将一个类的对象转成JSON，需要设置 `dumps` `dump` 的 `default` 属性，传入一个类对象转dict的规则的函数
- 若要将一个JSON字符串转成类对象，要设置 `loads` `load` 的 `object_hook`  属性，传入一个dict转类对象的函数

## 压缩文件 zip

`zipfile` 模块用来做 **zip** 格式编码的 **压缩** 和 **解压缩** 的，`zipfile` 里有两个非常重要的类, 分别是 `ZipFile` 和 `ZipInfo` 。`ZipFile` 是主要的类，用来创建和读取zip文件, 而 `ZipInfo` 用于存储的zip文件中的文件信息，每压缩包中的每个文件都有一个 `ZipInfo` 对象。

```python
import zipfile
from zipfile import ZipFile, ZipInfo
```

### 1. ZipFile

```python
ZipFile(filepath, mode="r", compression=ZIP_STORED, allowZip64=True)
```

`ZipFile` 根据指定的zip文件路径和打开模式，创建一个 Zip 文件对象

`mode` 参数支持 **r** 只读，**w** 写入等模式 

#### 方法

- `namelist()` : 获取压缩包中所有文件名的list
- `getinfo(filename)` : 获取指定名称文件的 `ZipInfo` 对象
- `infolist()` : 获取压缩包中所有文件对应的 `ZipInfo` 对象list
- `close` : 关闭压缩包文件流
- `read(filename)` : 将压缩包中指定名称的文件内容读取出来
- `write(filepath)` : 将指定文件写入压缩包，以流的形式
- `writestr(zinfo_or_arcname, data)` : 将字符串写入压缩包中的指定文件
- `setpassword(pwd)` : 设置压缩包的密码

#### 属性

- `filename`
- `debug`
- `comment`

### 2. ZipInfo

 `ZipInfo` 对象通过 `ZipFile` 对象的 `getinfo()` 或 `infolist()` 方法获得，用于记录保存文件的信息

#### 属性

- `filename`
- `date_time` : 最后修改的时间
- `comment` : 文件注释的字节码
- `file_size` : 压缩前的文件大小
- `compress_size` : 压缩后的文件大小

## BZip2 算法

BZip2 是一种 Zip文件的压缩算法，python 中由 `bz2` 模块提供相应的API

#### 安装与导入

> pip install bz2file

```python
import bz2
```

#### bz2 模块包含：

- 用于读写压缩文件的 [`open()`](https://docs.python.org/zh-cn/3.7/library/bz2.html?module-bz2#bz2.open) 函数和 [`BZ2File`](https://docs.python.org/zh-cn/3.7/library/bz2.html?module-bz2#bz2.BZ2File) 类。
- 用于增量压缩和解压的 [`BZ2Compressor`](https://docs.python.org/zh-cn/3.7/library/bz2.html?module-bz2#bz2.BZ2Compressor) 和 [`BZ2Decompressor`](https://docs.python.org/zh-cn/3.7/library/bz2.html?module-bz2#bz2.BZ2Decompressor) 类。
- 用于一次性压缩和解压的 [`compress()`](https://docs.python.org/zh-cn/3.7/library/bz2.html?module-bz2#bz2.compress) 和 [`decompress()`](https://docs.python.org/zh-cn/3.7/library/bz2.html?module-bz2#bz2.decompress) 函数。

### 1. bz2.open() & BZ2File

这两个都提供了bz2压缩文件的读或写的功能，返回 `BZ2File` 对象，`BZ2File` 对象有读写文件常用的 `read` 和 `write` 方法

- `bz2.open(filename, mode='r', compresslevel=9, encoding=None, errors=None, newline=None)`
  - `compresslevel` 是压缩等级，可取值为 **1~9**
  - `filename` 不仅可以是文件路径的字符串，也可以是其他已打开的文件对象
- `BZ2File` 的构造方法与 `bz.open` 相似

### 2. bz.compress() 和 bz.decompress()

- `bz2.compress(data, compresslevel=9)` 
  - `data` 为二进制的数据，`compress` 方法一次性对二进制数据进行压缩，返回压缩后的二进制数据结果
- `bz2.decompress(data)` : 对二进制数据进行一次性解压，返回解压后的二进制数据

通常使用 `compress` 对数据进行压缩，再用 `decompress` 对结果进行解压检验

### 3. bz2.BZ2Compressor 和 bz2.BZ2Decompressor

- `BZ2Compressor(compresslevel=9)` 类提供了增量压缩的方法，即多次添加需要压缩的数据
  - `compress(data)` : 传入需要压缩的数据，返回压缩数据的数据块
  - `flush()` : 结束压缩进程，返回内部缓冲中剩余的压缩完成的数据。
- `BZ2Decompressor()` 类提供了增量解压缩的方法，可以多次调用解压方法，对需要解压的所有数据解压
  - `decompress(data, max_length=-1)` : 返回解压后的二进制数据，若多次调用，会与前一次调用的数据进行整合，返回新的解压结果



## Link

#### [zipfile 模块](<https://docs.python.org/zh-cn/3.7/library/zipfile.html?highlight=zipfile#>)

#### [对 bzip2压缩算法的支持](<https://docs.python.org/zh-cn/3.7/library/bz2.html?module-bz2>)

