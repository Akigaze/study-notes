x <- c(1, 2, 1, 3, 4) # 声明向量，元素必须类型相同
y <- c(10, x, 0)
y
y[1] # 向量的下标从1开始
y[4]
y[1:4] # 支持向量的切片操作，包头包尾

data() # 查看R的所有内置数据集
Nile # 直接获取某个数据集

n <- 1

# 定义函数
addcount <- function(x){
  k <- 0
  for (i in x) {
    if(i %% 2 == 1) k <- k + 1 # 取模，使用 %% 运算符
  }
  return(k) # 方法的返回值使用 return() 函数进行返回
}
addcount(x) # 调用函数的方式都一样

f <- FALSE 
t <- TRUE # 布尔值使用全大写的 FALSE 和 TRUE，也可简写成 F和T

# 函数同样可以设置默认参数
isRight <- function(x=FALSE){
  return(x)
}

isRight(4)
isRight()

# R语言中不存在单个值，一切都是向量，看似单个值的变量是一元向量
1 == 1
c(1) == 1 # TRUE
length(x) == 5
length("abc") == 1
mode("abc") == "character"
st = paste("a", "5", "XX") # 使用空格连接字符串
st == "a 5 XX"
sp = strsplit(st, " ") # 拆解字符串，但结果是一个list
mode(sp) == "list"
## 矩阵
# 矩阵的对向量的维度拓展，所以要求元素类型一致
m1 = rbind(c(1, 4), c(8, 5)) # 将每个向量作为矩阵的一行
m2 = cbind(c(1, 4), c(8, 5)) # 将每个向量作为矩阵的一列
m1
m2
m1[2, 1] # 使用双下标对矩阵元素进行取值，返回结果为向量
m1[,1]
m1 %*% m2 # 向量乘法运算，使用 %*% 运算符
## 列表
# R中的列表更像是JSON对象，每个元素是一个键值对，称为列表的组件
li <- list(name="hello", age=18) #声明列表
li$name # 访问列表中指定key的值，使用 $ 符号，而不是 .
li$score = c(90, 192) # 向列表添加key和value
li$score

hileHist <- hist(Nile) # 绘制直方图，绘制图像的同时，返回图像的相关统计信息的列表
mode(hileHist) == "list"
str(hileHist) # 输出列表的结构，相比直接打印列表，结果看起来会更简洁
## 数据框
# 数据是矩阵与列表的结合
# 它更像关系数据库的数据表，每列有一个名称，且同一列数据类型相同，每一列的元素个数相同
df <- data.frame(list(name=c("qq", "mm", "qq"), age=c(23, 67, 0))) # data.frame() 函数将列表转数据框
df$name # $访问数据框某个字段(列)的值，得到的是这一列的所有水平

plot(c(1,3,5,6,9))
