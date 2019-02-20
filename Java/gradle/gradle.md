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

表示task2必须在task2之后执行，若task2在task1之后声明，则会先加载执行task2，这称为 Lazy dependsOn。
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

这里的依赖并不是要强制执行被依赖的task，而是只要被依赖的task在依赖的task之前被执行了即可；若多个task都依赖与同一个task，根据依赖的传递，每个task其实只会被执行一次
#### 例子3.2：多任务依赖
```groovy
task compile << {
    println 'compiling source'
}
task compileTest(dependsOn: compile) << {
    println 'compiling unit tests'
}
task test(dependsOn: [compile, compileTest]) << {
    println 'running unit tests'
}
task dist(dependsOn: [compile, test]) << {
    println 'building the distribution'
}
```

> **>** gradle dist tests  
*>* Task :compile  
compiling source  
*>* Task :compileTest  
compiling unit tests  
*>* Task :test  
running unit tests  
*>* Task :dist  
building the distribution  


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
### 07.1 options
- type
- group
- description

#### 例子7.1.1：定义task
```groovy
task copy(type: Copy, group: "Custom", description: "Copies sources to the dest directory"){
    ...
}
```

### 07.2 task定义语句
#### task(name)
将task的名字放在括号中
#### 例子7.2.1:
```groovy
task(hello) << {
    println "hello"
}
```

#### task('name')
task的名字也可以使用字符串的形式
#### 例子7.2.2:
```groovy
task('hello') <<
{
    println "hello"
}
```

#### tasks.create(name: 'name')
#### 例子7.2.3:
使用 `create` 方法，传入name作为参数
```groovy
tasks.create(name: 'hello') << {
    println "hello"
}
```

### 07.3 执行task
使用 `gradle task1 task2` 的形式一次执行多个task，但是如果有同名的task，则只会执行一次，且在之前的task的依赖出现的task，也不会再次执行
#### 例子7.3.1：
```groovy
task compile << {
    println 'compiling source'
}
task compileTest(dependsOn: compile) << {
    println 'compiling unit tests'
}
task test(dependsOn: [compile, compileTest]) << {
    println 'running unit tests'
}
```  

> **>** gradle test compile test  
*>* Task :compile  
compiling source  
*>* Task :compileTest  
compiling unit tests  
*>* Task :test  
running unit tests  

### 07.4 排除task
使用 `-x` 选项可以将选项后面的第一个task排除掉，即在本次命令中该task将不会被执行；需要排除多个task时，可以使用多次 `-x` 指定多个task，可用于排除task的依赖
#### 例子7.4.1：
```groovy
task compile << {
    println 'compiling source'
}
task compileTest(dependsOn: compile) << {
    println 'compiling unit tests'
}
task test(dependsOn: [compile, compileTest]) << {
    println 'running unit tests'
}
```
> **>** gradle test -x compile -x compileTest  
*>* Task :test  
running unit tests  

### 7.5 任务同步
默认情况下, 只要有任务调用失败, Gradle就会中断执行. 这可能会使调用过程更快, 但那些后面隐藏的错误就没有办法发现了.

使用 `--continue` 选项, Gralde 会调用每一个任务以及它们依赖的任务, 而不是一旦出现错误就会中断执行, 所有错误信息都会在最后被列出来.

一旦某个任务执行失败,那么所有依赖于该任务的子任务都不会被调用.例如由于 test 任务依赖于 complie 任务,所以如果 compile 调用出错, test 便不会被直接或间接调用.

#### 例子7.5.1：
> **>** gradle test dist --continue

### 7.6 简化任务名
执行task时，并不需要输入任务的全名， 只需提供足够的可以唯一区分出该任务的字符即可。如 `dist` 可以简写成 `di`；同时若task是采用驼峰命名，还可以直接使用每个单词的首字母，大小写与驼峰形式保持一致，如 `integrationTest` 简写成 `iT`.
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
- compileJava：所有产生编译 classpath 的任务，包括编译配置项目的所依赖的 jar 文件，使用 javac 命令编译产生 java源文件
- processResources：复制生产资源到生产 class 文件目录
- classes：compileJava任务和processResources任务
- compileTestJava：compile任务加上所有产生测试编译的classpath的任务
- processTestResources：复制测试资源到测试 class 文件目录
- testClasses：compileTestJava 和 processTestResources 任务
- jar：组装 Jar 文件
- javadoc：使用 javadoc 命令为 Java 源码生产 API 文档
- test：compile，compileTest，加上所有产生 test runtime classp 的任务，使用 JUnit或者TestNG 进行单元测试
- uploadArchives：在archives配置中产生信息单元的文件，上传信息单元在archives配置中，包括 Jar 文件
- cleanTaskName：删除指定任务名所产生的项目构建目录，CleanJar会删除jar任务创建的jar文件，cleanTest将会删除由 test 任务创建的测试结果

## 16. 选择执行构建
使用 `-b` 或 `-p` 参数，可以更改执行 gradle 命令时所依赖的配置文件，即将配置文件从 `build.gradle` 改为其他文件或目录

1. `-b`: 参数用以指定脚本具体所在位置, 格式为 `gradel -b dirpwd/xxx.gradle task`.
2. `-p`: 参数用以指定脚本所在目录即可，格式为 `gradle -p dirpwd task`

## 17. 修改项的结构
```groovy
//Replaces conventional source code directory with list of different directories
sourceSets {
    main { java { srcDirs = ['src'] } }
//Replaces conventional test source code directory with list of different directories    
    test { java { srcDirs = ['test'] } }
}
//Changes project output property to directory out
buildDir = 'out'
```

## 18. 构建块
每个Gradle构建都包括三个基本的构建块：**项目(projects)**、**任务(tasks)** 和 **属性(properties)**，每个构建至少包括一个项目，项目包括一个或者多个任务，项目和任务都有很多个属性来控制构建过程。

Gradle运用了 **领域驱动的设计理念（DDD）** 来给自己的领域构建软件建模，因此Gradle的项目和任务都在Gradle的API中有一个直接的 **class** 来表示。
### 18.1 项目(Project)
当开始构建过程后，Gradle基于你的配置实例化 `org.gradle.api.Project` 这个类以及让这个项目通过 `project` 变量来隐式的获得.

![](..\pic\gradle\org.gradle.api.Project.png)

 `project` 允许你访问你项目所有的Gradle特性，比如任务的创建和依赖了管理:
#### 例子18.1.1：
```groovy
task printDescription {
    doLast {
        project.setDescription("myProject")
        println "Description of project $name: " + project.description
    }
}
```

### 18.2 任务(Task)
任务包括 **任务动作(actions)** 和 **任务依赖**，一个动作就是任务执行的时候一个原子的工作，这可以简单到打印hello world,也可以复杂到编译源代码。很多时候一个任务需要在另一个任务之后执行，尤其是当一个任务的输入依赖于另一个任务的输出时，比如项目打包成JAR文件之前先要编译成class文件，Gradle API中任务的接口是：`org.gradle.api.Task`。

![](..\pic\gradle\org.gradle.api.Task.png)

每个新创建的任务都是 `org.gradle.api.DefaultTask` 类型，它是 `org.gradle.api.Task` 的标准实现，`DefaultTask` 所有的域都是私有的，意味着他们只能通过 setter 和 getter 方法来访问，

### 18.3 属性(properties)
每个Project和Task实例都提供了setter和getter方法来访问属性，Gradle允许你通过外部属性来定义自己的变量，一般使用 `ext` 命名空间在 `build.gradel` 文件中给项目或任务添加属性。

通过在 `/.gradle` 路径或者项目根目录下的 `gradle.properties` 文件来定义属性可以直接注入到你的项目中，他们可以通过 project实例来访问，注意/.gradle目录下只能有一个 Gradle属性文件即使你有多个项目，在属性文件中定义的属性可以被所有的项目访问.

### 18.4 声明任务的动作
动作就是在你的任务中放置构建逻辑的地方，`Task` 接口提供了两个方法来声明任务的动作： `doFirst` 和 `doLast`，当任务执行的时候，定义在闭包里的动作逻辑就按顺序执行。

### 18.5 任务依赖执行顺序

Gradle并不保证依赖的任务能够按顺序执行，`dependsOn` 方法只是定义这些任务应该在这个任务之前执行，但是这些依赖的任务具体怎么执行它并不关心。在Gradle里面，执行顺序是由任务的输入输出特性决定的.

### 18.6 后置任务

在实际情况中，你可能需要在一个任务执行之后进行一些清理工作，一个典型的例子就是Web容器在部署应用之后要进行集成测试，Gradle提供了一个 `finalizer` 任务来实现这个功能，你可以用 `finalizedBy` 方法来结束一个指定的任务，开启一个新的任务
```groovy
task first << { println "first" }
task second << { println "second" }
//声明first结束后执行second任务
first.finalizedBy second
```

> **>** gradle first -q  
first  
second  

### 18.7 添加任务配置块

在定义任务时，可以不使用的动作或者使用左移操作符，在Gradle里称之为 **任务配置块(task configuration)**，这种配置任务块会在执行任何任务之前执行
```groovy
task printVersion {
    doLast {
        logger.quiet "Version: 0.0.1"
    }
}
task config {
    print '.....task configuration.....'
}
```

> **>** gradle -q printVersion  
.....task configuration.....  
Version: 0.0.1

## 19. Gradle的构建生命周期

无论你什么时候执行一个 `gradle build`,都会经过三个不同的阶段：**初始化**、**配置** 和 **执行**。

1. 在初始化阶段，Gradle给你的项目创建一个 `Project` 实例，你的构建脚本只定义了单个项目，在多项目构建的上下文环境中，构建的阶段更为重要。根据你正在执行的项目，Gradle找出这个项目的依赖。

2. 下一个阶段就是配置阶段，Gradle构建一些在构建过程中需要的一些模型数据，当你的项目或者指定的任务需要一些配置的时候这个阶段很有帮助。不管你执行哪个build哪怕是gradle tasks，配置代码都会执行

3. 在执行阶段任务按顺序执行，执行顺序是通过依赖关系决定的，标记为up-to-date的任务会跳过，比如任务B依赖于任务A，当你运行gradle B的时候执行顺序将是A->B。

## 20. 依赖管理
在Java领域里支持声明的自动依赖管理的有两个项目：
1. Apache Ivy(Ant项目用的比较多的依赖管理器)
2. Maven(在构建框架中包含一个依赖管理器)

**依赖管理的流程**  

![](..\pic\gradle\dependency-manager.png)

### 20.1 DependencyHandler
Gradle 中依赖的种类：  

![](..\pic\gradle\dependency-type.png)

每个Gradle项目都有一个 `DependencyHandler` 的实例，你可以通过 `getDependencies()` 方法来获取依赖处理器的引用，上表中每一种依赖类型在依赖处理器中都有一个相对应的方法。每一个依赖都是 `Dependency` 的一个实例，`group`, `name`, `version`, 和 `classifier` 这几个属性用来标识一个依赖，下图清晰的表示了 **项目(Project)** 、 **依赖处理器(DependencyHandler)**  和 **依赖** 三者之间的关系：

![](..\pic\gradle\relation-between-project-and-dependency.png)

在Gradle的术语里，外部库通常是以JAR文件的形式存在，称之为外部模块依赖，这种类型的依赖是通过属性来唯一的标识。

### 20.2 依赖的属性
当依赖管理器从仓库中查找依赖时，需要通过属性的结合来定位，最少需要提供一个 `name` 。
1. `group` ： 这个属性用来标识一个组织、公司或者项目，可以用点号分隔，Hibernate的group是 `org.hibernate` 。
2. `name` ： name属性唯一的描述了这个依赖，hibernate的核心库名称是 `hibernate-core` 。
3. `version` ： 一个库可以有很多个版本，通常会包含一个主版本号和次版本号，比如Hibernate核心库 `3.6.3-Final` 。
4. `classifier` ： 有时候需要另外一个属性来进一步的说明，比如说明运行时的环境，Hibernate核心库没有提供classifier。

### 20.2 排除传递依赖
Gradle允许你完全控制传递依赖，你可以选择排除全部的传递依赖也可以排除指定的依赖。排除依赖时，依赖需要写在 `cargo` 方法，在后面的花括号添加排除的依赖的信息，如：`cargo('xxx:xxx:xxx') { ... }`

可以使用 `exclude` 来排除指定的依赖，但 `exclude` 属性的值和正常的依赖声明不太一样，你只需要声明 `group` 或 `module`，Gradle不允许你只排除指定版本的依赖。
#### 例子20.2.1：
```groovy
dependencies {
    cargo('org.codehaus.cargo:cargo-ant:1.3.1') {
        exclude group: 'xml-apis', module: 'xml-apis'
    }
    cargo 'xml-apis:xml-apis:2.0.2'
}
```

Gradle允许你使用transitive属性来排除所有的传递依赖：
#### 例子20.2.2：
```groovy
dependencies {
    cargo('org.codehaus.cargo:cargo-ant:1.3.1') {
        transitive = false
    }
}
```

当要使用最新版本的依赖时，可以使用 `latest-integration` 指代版本，或者使用 `+` 指代一个最新版本数，如：`1.+`

## 21. 配置仓库
Gradle 仓库的类型：

![](..\pic\gradle\repository-type.png)

Repository 仓库的API：

![](..\pic\gradle\repository-api.png)


### 21.1 Maven
Maven仓库是Java项目中使用最为广泛的一个仓库，库文件一般是以JAR文件的形式存在，用XML(POM文件)来来描述库的元数据和它的传递依赖。所有的库文件都存储在仓库的指定位置，当你在构建脚本中声明了依赖时，`group`, `name`, `version` 等属性用来找到库文件在仓库中的准确位置。group属性标识了Maven仓库中的一个子目录，下图展示了Cargo依赖属性是怎么对应到仓库中的文件的：

![](..\pic\gradle\maven-artifact.png)

### 21.2 添加Maven仓库
RepositoryHandler接口提供了两个方法来定义Maven仓库，`mavenCentral` 方法添加一个指向仓库列表的引用，`mavenLocal`方法引用你文件系统中的本地Maven仓库，本地仓库默认在 `/.m2/repository` 目录下。

如果指定的依赖不存在与Maven仓库或者你想通过建立自己的企业仓库来确保可靠性，你可以使用自定义的仓库。仓库管理器允许你使用 **Maven布局** 来配置一个仓库，这意味着你要遵守 `artifact` 的存储模式。你也可以添加验证凭证来提供访问权限，Gradle的API提供两种方法配置自定义的仓库：`maven()`和 `mavenRepo()`。
```groovy
repositories {
    mavenCentral() //指定maven中央仓库
    mavenLocal() //指定默认的本地maven仓库
    //自定义本地maven仓库
    maven {
        name 'Custom Maven Repository',
        url 'http://repository.forge.cloudbees.com/release/')
    }
}
```

## Exec Task
> Command-line tools can be invoked through Gradle Exec tasks.

`Exec` 类型的task可以执行命令行的命令
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

## Jar Cache
Gradle下载的jar包存放路径：  
> C:\Users\Akigaze\.gradle\caches\modules-2\files-2.1

而修改jar包的缓存路径，只需添加一个 `GRADLE_USER_HOME` 的环境变量即可

## build timeout
有时Gradle build会有网络超时问题，此时可以把repository的地址切换成阿里云的仓库：
```groovy
maven{ url 'http://maven.aliyun.com/nexus/content/groups/public/'}
google()
```
# Link
### Offical
https://gradle.org/
### Git Book
Gradle User Guide 中文版  
https://dongchuan.gitbooks.io/gradle-user-guide-/content/  
Gradle In Action(Gradle实战)中文版  
https://lippiouyang.gitbooks.io/gradle-in-action-cn/content/
