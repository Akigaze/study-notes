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

该task中的doLast也可以使用 `<<` 代替，使用快捷的任务定义模式：
```groovy
task hello << {
    println 'Hello world!'
}
```

## Groovy
Gradle 使用 Groovy 语言来构建 `build.gradle` 脚本，而 Groovy 与Java非常相似：
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

表示task2必须在task2之后执行，若task2在task1之后声明，则会先加载执行task2，这称为 Lazy dependsOn 。

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
