# Gradle
## Hello Gradle
`gradle` 命令会在当前目录中查找一个叫 `build.gradle` 的文件, 可以直接执行该文件中配置的 `task`.

#### 例子01：*build.gradle*:
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

该task中的doLast也可以使用 `<<` 代替, 使用快捷的任务定义模式：
```groovy
task hello << {
    println 'Hello world!'
}
```

## Groovy
Gradle 使用 Groovy 语言来构建 `build.gradle` 脚本, 而 Groovy 与Java非常相似：
#### 例子02：Groovy构建task
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

## 任务依赖
使用 `dependsOn` 可以声明task之间的依赖:
```groovy
task task1(dependsOn: task2) << {
    ...
}
```

表示task2必须在task2之后执行, 若task2在task1之后声明, 则会先加载执行task2, 这称为 Lazy dependsOn .

#### 例子03：dependsOn
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

## 动态任务
Gradle能利用Groovy语法动态创建task, 使用类似lambda表达式的语句：

#### 例子04：动态创建任务
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

## 任务功能拓展
### 1. 使用dependsOn为task添加依赖
使用 `task0.dependsOn task1,task2` 为task0依次添加task1和task2为依赖, 执行task时按照依赖添加的顺序执行.

#### 例子05：dependsOn
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
在task定义之后, 可以使用`taskName << {  }` 的表达式为task添加内容, 对于同一个task的重复描述Gradle最终会把内容按定义的顺序合并

#### 例子06：使用 <<
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
`task.doFirst{...}` 和 `task.doLast{...}` 可以给已经定义的task添加内容, doLast添加的内容会在doFirst之后执行.

#### 例子07：.doFirst和.doLast
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

`dependsOn`, `<<` , `.doFirst` 和 `.doLast` 的方式可以混合使用, 而语句的执行是:

`dependsOn` -> `.doFirst` -> `.doLast` / `<<`

> **>** gradle hello -q  
Hello Earth  
Hello Venus  
Hello Mars

## 短标记法$
`$` 类似于JS中的字符串模板, 使用 `$task.property` 的形式可以在字符串中输出task的属性(name...)

#### 例子08：$
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

## 定义task
使用 `task` 关键字定义task: `task name(options){...}`。其中 `param` 可以省略，此时可以不用加括号
### options
- type
- group
- description

#### 例子09：定义task
```groovy
task copy(type: Copy, group: "Custom", description: "Copies sources to the dest directory"){
    ...
}
```

## 依赖管理
**dependencies(依赖项)**：指传入项目的文件  
**publications(发布项)**：项目传出发布的文件  
**dependency resolution(依赖解析)**：依赖关系可能需要从远程的 Maven 或者 Ivy 仓库中下载, 也可能是在本地文件系统中, 或者是通过多项目构建另一个构建. 我们称这个过程为依赖解析
**transitive dependencies(依赖传递)**：一来项之间存在的相互依赖

## 依赖配置
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
#### 例子10：dependencies
```groovy
dependencies {
    compile group: 'org.hibernate', name: 'hibernate-core', version: '3.6.7.Final'
    //等同于 compile 'org.hibernate:hibernate-core:3.6.7.Final'
}
```

## ext自定义属性
创建task使, 可以使用 `ext` 为task添加自定义的属性, 使用 `ext.property=value` 的形式. 但如果是 Gradle task 内置的属性, 像 `name` 这些, 是无法用 `ext` 重写的.

#### 例子09：ext
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

## 调用 Ant
在 `build.gradle` 中, 可以使用 `ant.property`,  `ant.function` 的方式来直接调用 Ant 的方法和属性, 因为 Gradle 本身就已经集成了 Ant , 所以可以直接使用 Ant .

#### 例子10：调用 Ant
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

## 定义方法
在 `build.gradle` 文件中可以自定义方法, 并在task中调用, 方法定义的语法与Java相似, 当方法中只有一个返回值的时候, 可以省略 `return`.
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

## 默认任务
`build.gradle` 脚本中可以为一个模块或项目定义一个或多个默认任务. 使用 `defaultTasks 'task'` 添加默认 task, 使用 `gradle -q` 就能直接执行所有的默认任务.
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

## 跳过的部分
1. 通过 DAG 配置

# Link
### Gitbook
Gradle User Guide 中文版   
https://dongchuan.gitbooks.io/gradle-user-guide-/  
Gradle In Action中文版  
https://lippiouyang.gitbooks.io/gradle-in-action-cn/content/
