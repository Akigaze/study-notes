# Groovy
---

# Program Structure(编程结构)
## Package names(包)
> Package names play exactly the same role as in Java.

```groovy
// defining a package named com.yoursite
package com.yoursite
```
## Imports(引用)
> Groovy follows Java’s notion of allowing `import` statement to resolve class references

```groovy
// importing the class MarkupBuilder
import groovy.xml.MarkupBuilder

// using the imported class to create an object
def xml = new MarkupBuilder()
assert xml != null
```

### Default imports(默认引用)
```groovy
import java.lang.*
import java.util.*
import java.io.*
import java.net.*
import groovy.lang.*
import groovy.util.*
import java.math.BigInteger
import java.math.BigDecimal
```

### Simple import(单一引用)
> A simple import is an import statement where you fully define the class name along with the package.

指定全类名，即只引用指定的类。

```groovy
// importing the class MarkupBuilder
import groovy.xml.MarkupBuilder
```

### Star import(星号引用)
使用 `*` 代替类名，指代包里面的所有类，可以同时导入包内的所有类。

```groovy
// simple import two classes from groovy.xml
import groovy.xml.MarkupBuilder
import groovy.xml.StreamingMarkupBuilder

//star import same as above
import groovy.xml.*
```

### Static import(静态引用)
> Groovy’s static import capability allows you to reference imported classes as if they were static methods in your own class.

使用 `import static` 作为引用的关键字，使用 `className.fieldName` 或 `className.methodName` 的形式，只引入类的静态的属性或静态方法。

```groovy
import static Boolean.FALSE
assert !FALSE //use directly, without Boolean prefix!
```

同时，Groovy支持声明与静态引入的方法名同名的方法，只要参数类型不同就可以。

```groovy
import static java.lang.String.format
class SomeClass {
    //same name but with defferent type of parameter
    String format(Integer i) {
        i.toString()
    }
    static void main(String[] args) {
        assert format('String') == 'String'
        assert new SomeClass().format(Integer.valueOf(1)) == '1'
    }
}
```

### Static import aliasing(静态引用别名)
使用 `as` 关键字可以在引入静态的成员时，为该属性或方法起别名。

```groovy
import static Calendar.getInstance as now
assert now().class == Calendar.getInstance().class
```

### Static star import(静态星号引用)
> It will import all the static fields and methods from the given class.

```groovy
import static java.lang.Math.*
assert sin(0) == 0.0
assert cos(0) == 1.0
assert PI instanceof Double
```

### Import aliasing(引用别名)
普通引用也可以使用 `as` 为引入的类起别名。

```groovy
import java.util.Date
import java.sql.Date as SQLDate

Date utilDate = new Date(1000L)
SQLDate sqlDate = new SQLDate(1000L)

assert utilDate instanceof java.util.Date
assert sqlDate instanceof java.sql.Date
```

## Scripts vs Classes
Groovy同时支持编写脚本和类，在编译时，Groovy实际上是将脚本编译成类再执行的。

脚本编译成的类会继承 `Script` 这个类，脚本中所有执行的内容会被放在类的 `run` 方法中，再在 `main` 方法中通过 `InvokerHelper.runScript()` 方法执行。而类名字会跟脚本所在的文件名相同。

在脚本中声明的方法，会被直接当成编译的类的方法。

而在脚本中声明的变量，会被放到 `run` 方法中，而不会当成类的成员变量，如果要将变量作为编译的类的属性，可以使用 `@Field` 注解。

```groovy
//in file Main.groovy
int power(int n) { 2**n }                       
println 'Groovy world!'
println "2^6==${power(6)}"

//compile to class
import org.codehaus.groovy.runtime.InvokerHelper
class Main extends Script {   
    int power(int n) { 2** n}                    
    def run() {                                 
        println 'Groovy world!'   
        println "2^6==${power(6)}"                
    }
    static void main(String[] args) {           
        InvokerHelper.runScript(Main, args)     
    }
}
```

# Closures(闭包)
```groovy
{ item++ }                                          
{ -> item++ }                                       
{ println it }                                      
{ it -> println it }                                
{ name -> println name }                            
{ String x, int y ->                                
    println "hey ${x} the value is ${y}"
}
{ reader ->                                         
    def line = reader.readLine()
    line.trim()
}
```
