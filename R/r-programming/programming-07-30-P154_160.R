# 置换函数：左边不是标识符(变量名)的赋值语句，这种赋值方式实际上就是在执行置换函数
v1 <- c(1, 2, 3)
names(v1) <- c("a", "b", "c") 
# names(v1) 并不是一个变量，所以这里R会尝试去执行它对应的置换函数
# names(v1) <- c("a", "b", "c")  ==>  v1 <- "names<-"(v1, value=c("a", "b", "c"))
# 左边的函数会变成 "funcName<-" 的一个函数
# 左边的函数的第一个参数会变从要赋值的对象，同时左边函数的所有参数都会变成置换函数的参数
# 右边的值会变成置换函数的value参数
v1
names(v1)

v1[1:2] <- c(0, 0)
# 对向量的元素赋值的语句也是一种置换函数
# 它实际上是 "["(v1, 1:2) <- c(0, 0), 所以会变成 v1 <- "[<-"(v1, 1:2, value=c(0, 0))
v1

help("names<-")

newBookVector <- function(x){
  temp <- list()
  temp$vec <- x
  temp$wrote <- rep(0, length(x))
  class(temp) <- "bookVector"
  return(temp)
}

"[.bookVector" <- function(bv, subs){
  return(bv$vec[subs])
}

"[<-.bookVector" <- function(bv, subs, value){
  bv$wrote[subs] <- bv$wrote[subs] + 1
  bv$vec <- value
  return(bv)
}
# "[.bookVector" 和 "[<-.bookVector" 似乎会识别参数是否是bookVector的类

bv <- newBookVector(c(1,2,3,4))
bv
bv[2]
bv[1] <- 0
bv[1]
bv[1] <- 10
bv

source("abc.R") # source() 引入其他R文件中的变量和方法
edit(haha)
edit(plus)
plus(1,2)

f1 <- function(){
  print(1)
}
f2 <- edit(f1) # edit() 能打开交互窗口对对象或者函数进行修改，返回修改后的值，但并不会改变原有的变量或函数
f2()

"e2ev" <- function(x, y) return(paste(x, y, "e2ev", sep = " ")) # 普通方法
e2ev("I", "like")
"%e2ev%" <- function(x, y) return(paste(x, y, "e2ev", sep = " ")) # 自定义二元运算符必须以%开头和结束
"I" %e2ev% "like"

# R同样支持匿名函数
m <- matrix(1:6, nrow = 3)
apply(m, 1, function(x) return(x+x))
























