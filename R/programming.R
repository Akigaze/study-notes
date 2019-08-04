# R 循环语句
for (i in 1:10) {
  print(i^2)
}

i <- 1
while (i < 10) {
  print(i^3)
  i <- i + 1
}

i <- 1
repeat{ # repeat 循环语句只有循环体，不设置条件，所以需要在循环体内部使用break结束循环
  print(i^4)
  i <- i + 1
  if(i > 10) break
}
# R中使用next关键字代替了其他语言常用的continue用于跳过当前循环

m1 <- matrix(1:10, nrow = 2, byrow = TRUE)
for (i in m1) {
  print(2*i)
}
# 以上的循环语句可以对普通向量和矩阵直接使用

get('m1') # 通过变量名的字符串，从当前的上下文中找到同名的对象，返回它的值
m2 <- matrix(rep(c(0,4,2), 3), nrow=3)
for (m in c('m1', 'm2')) {
  mm <- get(m)
  print(lm(mm[1,]~mm[2,]))
}
# if-else
# 即使 if-else 的执行语句都只有当行，也不能省略花括号，除非和if/else写在同一行
# if-else或默认返回最后一行赋值语句的值，或出现的变量
age <- 10
vif <- if (age > 12) "good" else "little"
vif

# 运算符
mode(10/2)
10%/%2
# R中的&&和||会将向量当成一个整体进行布尔元素，通常只去向量的第一个元素进行比较
# 而&和|则支持向量化操作
c(1,2,3)&& c(0,9,0)
c(1,2,3)&& c(1,9,0)
c(0,2,3)&& c(1,9,0)
c(0,2,3) & c(1,9,0)

# 具名参数，默认参数
nameFunc <- function(x, y=0, z){
  print(x*z + y)
}

nameFunc(1, z=2)
nameFunc(1, 3, y = 2)
nameFunc(y=9, 1, 2)
# 当使用具名参数进行传参时，R会想对所用具名的参数进行赋值，在根据其他参数的顺序对没有使用具名参数的参数进行赋值

###

g <- function(x){
  return(x+1)
}

body(g) # body()获取函数体的表达式
formals(g) # formals()获取函数的参数列表
# body() 和 formals() 函数同样也可以用于修改函数的参数和方法体 
# 为方法体赋值时，需要使用quote()函数，将方法体的内容作为参数，不让R会将方法体当成表达式直接执行


page(abline) # 将函数用其他文本或软件输出

g1 <- function(x) return(sin(x))
g2 <- function(x) return(sqrt(x^2+1))
g3 <- function(x) return(2*x-1)
for (f in c(g1,g2,g3)) {
  plot(f, 0, 100, add=TRUE)
}

ls() # ls() 列出所在作用域(环境)中的定义的变量和方法
ls.str() # ls.str() 在ls() 的基础上，输出了变量定义的一些信息
# ls() 的envir参数函数调用所在的局部环境或全局环境，输出对应环境的变量信息

# R在函数的方法体中，是无法修改实参或者全局变量的，在修改之前，形参会与实参共享一个内存地址，知道修改时，R会为形参重新分配地址
# 只有使用超赋值运算符才能在局部修改全局
.GlobalEnv # 全局环境的引用
parent.frame(n=1) # parent.frame() 函数可以获取当前环境之上的第n个环境的引用

showframe <- function(upn){
  env <- if(upn < 0) .GlobalEnv else parent.frame(n=upn+1)
  vars <- ls(envir = env)
  for (v in vars) {
    vrg <- get(v, envir = env)
    if(!is.function(vrg)){
      cat(v, ":\n", sep = "")
      print(vrg)
    }
  }
}

h <- function(aaa){
  c <- 3
  return(aaa+c)
}

g <- function(aa){
  b <- 2
  showframe(0)
  showframe(1)
  aab <- h(aa+b)
  return(aab)
}

f <- function(){
  a <- 1
  return(g(a)+a)
}

f()

cat("1", "2", sep = ",") # cat() 是print的增强版

###

# R语言没有引用类型，所以在方法内部无法修改外部传入的实参，只能通过重新赋值

# 对全局变量或上级层次的变量进行修改
# 1. 超赋值运算符 <<-
twice <- function(u){
  u <<- 2*u # <<- 会在上一级层次中找同名的变量，找不到就一直向上找，知道找到同名就他进行修改，如果找不到同名，则会创建一个全局变量
  z <- 2*z
}
x <- 1
z <- 2
u
twice(x) # 虽然传入的实参是x，但R会将x的值复制一份给形参u，随意u和x并没有任何引用关系
x == 1

y <- -1
testf <- function(){
  inc <- function(){y <<-3} # y会优先从上一级查找
  y <- 0
  inc()
  return(y)
}

testf() == 3
y

# 2. assign() 修改非局部变量
# assign('name', value, pos=env)

twice2 <- function(u){
  assign("u", 2*u, pos = .GlobalEnv)
  z <- 2*z
}

xx <- 1
twice2(xx)
xx
u

# example: 离散事件仿真 Discrete-event simulation DES

eventRow <- function(eventtime, eventtype, appin=NULL){
  row <- c(list(eventtime=eventtime, eventtype=eventtype), appin)
  return(as.data.frame(row))
}

scheduleEvent <- function(eventtime, eventtype, appin=NULL){
  # print("-------------")
  # print(appin)
  newevent <- eventRow(eventtime, eventtype, appin)
  if(is.null(sim$events)){
    sim$events <<- newevent
  }
  # print(sim)
  inspt <- binsearch((sim$events)$eventtime, eventtime)
  before <- if(inspt == 1) NULL else sim$events[1:(inspt-1),]
  nr <- nrow(sim$events)
  after <- if(inspt <= nr) sim$events[inspt:nr,] else NULL
  # print("------before-----")
  # print(before)
  # print("------new-----")
  # print(newevent)
  # print("------after-----")
  # print(after)
  sim$events <<- rbind(before, newevent, after)
}

binsearch <- function(x, y){
  # print(x)
  # print(y)
  n <- length(x)
  lo <- 1
  hi <- n
  while (lo+1 < hi) {
    mid <- floor((lo+hi)/2)
    if(y == x[mid]) return(mid)
    if(y < x[mid]) hi < mid else lo <- mid
  }
  if(y <= x[lo]) return(lo)
  if(y < x[hi]) return(hi)
  return(hi+1)
}

getNextEvent <- function(){
  head <- sim$events[1,]
  sim$events <<- if(nrow(sim$events) == 1) NULL else sim$events[-1,]
  return(head)
}

dosim <- function(initglbls, reactevent, prntrslts, maxsimtime,apppars=NULL, dbg=FALSE){
  sim <<- list()
  sim$currentTime <<- 0.0
  sim$events <<- NULL
  sim$dbg <<- dbg
  initglbls(apppars)
  while (sim$currentTime < maxsimtime) {
    head <- getNextEvent()
    sim$currentTimne <<-head$eventtime
    reactevent(head)
    if(dbg) print(sim)
  }
  prntrslts()
}

### application example
mm1initglbls <- function(apppars){
  mm1glbls <<- list()
  mm1glbls$arrvrate <<- apppars$arrvrate
  mm1glbls$srvrate <<- apppars$srvrate
  mm1glbls$srvq <<- vector(length = 0)
  mm1glbls$njobsdone <<- 0.0
  mm1glbls$totwait <<- 0.0
  arrvtime <- rexp(1, mm1glbls$arrvrate)
  # print("--------")
  # print(arrvtime)
  scheduleEvent(arrvtime, "arrv", list(arrvtime=arrvtime))
}

mm1reactevent <- function(head){
  if(head$eventtype == "arrv"){
    if(length(mm1glbls$srvq) == 0){
      mm1glbls$srvq <<- head$arrvtime
      srvdonetime <- sim$currentTime + rexp(1, mm1glbls$srvrate)
      # print("----1----")
      # print(srvdonetime)
      scheduleEvent(srvdonetime, "srvdone", list(arrvtime=srvdonetime))
    }else{
      mm1glbls$srvq <<- c(mm1glbls$srvq, head$arrvtime)
    }
    arrvtime <- sim$currentTime + rexp(1, mm1glbls$srvrate)
    # print("----2----")
    # print(arrvtime)
    scheduleEvent(arrvtime, "arrv", list(arrvtime=arrvtime))
  }else{
    mm1glbls$njobsdone <<- mm1glbls$njobsdone + 1
    mm1glbls$totwait <<- mm1glbls$totwait + sim$currentTime - head$arrvtime
    mm1glbls$srvq <<- mm1glbls$srvq[-1]
    if(length(mm1glbls$srvq) > 0){
      srvdonetime <- sim$currentTime + rexp(1, mm1glbls$srvrate)
      # print("----3----")
      # print(srvdonetime)
      scheduleEvent(srvdonetime, "srvdone", list(arrvtime=mm1glbls$srvq[1]))
    }
  }
}

mm1prntrslts <- function(){
  print("mean wait:")
  print(mm1glbls$totwait/mm1glbls$njobsdone)
}

# run
dosim(mm1initglbls, mm1reactevent, mm1prntrslts, 10000.0, list(arrvrate=0.5, srvrate=1.0))


# 闭包
counter <- function(){
  ctr <- 0
  f <- function(){
    ctr <<- ctr + 1
    cat("this count currently has value", ctr, "\n")
  }
  return(f)
}

counter1 <- counter()
counter2 <- counter()
counter1
counter2

counter1()
counter1()
counter2()
counter2()
counter1()

###

# 递归 recursive
# 快速排序 quick sort
quickSort <- function(v){
  if(length(v) <= 1) return(v)
  pivot <- v[1]
  rest <- v[-1]
  smaller <- rest[rest < pivot]
  bigger <- rest[rest >= pivot]
  smaller <- quickSort(smaller)
  bigger <- quickSort(bigger)
  
  return(c(smaller, pivot, bigger))
}

quickSort(c(3,5,1,3,7,4))

v1 <- c(1,2,3)
v1[v1 > 4] # 没有满足条件的元素时，返回一个空的向量，也可以理解为NULL
length(v1[v1 > 4]) # 长度为0
c(v1[v1 > 4], 0) # 空向量会被自动忽略

# 使用R实现二叉查找树：R没有指针，所以采用索引来查找节点
# 使用一个矩阵存储树的信息，每一行为一个节点
# 每行第三个元素为节点的值，第一，二个元素分别是左右字数所在行的索引

printTree <- function(hdidx, tree){
  left <- tree$mat[hdidx, 1]
  if(!is.na(left)) printTree(left, tree)
  print(tree$mat[hdidx, 3])
  right <- tree$mat[hdidx, 2]
  if(!is.na(right)) printTree(right, tree)
}


createTree <- function(root, inc){
  m <- matrix(rep(NA, inc*3), ncol = 3)
  m[1,3] <- root
  return(list(mat=m, nxt=2, inc=inc))
}

insertNode <- function(hdidx, tree, value) {
  dir <- if(value <= tree$mat[hdidx, 3]) 1 else 2
  if(is.na(tree$mat[hdidx, dir])){
    newids <- tree$nxt
    if(tree$nxt == nrow(tree$mat)+1){
      tree$mat <- rbind(tree$mat, matrix(rep(NA, tree$inc*3), ncol = 3))
    }
    tree$mat[newids, 3] <- value
    tree$mat[hdidx, dir] <-newids
    tree$nxt <- tree$nxt + 1
    return(tree)
  }else{
    return(insertNode(tree$mat[hdidx, dir], tree, value))
  }
}


tree <- createTree(8, 3)
tree <- insertNode(1, tree, 5)
tree <- insertNode(1, tree, 6)
tree <- insertNode(1, tree, 2)
tree <- insertNode(1, tree, 12)
tree <- insertNode(1, tree, 9)



tree
printTree(1, tree)

###

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
