# Gradle
## 01. Hello Gradle
`gradle` 命令会在当前目录中查找一个叫 `build.gradle` 的文件, 可以直接执行该文件中配置的 `task`.

#### 例子1.1：*build.gradle*:
```groovy
task hello {
    doLast {
        println 'Hello Gradle!'
    }
}
```

> **>** gradle hello -q  
output: Hello Gradle!

通过 `gradle hello -q` 命令, 就可以执行该文件中的 task, 在控制台输出 Hello Gradle, 而此时项目中并不需要其他任何文件.
执行完gradle命令之后, 项目中会生成一个 `.gradle` 目录.

该task中的doLast也可以使用 `<<` 代替，使用快捷的任务定义模式：
```groovy
task hello << {
    println 'Hello world!'
}
```

## 02. Groovy
Gradle 使用 Groovy 语言来构建 `build.gradle` 脚本，而 Groovy 与Java非常相似：
#### 例子2.1：Groovy构建task
```groovy
task upper << {
    String someString = 'mY_nAmE'
    println "Original: " + someString
    println "Upper case: " + someString.toUpperCase()
}

task count << {
    4.times { print "$it " }
}
```
> **>** gradle upper -q  
Original: mY_nAmE  
Upper case: MY_NAME  
> **>** gradle count -q  
0 1 2 3

## 03. 任务依赖
使用 `dependsOn` 可以声明task之间的依赖:
```groovy
task task1(dependsOn: task2) << {
    ...
}
```

表示task2必须在task2之后执行，若task2在task1之后声明，则会先加载执行task2，这称为 Lazy dependsOn 。

#### 例子3.1：dependsOn
```groovy
task hello << {
    println 'Hello Gradle!'
}

task intro(dependsOn: hello) << {
    println "I'm Gradle"
}
```

> **>** gradle intro -q  
Hello world!  
I'm Gradle

## 04. 动态任务
Gradle能利用Groovy语法动态创建task，使用类似lambda表达式的语句：

#### 例子4.1：动态创建任务
```groovy
4.times { counter ->
    task "task$counter" << {
        println "I'm task number $counter"
    }
}
```

该表达式利用循环动态创建了 `task0`, `task1`, `task2`, `task3` 四个task

> **>** gradle task1 -q  
I'm task number 1

## 05. 任务功能拓展
### 1. 使用dependsOn为task添加依赖
使用 `task0.dependsOn task1,task2` 为task0依次添加task1和task2为依赖，执行task时按照依赖添加的顺序执行。

#### 例子5.1：dependsOn
```groovy
task hello << { println "Hello World" }
task say << { println "Good Morning" }
task study << { println "Study Gradle" }

study.dependsOn hello,say
```

> **>** gradle study -q  
Hello World  
Good Morning  
Study Gradle  

### 2. 使用task定义为task添加内容
在task定义之后，可以使用`taskName << {  }` 的表达式为task添加内容，对于同一个task的重复描述Gradle最终会把内容按定义的顺序合并

#### 例子5.2：使用 <<
```groovy
task hello << {
    println 'Hello Earth'
}
hello << {
    println 'Hello Jupiter'
}
```

> **>** gradle hello -q  
Hello Earth  
Hello Jupiter  

### 3. 使用`.doFirst`和`.doLast`添加内容
`task.doFirst{...}` 和 `task.doLast{...}` 可以给已经定义的task添加内容，doLast添加的内容会在doFirst之后执行。

#### 例子5.3：.doFirst和.doLast
```groovy
task hello << {
    println 'Hello Earth'
}
hello.doFirst {
    println 'Hello Venus'
}
hello.doLast {
    println 'Hello Mars'
}
```

`.doFirst`和`.doLast`添加的内容的执行顺序：
1. `.doFirst`：后加的在前
2. `.doLast`：先加的在前

`dependsOn`, `<<` , `.doFirst` 和 `.doLast` 的方式可以混合使用，而语句的执行是:

`dependsOn` -> `.doFirst` -> `.doLast` / `<<`

> **>** gradle hello -q  
Hello Earth  
Hello Venus  
Hello Mars

## 06. 短标记法$
`$` 可以将task对象化，使用 `$task` 的形式可以把task当成一个变量，使用 `$task.property` 的形式访问task对象的属性(name...)

#### 例子6.1：$
```groovy
task hello << {
    println 'Hello world!'
}
hello.doLast {
    println "Greetings from the $hello.name task."
}
```

> **>** gradle hello -q  
Hello world!  
Greetings from the hello task.  

## 07. 定义task
使用 `task` 关键字定义task: `task name(options){...}`。其中 `param` 可以省略，此时可以不用加括号
### options
- type
- group
- description

#### 例子7.1：定义task
```groovy
task copy(type: Copy, group: "Custom", description: "Copies sources to the dest directory"){
    ...
}
```

### task定义语句
#### task(name)
将task的名字放在括号中
#### 例子7.2:
```groovy
task(hello) << {
    println "hello"
}
```

#### task('name')
task的名字也可以使用字符串的形式
#### 例子7.3:
```groovy
task('hello') <<
{
    println "hello"
}
```

#### tasks.create(name: 'name')
#### 例子7.4:
使用 `create` 方法，传入name作为参数
```groovy
tasks.create(name: 'hello') << {
    println "hello"
}
```

## 08. 依赖管理
**dependencies(依赖项)**：指传入项目的文件  
**publications(发布项)**：项目传出发布的文件  
**dependency resolution(依赖解析)**：依赖关系可能需要从远程的 Maven 或者 Ivy 仓库中下载, 也可能是在本地文件系统中, 或者是通过多项目构建另一个构建. 我们称这个过程为依赖解析
**transitive dependencies(依赖传递)**：一来项之间存在的相互依赖

### 08.1 依赖配置
在 **java插件** 中，主要的依赖配置有4个：
1. compile：用来编译项目源代码的依赖.
2. runtime：在运行时被生成的类使用的依赖. 默认的, 也包含了编译时的依赖.
3. testCompile：编译测试代码的依赖. 默认的, 包含生成的类运行所需的依赖和编译源代码的依赖.
4. testRuntime：运行测试所需要的依赖. 默认的, 包含上面三个依赖.

一个依赖由`group`, `name` 和 `version` 三部分组成，完整的配置方式是：  
`dependencyOption group: 'xxx', name: 'xxx', version: 'xxx'`  
也可以简写成：  
`dependencyOption group:name:version`

这些依赖都配置在 `build.gradle` 的 `dependencies` 属性中：
#### 例子8.1.1：dependencies
```groovy
dependencies {
    compile group: 'org.hibernate', name: 'hibernate-core', version: '3.6.7.Final'
    //等同于 compile 'org.hibernate:hibernate-core:3.6.7.Final'
}
```

## 09. ext自定义属性
创建task使, 可以使用 `ext` 为task添加自定义的属性, 使用 `ext.property=value` 的形式. 但如果是 Gradle task 内置的属性, 像 `name` 这些, 是无法用 `ext` 重写的.

#### 例子9.1：ext
```groovy
task developer {
    ext.name = "Quinn"
    ext.family = "Hwang"
}
task hello << {
    println "Hello, $developer.name $developer.family."
}
```

> **>** gradle hello -q  
hello, developer Hwang.  

## 10. 调用 Ant
在 `build.gradle` 中, 可以使用 `ant.property`,  `ant.function` 的方式来直接调用 Ant 的方法和属性, 因为 Gradle 本身就已经集成了 Ant , 所以可以直接使用 Ant .

#### 例子10.1：调用 Ant
```groovy
task loadfile << {
    def files = file('./resource').listFiles().sort()
    files.each { File file ->
        if (file.isFile()) {
            ant.loadfile(srcFile: file, property: file.name)
            println " *** $file.name ***"
            println "${ant.properties[file.name]}"
        }
    }
}
```

> **>** gradle -q loadfile  
\*\*\* developer.txt \*\*\*  
Quinn Huang QH  
Akigaze Hwang AH  
\*\*\* README.md \*\*\*  
Hello Gradle!  
It seems difficult.  

`ant.loadfile` 和 `ant.properties` 就是 Ant 的方法和属性

## 11. 定义方法
在 `build.gradle` 文件中可以自定义方法, 并在task中调用, 方法定义的语法与Java相似, 当方法中只有一个返回值的时候, 可以省略 `return`.
#### 例子11.1：
```groovy
File[] fileList(String dir) {
    file(dir).listFiles({file -> file.isFile() } as FileFilter).sort()
}
task loadfile << {
    fileList('../resources').each {File file ->
        ant.loadfile(srcFile: file, property: file.name)
        println "I'm fond of $file.name"
    }
}
```

> **>** gradle -q loadfile  
I'm fond of developer.txt  
I'm fond of README.md

## 12. 默认任务
`build.gradle` 脚本中可以为一个模块或项目定义一个或多个默认任务. 使用 `defaultTasks 'task'` 添加默认 task, 使用 `gradle -q` 就能直接执行所有的默认任务.
#### 例子12.1
```groovy
defaultTasks 'clean', 'run'
task clean << {
    println 'Default Cleaning!'
}
task run << {
    println 'Default Running!'
}
task other << {
    println "I'm not a default task!"
}
```

> **>** gradle -q  
Default Cleaning!  
Default Running!  

### 13. 外部的依赖
在 `build.gradle` 文件中，在 `repositories` 属性中加入依赖仓库，在 `dependencies ` 属性中加入具体依赖的 jar 包名称。
#### 例子13.1:
```groovy
repositories {
    mavenCentral()
}
dependencies {
    compile group: 'commons-collections', name: 'commons-collections', version: '3.2'
    testCompile group: 'junit', name: 'junit', version: '4.+'
}
```


## 14. 定位 tasks
1. 直接使用task名称
2. 使用 `project.task`
3. 使用 `tasks` 集合，包括 `tasks.task` 和 `tasks['task']` 两种形式
4. 通过 `tasks.getByPath()` ？？？

## 15. 插件
插件是 Gradle 的扩展, 它会通过某种方式配置你的项目, 典型的有加入一些预配置任务. Gradle 自带了许多插件, 你也可以很简单地编写自己的插件并和其他开发者分享它.

**Java 插件** 就是一个这样的插件. 这个插件在你的项目里加入了许多任务， 这些任务会编译和单元测试你的源文件, 并且把它们都集成一个 JAR 文件里. **Java 插件** 是基于合约的. 这意味着插件已经给项目的许多方面定义了默认的参数, 比如 Java 源文件的位置.

通过插件可以在依赖管理，测试，项目构建，部署等方面获得便利，提高效率

### 15.1 插件的类型
在Gradle中一般有两种类型的插件, 脚本插件和二进制插件. 脚本插件是用户自己构建的脚本, 它会进一步配置构建, 通常实行声明的方式操纵的构建，即类似于task声明的方式. 二进制插件是实现了Plugin接口的类, 并且采用编程的方式来操纵构建. 二进制插件可以驻留在构建脚本, 项目层级内或外部的插件jar.

通常引入插件会将插件中的task也引入到项目中，因此可以简单理解为：插件就是一堆已经写好的task的集合，所以自定义插件实际上也就是在写task文件

### 15.2 应用插件
脚本插件通常使用 `apply from:` 引入项目，指定脚本相对于 `build.gradle` 文件的相对路径  

脚本插件多采用 **DSL** 引入，即在 `plugins` 属性中指定插件的id(或version)
#### 例子15.2.1：引用插件
```groovy
apply from: 'other.gradle'
plugins {
    id 'java'
    id "com.jfrog.bintray" version "0.4.1"
}
```

### 15.3 常用插件
- java

### 15.4 java 插件
#### 15.4.1 java插件对项目的几个默认目录：
- `src/main/java` ：项目的正式源码
- `src/test/java` ：项目的测试源码
- `src/main/resources` ：项目要打包进 jar 的资源文件
- `build` ：存放项目构建输出的所有文件
- `build/libs` ：存放生成的 jar 文件

#### 15.4.2 常用的Task：
- build ：构建项目，编译和测试你的代码,并生成一个包含所有类与资源的 JAR 文件。  
该命令的输出如下：
> **>** gradle build  
:compileJava  
:processResources  
:classes  
:jar  
:assemble  
:compileTestJava  
:processTestResources  
:testClasses  
:test  
:check  
:build  
**BUILD SUCCESSFUL**


- clean ：删除 build 目录。
- assemble ：编译并打包你的代码, 但是并不运行单元测试。
- check ：编译并测试你的代码。

## gradle vs gradlew
gradle 命令时本地使用的命令, 即当本地安装配置了 Gradle 才能使用的命令

gradlew 是针对项目使用的命令, `w`应该是`wrapper`的缩写；该命令是配置在`gradlew`和`gradlew.bat`文件中, 这种做法称为 Gradle Wrapper. 它可以帮助本地没有安装Gradle的用户也能在自己的机器上运行Gradle管理的项目.

在linux或unix系统, 使用`./gradlew`命令. Gradle Wrapper都会绑定到一个特定版本的Gradle, 当用户第一次执行上面的命令时, Wrapper会自动地下载并安装对应版本的Gradle, 这个下载安装的Gradle知识针对当前项目的, 别的项目是无法使用的, 而下载的Gradle会被存放在`$USER_HOME/.gradle/wrapper/dists`目录下.

一个有Gradle Wrapper的项目应该有以下文件:  
![](..\pic\gradle\gradle wrapper.png)

`gradlew`, `gradlew.bat`, `gradle\wrapper` 目录就是与Gradle Wrapper相关的, 其中项目使用的Gradle的版本信息和存储路径等信息记录在 `gradle\wrapper\gradle-wrapper.properties` 文件中
```js
//gradle-wrapper.properties
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\://services.gradle.org/distributions/gradle-5.0-bin.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
```
**\:** 冒号加转义是因为在`.properties`文件中, `=` 可以用 `:`

`gradlew`命令的用法与`gradle`命令基本相同.

### 生成Gradle Wrapper
如果项目中没有Gradle Wrapper, 则可以使用`gradle wrapper`命令生成Gradle Wrapper, 当然这需要本地已经安装Gradle

> **>** gradle wrapper

根据本地环境配置的Gradle版本配置项目的Gradle Wrapper, 会在项目中生成四个文件：
- `gradlew`
- `gradlew.bat`
- `gradle\wrapper\gradle-wrapper.jar`
- `gradle\wrapper\gradle-wrapper.properties`

`gradle-wrapper.properties`的`distributionUrl`属性记录了Gradle的版本和下载地址.

> **>** gradle wrapper --gradle-version xx.xx

指定配置的Gradle版本
