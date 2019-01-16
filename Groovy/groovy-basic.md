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


---
# Link
### Offical
http://www.groovy-lang.org/index.html
