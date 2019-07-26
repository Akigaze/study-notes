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















