teststopifnot <-function(){
  x <- 10
  stopifnot(x > 0)  # stopifnot(bool exression) 类似于断言，当条件不满足是，抛出异常，并不再执行方法后面的内容
  x <- 0
  stopifnot(x > 0)
  print(x)
}

teststopifnot()

# R中用于调试的方法有debug(), debugonce()，R的调试函数都是基于方法级别的，只能对某个方法使用，或者对方法中的某一行
# undebug() 取消对某个方法的调试
# browser() 设置断点，同时括号内可以添加断点的条件
# setBreakpoint(filename, linenumber) 在指定文件的某一行添加一个断点，可以在调试时执行该命令，能动态添加断点
f1 <- function(x){
  x <- x + 10
  return(x)
}

f2 <- function(x) {
  x <- x * 2
  browser()  # 相当于在某个位置设置断点
  return(x)
}

f3 <- function(){
  debug(f1)  # debug()一旦开启，必须手动关闭，否则每次执行对于方法都会进入调试模式,debufonce()可以只在第一次执行时进入调试模式
  x <- 1
  x <- f1(x)
  x <- f2(x)
  print(x)
  undebug(f1)
}

f3()

f1(0)
# 当进入调试模式后，可以在命令行输入一些命令控制调试的执行
# n/Enter: next，下一行
# c: continue, 剩下的全部代码，直到下一个断点为止
# 变量名: 查看变量
# where: 输出栈跟踪路径
# Q: 退出

# trace(func, torun) 能够在进入方法时，调用指定的方法，如tracr(f1, browser) 会在进入f1方法时，就在方法第一行添加一个browser的断点
# trace() 可以避免手动在核心方法中添加有逻辑无关的调试代码
# untrace(func) 取消trace()的设定

# options(error=recover) 设置程序在出现异常时自动进入调试模式

runif(1)

n <- 0
system.time(for (i in 1:10000) {
  n <- n + i
})

system.time(sum(1:10000)) # system.time() 计算某个表达式执行的时间
print(n)

library(compiler) # 字节码编译模块
fcmp <- cmpfun(f1) # 将指定函数编译成字节码，返回编译后的函数，编译的作用是提升代码的运行速度

# python 中使用R的模块：RPy
# 导入RPy模块后，要执行R的函数或变量，需要使用r对象进行调用