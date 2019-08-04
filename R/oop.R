# R 支持封装(Encapsulation)，继承(Inheritance)和多态(Polymorphic)
# R中的类主要有两种类型：S3类和S4类，它们的区别在与类的结构，同时S4类是在S3类的基础上发展起来的，具有更高的使用安全性
# S3泛型函数：根据不同的调用对象(参数类型)，同一个函数执行不同的操作，类似于多态性，如plot(), print()
?lm # lm() 是R中一个做简单线性回归分析的函数, 它会返回一个"lm"类的对象
x <- c(1,2,3,4)
y <- c(4,3,2,1)
lmout <- lm(x~y)
class(lmout)
lmout
print(lmout)
# 这里print() 是一个泛型函数，他会根据调用对象(参数)的不同，执行相应的函数
# 这里lmout是一个"lm"类，所以print()实际调用的是print.lm()这个函数(func.className())
?print
print(unclass(lmout)) # unclass() 消除类性质之后，print输出的结果就不一样了
# 查看泛型函数
methods(print) # methods() 可以输出指定函数的所有泛型函数，其中标注*表示不可见，即当前空间下不可见
methods(class = 'Employee') # 查看指定类的泛型函数
getAnywhere(print.aspell) # getAnywhere()查看函数的信息，包括不可见函数，通过获取函数的名称空间可以显式执行不可见函数
utils:::print.aspell() # namespace:::func 执行名称空间下制定的函数，::: 为限定符

# S3类的类的本质是一个具有class属性的list，list的组件就是这个类的成员变量，通过class()函数为list指定类名(字符串)，这样这个list就变成了一个类
Emplolee <- function(name, salary, age, union=TRUE){
  e <- list(name=name, age=age, salary=salary, union=union)
  class(e) <- "Employee"
  return(e)
}
e1 <- Emplolee("A", 12222, 90)
e1 # 没有相应print()函数泛型的类对象在输出时，会当成一个普通的list输出，只是会带有attr(,"class")类名属性的值
attributes(e1) # attributes() 输出类对象的属性，可以看到list的组件为普通属性，另外还有一个class属性
# 函数关于某个类的泛型函数时，只需要使用func.className的形式为函数命名，R就会根据类名调用相应的泛型函数
print.Employee <- function(e){
  cat(e$name, '\n')
  cat('age', e$age, '\n')
  cat('salary', e$salary, '\n')
  cat('union member', e$union, '\n')
}
print(e1)
print.Employee(e1)
e1

# R中的继承，实际上就是为一个list指定多个class，即为class赋值为一个类名字符串的向量，靠前的类优先级最高，即左边的是子类，右边的是父类
HourlyEmplolee <- function(name, salary, age, hours, union=TRUE){
  e <- list(name=name, age=age, salary=salary, hours=hours, union=union)
  class(e) <- c("HourlyEmplolee", "Employee")
  return(e)
}

he1 <- HourlyEmplolee("A", 12222, 90, 100)
class(he1) # 具有两个类
attributes(he1)

he1 # 执行泛型函数时，会想找子类的泛型函数，找不到再找父类的

###

# 存储上三角函数所有非0值的类ut

sum1toi <- function(i) return(i*(i+1)/2)

expandut <- function(utmat){
  n <- length(utmat$ix)
  fullmat <- matrix(nrow = n,ncol = n)
  for (i in 1:n) {
    start <- utmat$ix[i]
    fin <- start + i - 1
    abovediagi <- utmat$mat[start:fin]
    fullmat[,i] <- c(abovediagi, rep(0, n-i))
  }
  return(fullmat)
}

"%mut%" <- function(ut1, ut2){
  n <- length(ut1$ix)
  utprod <- ut(matrix(nrow = n,ncol = n))
  for(i in 1:n){
    starti <- ut2$ix[i]
    prodcoli <- rep(0, i)
    for (j in 1:i) {
      startj <- ut1$ix[j]
      bielement <- ut2$mat[starti+j-1]
      prodcoli[1:j] <- prodcoli[1:j] + bielement * ut1$mat[startj:(startj+j-1)]
    }
    startprodcoli <- sum1toi(1-i) + 1
    utprod$mat[starti:(starti+i-1)] <- prodcoli
  }
  return(utprod)
}

print.ut <- function(utmat){
  print(expandut(utmat))
}

ut <- function(inmat){
  n <- nrow(inmat)
  result <- list()
  class(result) <- "ut"
  result$mat <- vector(length = sum1toi(n))
  result$ix <- sum1toi(0:(n-1)) + 1
  for (i in 1:n) {
    ixi <- result$ix[i]
    result$mat[ixi:(ixi+i-1)] <- inmat[1:i,i]
  }
  # 以上的for循环可以替换成：
  # result$mat <- inmat[col(inmat) >= row(inmat)]
  return(result)
}


ut(rbind(1:2, c(0, 2)))
ut1 <- ut(rbind(1:2, c(0, 2)))
ut2 <- ut(rbind(3:2, c(0, 1)))
ut1 %mut% ut2

col(matrix(1:9, nrow = 3)) # col()返回一个相同大小的矩阵，但是每个位置的值为其所在列的编号
row(matrix(1:9, nrow = 3)) # row()返回一个相同大小的矩阵，但是每个位置的值为其所在行的编号


## 多项式回归程序
ployfit <- function(y, x, maxdeg){
  pwrs <- powers(x, maxdeg)
  lmout <- list()
  class(lmout) <- "ployreg"
  for (i in 1:maxdeg) {
    lmo <- lm(y~pwrs[,1:i])
    lmo$fitted.cvvalues <- leave1out(y, pwrs[,1:i,drop=FALSE])
    lmout[[i]] <- lmo
  }
  lmout$x <- x
  lmout$y <- y
  return(lmout)
}

print.ployreg <- function(fits){
  maxdeg <- length(fits) - 2
  n <- length(fits$y)
  tbl <- matrix(nrow = maxdeg, ncol = 1)
  colnames(tbl) <- "MSPE"
  for(i in 1:maxdeg){
    fi <- fits[[i]]
    errs <- fits$y - fi$fitted.cvvalues
    spe <- crossprod(errs, errs)
    tbl[i,1] <- spe/n
  }
  cat("mean squared prediction errors, by degree\n")
  print(tbl)
}

powers <- function(x, dg){
  pw <- matrix(x, nrow = length(x))
  prod <- x
  for(i in 2:dg){
    prod <- prod * x
    pw <- cbind(pw, prod)
  }
  return(pw)
}

leave1out <- function(y, xmat){
  n <- length(y)
  predy <- vector(length = n)
  for(i in 1:n){
    lmo <- lm(y[-1]~xmat[-i,])
    betahat <- as.vector(lmo$coef)
    predy[i] <- betahat %*% c(1, xmat[i,])
  }
  return(predy)
}

ploy <- function(x, cfs){
  val <- cfs[1]
  prod <- 1
  dg <- length(cfs) - 1
  for(i in 1:dg){
    prod <- prod * x
    val <- val + cfs[i+1] * prod
  }
  return(list(value=val, prod=prod))
}

testPloyfit <- function(){
  n <- 60
  x <- (1:n)/n
  y <- vector(length = n)
  for (i in 1:n) {
    y[i] <- sin((3*pi/2)*x[i]) + x[i]^2 + rnorm(1, mean = 0, sd=0.5)
  }
  dg <- 15
  (lmo <- ployfit(y, x, dg)) # 赋值语句使用括号，可以在赋值完成后打印出变量
}

testPloyfit()

?"~"

# S4类
# 由于S3类的本质是list，所以访问S3类的属性使用"obj$property"
# S3类的不安全性在于，其本质是list，所以可以对list添加，修改，访问任何属性，即使属性不存在也不会有异常
# S4类就是在S3类的基础上提升了安全性，限定了类属性的名称，数量，数据类型等，并且有异常提示
# setClass() 定义S4类
setClass("employee", representation(name="character", salary="numeric", union="logical")) # "characher": 字符串，"numeric"：数字，"logical"：布尔
# 指定类名(字符串)，使用representation() 定义所有的类属性及其数据类型
# new() 创建类对象
joe <- new("employee", name="Joe", salary=8000, union=FALSE) # 指定类，初始化对象属性
joe # 对于S4类，成员变量称为slot，要使用 "@" 进行访问，而不再是S3类的 "$"
joe@salary # 获取属性值
joe@salary <- 10000 # 修改属性值
joe@age <- 18 # 不允许访问或添加类定义时不存在的属性
joe
class(joe)
attributes(joe)
# 除了使用"@"访问属性，还可以使用slot()访问指定属性
slot(joe, "name") # 访问属性
slot(joe, "salary") <- 12000 # 修改属性
slot(joe, "salary")
slot(joe, "age") <- 10 # 同样不允许访问或添加类定义时不存在的属性
# 对于打印S4类，R调用的不是print方法，而是show() 方法，所以S4类专用的打印方法时show()
print(joe)
show(joe)
# 为S4类创建泛型函数，要使用 setMethod() 方法，为指定的函数，指定S4类创建泛型函数
setMethod("show", "employee", function(object){ # 泛型方法的参数名貌似规定是object
  inorout <- ifelse(object@union, "is", "is not")
  cat(object@name, "has a salary of", object@salary, "and", inorout, "in the union.", "\n")
})

show(joe) 
joe

# 对象管理
# ls() 查看当前内存中的所有对象，返回对象名的一个向量
ls()
ls(pattern = "ploy") # pattern参数可以指定对象名的通配符(包含的字符)
# rm() 删除内存中的对象
x <- "remove me"
y <- "remove it"
ls(pattern = "x|y")
ls(pattern = "x|y")
rm(x) # 删除指定对象
rm(x, y) # 同时删除多个对象
rm(list = c("x", "y")) # list参数接受一个对象名的字符串向量
rm(list = ls(pattern = "x|y")) # rm() 与 ls() 组合使用
# save()将对象持久化到文件中，load()从文件中反序列化出对象
x <- rnorm(100)
hx <- hist(x)
?save
save(hx, "hx.txt") # 弩之为何用不了
load("hx.txt")

edit(table)
exists("x") # exists() 判断内存中是否已存在指定名称的对象
rm(list = ls())


