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
