# Groovy
---

# 基本语法(Syntax)
## 注释(Comment)
Groovy的注释与Java相似，支持 **单行注释(Single line comment)**、**多行注释(Multiline comment)**、**文档注释(Doc comment)** 和 **#!注释(Shebang line)**.
```groovy
// a standalone single line comment
println "hello" // a comment till the end of the line

/* a standalone multiline comment
   spanning two lines */
println "hello" /* a multiline comment starting
                   at the end of a statement */
println 1 /* one */ + 2 /* two */

/**
 * Groovy Doc comment
 * A Class description
 */
class Person {
    /** the name of the person */
    String name

    /**
     * Creates a greeting method for a certain person.
     *
     * @param otherPerson the person to greet
     * @return a greeting message
     */
    String greet(String otherPerson) {
       "Hello ${otherPerson}"
    }
}

#!/usr/bin/env groovy
println "Hello from the shebang line"
```

## 关键字(Keywords)
|||关键字表|||
|-|-|-|-|-|
|as|assert|break|case|catch|
|class|const|continue|def|default|
|do|else|enum|extends|false|
|finally|for|goto|if|implements|
|import|in|instanceof|interface|new|
|null|package|return|super|switch|
|this|throw|throws|trait|true|
|try|while|

## 标识符(Identifiers)
### 普通标识符(Normal identifiers)
Groovy的普通标示符与大部分编程语言一样，用于标示变量或方法名，以 **字母**、**美元符号** 和 **下划线** 开头，包含数字和字母。

## 引用标识符(Quoted identifiers)
通过 `变量.` 的形式引出的标识符

在Groovy中，引用标识符支持使用字符串的形式，并且字符串中可以包含任何字符

```groovy
map.'single quote'
map."double quote"
map.'''triple single quote'''
map."""triple double quote"""
map./slashy string/
map.$/dollar slashy string/$

def firstname = "Homer"
map."Simpson-${firstname}" = "Homer Simpson"
assert map.'Simpson-Homer' == "Homer Simpson"
```

## 字符串(Strings)
> Groovy lets you instantiate `java.lang.String` objects, as well as GStrings (`groovy.lang.GString`) which are also called interpolated strings in other programming languages.

Groovy可以使用Java的 `String` 类，也可以使用Groovy的字符串类型——`GString`，又称 **插入字符串**。

### 单引号(Single quoted string)
```groovy
assert 'ab' == 'a' + 'b'
```

### 三单引号(Triple single quoted string)
三单引号天然支持多行字符串，会保留字符串中的 **换行**、**缩进** 等。

三单引号字符串与普通的 `java.lang.String` 的字符串一样，不支持插值。

在类的代码中，三引号字符串可能随着代码风格包含有空白缩进。Groovy 的开发包中有的字符串类型提供了 `stripIndent()` 方法可以去除这个空白缩进。并且提供了 `stripMargin()` 方法可以删除字符串开始位置指定的分隔符。

```groovy
def aMultilineString = '''
line one
line two
line three'''

aMultilineString.stripIndent()
```

使用三单引号编写多行字符串时，可能出现首行直接换行的行为，这时开头的 `'''` 之后的换行符会被记录下来，可以使用反斜杠 `\` 将这个换行符转义掉。

```groovy
def startingAndEndingWithANewline = '''\
line one
line two
line three
'''
```

### 双引号(Double quoted string)
> Double quoted strings are plain `java.lang.String` if there’s no interpolated expression, but are `groovy.lang.GString` instances if interpolation is present.

在没有使用插值的情况下，双引号的字符串是 `java.lang.String` 类型的，当使用插值时，被解释为 `groovy.lang.GString` 类型。

>  The placeholder expressions are surrounded by `${}` or prefixed with `$` for dotted expressions.

#### 插值(Interpolation)
使用双引号的字符串可以使用插值，插值的占位符有两种形式：
1. `${}`：`{}` 中可以写 **变量** 或 **表达式**，且表达式可以没有任何返回，此时插值返回的值为 `null`.
2. `$object.property`：使用 `$` 引入变量，但必须用 `.property`的表达式，常用于map的结构。

若想使用 `$object.method()` 的表达式，程序会报 `groovy.lang.MissingPropertyException` 的异常，因为这种插值的形式只适用于属性，不适用方法。

```groovy
void braceAfter$(){
    def name = "Quinn"
    def greeting = "Hello, ${name}. 1 + 2 = ${1+2}"
    assert greeting == "Hello, Quinn. 1 + 2 = 3"
}

void dottedExpressionPrefix$(){
    def person = [name: 'Guillaume', age: 36]
    assert "$person.name is $person.age years old" == 'Guillaume is 36 years old'
}
```

#### 闭包插值(Closure Expression)
`->` 在 `${}` 中是个 **闭包** 的定义符号，如果插值是一个闭包表达式，则在解释这个字符串时，会执行闭包的表达式，返回的结果就是插值的值。

在Groovy中，闭包若没有参数，可以省略参数，直接使用 `{-> expression}`.

```groovy
def sParameterLessClosure = "1 + 2 == ${-> 3}"
assert sParameterLessClosure == '1 + 2 == 3'

def sOneParamClosure = "1 + 2 == ${ w -> w << 5}"
assert sOneParamClosure == '1 + 2 == 5'
```

使用闭包插值有一个好处，就是 **懒加载(Lazy Evaluation)**.

```groovy
def value = 1
def eagerGString = "value == ${value}"
def lazyGString = "value == ${ -> value }"

assert eagerGString == "value == 1"
assert lazyGString ==  "value == 1"

value = 'love'
assert eagerGString == "value == 1"
assert lazyGString ==  "value == love"
```

#### GString与String
`GString` 类型可以自动转换成 `String` 类型，而使用 `toString()` 方法可以将一个 `GString` 对象手动转成一个 `String` 对象。

`GString` 与 `String` 的 hasCode 不同的，即使表达的是同样的字符串，但是这两个数据的类型的hasCode是不一样的，就如 `key = "a"` 和 `"${key}"` 的hasCode是不同的。

map通常不用 `GString` 类型做key，因为在map使用 `[key]` 取值时，map会将key转成相应的 `String` 类型，使用的是 `String` 的字符串的hasCode。

同一个结果的 `GString` 的hasCode就是一样的，`String` 也是。

```groovy
assert "one: ${1}".hashCode() != "one: 1".hashCode()

def key = "a"
def keyB = "b"
def m = ["${key}": "letter ${key}", "b": "letter b"]
assert m["a"] == null
assert m["${key}"] == null
assert m["${keyB}"] == "letter b"
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
