## Python 与 正则表达式

python对正则表达式的操作由 `re` 模块提供：

````python
import re
````

python中以字符串的形式编写正则表达式，由于正则表达式中存在 `\w` `\s` `\d` 这些以反斜杠 `\` 开头的匹配符，所以在正则表达式的字符串中需要对反斜杠进行转义 `\\` ，或者是用 `r''` 提供的自动转义功能编写正则表达式字符串

### re 常用方法

#### 1. re.match

`match` 方法必须从字符串的第一个字符就匹配，只是用于检验目标字符串是否符合某种模式，要判断字符串是否包含某个模式，要用 `search`

```python
def match(pattern, string, flags=0):
    """Try to apply the pattern at the start of the string, returning
    a match object, or None if no match was found."""
    return _compile(pattern, flags).match(string)
```

```python
import re

result = re.match(r'^abc\d?-', 'abc2-abc3')
if result:
    print("match")
else:
    print("not match")
```

#### 2. group 提取分组

`re.match` 方法在匹配中的情况下，会返回一个 `Match` 对象，使用 `Match` 对象的 `group` 方法可以获取指定 **序号** 或者 **名称** 的分组的字符串

正则表达式的分组序号是从 **1** 开始的，所以当获取的分组序号为0的字符串时，返回原始字符串

```python
@overload
def group(self, group1: int = ...) -> AnyStr: ...
@overload
def group(self, group1: str) -> AnyStr: ...
@overload
def group(self, group1: int, group2: int, *groups: int) -> Sequence[AnyStr]: ...
@overload
def group(self, group1: str, group2: str, *groups: str) -> Sequence[AnyStr]: ...
def groups(self, default: AnyStr = ...) -> Sequence[AnyStr]: ...
```

```python
time = '19:05:30'
m = re.match(r'([01][0-9]|2[0-3]|[0-9]):([0-6][0-9]|[0-9]):([0-6][0-9]|[0-9])', time)
print(m.group(0))
print(m.group(1))
print(m.group(2))
print(m.group(3))
```

#### 3. re.split

```python
def split(pattern, string, maxsplit=0, flags=0):
    """Split the source string by the occurrences of the pattern,
    returning a list containing the resulting substrings.  If
    capturing parentheses are used in pattern, then the text of all
    groups in the pattern are also returned as part of the resulting
    list.  If maxsplit is nonzero, at most maxsplit splits occur,
    and the remainder of the string is returned as the final element
    of the list."""
    return _compile(pattern, flags).split(string, maxsplit)

```

```python
str_list = re.split(r'[\s,]+', 'a, b ,c d,  e f,g')
print(str_list)
```

#### 4. re.compile

预编译正则表达式，在同一个正则表达式重复使用的情况下，可以减少正则表达式编译的次数

```python
def compile(pattern, flags=0):
    "Compile a regular expression pattern, returning a pattern object."
    return _compile(pattern, flags)
```

返回的 `Pattern` 对象，拥有和 `re` 一样的方法，只是在使用时不用再传入正则表达式

**`flags`** 匹配模式：

- `re.M` 或 `re.MULTILINE` ：开启 `'^'` 和 `'$'` 的多行匹配
- `re.S` 或 `re.DOTALL` ：开启 `'.'` 匹配任何字符，包括换行符
- `re.I` 或 `re.IGNORECASE` ：开启忽略大小写
- `re.A` 或 `re.ASCII`
- `re.L` 或 `re.LOCAL`
- `re.X` 或 `re.VERBOSE`

#### 5. re.search(*pattern*, *string*, *flags=0*)

扫描整个 *字符串* 找到匹配样式的第一个位置，并返回一个相应的 `Match` 对象。如果没有匹配，就返回一个 `None`。

#### 6. re.fullmatch(*pattern*, *string*, *flags=0*)

如果整个 *string* 匹配到正则表达式样式，就返回一个相应的 `Match` 对象，否则就返回一个 `None` 

#### 贪婪模式

python的正则表达式使用 `{m:n}`，  `+`  和 `*` 时默认是使用贪婪模式的，即尽可能多的匹配，直到没有匹配为止，可以在 `{m:n}`， `+`  和 `*` 后面加 `?` 来启用非贪婪模式，即  `{m:n}?`， `+?` 和 `*?` 为非贪婪模式

### 正则表达式编译

python在使用正则表达式时，会对每条正则表达式进行编译，再去进行匹配





# Link

#### [官方文档 - re 正则表达式操作](<https://docs.python.org/zh-cn/3.7/library/re.html>)

