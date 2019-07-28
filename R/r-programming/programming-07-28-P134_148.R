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


