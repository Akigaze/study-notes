# Gradle 命令
## gradle -v
`-v` = `--version`
查看版本

## gradle -h
`-h` = `--help`
获取帮助


# Gradle Task
gradle的任务，包括内置的，插件自带的和用户自定义的三种，执行时使用`gradle taskName params`的形式，与一般的gradle命令不同，任务名称前面不用加`-`或`--`

## gradle <task\> ...
To run a build, run gradle <task> ...

## gradle tasks
To see a list of available tasks.  
查看可执行的任务(命令)，包括：`init`，`help` 等

## gradle help --task <task>
To see more detail about a task.  
获取帮助，查看具体某个task(命令)的用法
> gredle help --type  <task\>  

单独执行`gradle help`会输出gradle的基本信息和一些关于task的提示

## gradle init
初始化项目

### 初始化java应用
> gradle init --type=java-application  
或  
> gradle init --type groovy-application

创建一个Java的gradle项目，包含了 `src`，`main`，`test` 等目录

![Gradle init project](..\pic\gradle\gradle init.png)

## gradle run
执行项目

可以添加`-q`(`--quiet`)参数，输出简洁的结果

## gradle clean
清除打包生成的build文件夹

## gradle build
编译，打包项目，会在项目根目录下生成一个build文件夹，里面包含了.class，.jar和测试报告等文件

打包之前，会默认执行`gradle clean`命令，先清除之前的build文件夹

## gradle wrapper
生成Gradle Wrapper

> gradle wrapper --gradle-version xx.xx

指定生成的Gradle Wrapper所使用的Gradle版本

## gradle <task1\> <task2\>
同时执行多个任务

# Link
### Blog
Wrapper (gradlew)  
https://www.zybuluo.com/xtccc/note/275168
### Offical Document
官网  
https://gradle.org/  
Gradle User Guide 中文版  
https://dongchuan.gitbooks.io/gradle-user-guide-/  
### groovy
官网  
http://www.groovy-lang.org/index.html
