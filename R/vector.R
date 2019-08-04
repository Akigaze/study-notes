# example(persp)
x <- c(1,6,2,6,9)
mode(x)
typeof(x)

x <- c(x[1:2], 10, 48, x[3:5]) # x 只是对向量的引用，向量的在创建时就固定了
length(x) # 获取向量的长度
1:5 # A:B 返回从A开始，以整数1为间隔的所有小于等于B的数
1:-5 == c(1, 0, -1, -2, -3, -4, -5)
1.2:5.7 == c(1.2, 2.2, 3.2, 4.2, 5.2)
3:6+4 == c(7,8,9,10) # : 的优先级高于普通运算符

# 对向量进行运算时，如果两个向量长度不一致，R会自动对短的一个进行循环补齐
# 矩阵实际是一种特殊的向量，增加了行和列维度，但R在处理时是将矩阵当做一个长向量进行处理，默认按列连接
y <- c(0,1,3) + c(1,2,3,4,5) # 实际运行为 c(0,1,3,0,1) + c(1,2,3,4,5)
m1 <- matrix(c(1,2,3,4,5,6), nrow = 3, ncol = 2)
# 矩阵与向量进行运算时，是将矩阵还原成向量，进行向量运算，在将结果转化为原有维度的矩阵
m1 + c(0, 1) # 实际为 c(1,2,3,4,5,6)+c(0,1,0,1,0,1)
# m1 + c(1,1,1,1,1,1,1,1,1,1,1,1,1) 抛出异常，向量长度不能超过矩阵长度

2+3 == 5
"+"(2,3) == 5 # R中每个运算符就是一个函数，R调用函数的方式也可以函数名的字符串，在加上括号
"length"(c(0,4,5))
# R中的运算符 + - * / %% == > < 都只能对一元向量进行运算
# 当向量使用这些运算符时，实际是每个元素都进行一次相应的运算，并且会进行循环补齐
c(1,2,3) * c(0,2,1) == c(0,4,3)
c(1,2,3) / c(0,2) == c(Inf, 1 , Inf)
c(7,8,5) %% c(3,2,4) == c(1,0,1)
(c(0,1) == c(0,2,3)) == c(TRUE, FALSE, FALSE)
(c(0,1) == c(0,2,3)) == c(TRUE, FALSE, FALSE)
(c(2,6,9,3) > 5) == c(FALSE,TRUE,TRUE,FALSE) 
(c(6,5,9,3) >= 5) == c(TRUE,TRUE,TRUE,FALSE) 

# 向量的索引取值使用[]，放入[]中的实际上还是向量，R会找出所有下标与[]中向量的元素相同的项，组成新的向量
v1 <- c(2,4,5,67,2,65,78)
v1[c(9,4)] == c(NA, 67) # 下标越界时返回NA
v1[4:6] == c(67,2,65)
v1[3] == c(5)
v1[c(-2,-3)] == c(2, 67, 2, 65, 78) # 负数表示排除，取之外的元素
excludeLast <- function(v){
  return(v[-length(v)])
}
excludeLast(excludeLast(v1)) == c(2,4,5,67,2) 

# seq()函数
# 1. 可以类似于 : 创建向量序列，并且可以设置元素的间距
seq(from=2.1, to=9.9, by=0.5) # by参数设置元素的间距
# 默认 from=1，to=1，by=1
seq() == 1
# 根据参数数量有不同的实现
seq(5) == c(1,2,3,4,5) 
# 2. 当参数是一个长度大于1的向量时，取该向量的下标作为结果
seq(c(3,7,9,1)) == c(1,2,3,4)
# rep()生成重复序列函数
# 将指定向量重复指定次数，拼接成新的向量，同时能指定每次复制时每个元素的重复次数
rep(c(1,3), times=3) == c(1, 3, 1, 3, 1, 3)
rep(0, times=4) == c(0,0,0,0)
rep(c(3,6), 3, each=2) == c(3, 3, 6, 6, 3, 3, 6, 6, 3, 3, 6, 6) # each 指定每次复制时每个元素的重复次数
rep(4) # 默认只输出一次

# all() any() 用于判断向量中TRUE的个数
any(c(4,1,7,3) < 3) == TRUE # 是否向量中包含TRUE
any(c(4,1,7,3) < 1) == FALSE 
all(c(4,1,7,3) < 5) == FALSE # 是否全部为TRUE
all(c(4,1,7,3) < 8) == TRUE

###

# 连续字符的游程
findRuns <- function(v, k, n){
  len <- length(v)
  runs <- NULL # R中null使用全大写
  for (i in 1:(len-k+1)) {
    if (all(v[i:(i+k-1)] == n)) runs <- c(runs, i)
  }
  return(runs)
}
findRuns(c(2,2,2,3,2,2,4,2,3), 2, 2)

#NULL不能作为向量的元素，值为NULL的变量也不是一元向量
x <- NULL # x的值为NULL，但它不是一个一元向量
c(NULL, 1, 2) == c(1, 2) # 在向量中，NULL 会被自动去掉


# vector()函数创建空的向量，并提前分配好内存(向量长度)，在不为元素赋值的情况下，默认所有元素为FALSE
v1 <- vector(length = 3) 
v1 == c(FALSE, FALSE, FALSE)
v1[2] = 10 # 为任意位置的元素赋值，此时所有元素会进行基本数据类型的自动转换
v1[1] = "A" # 转换的优先级为 string > number > bool
v1[3] = TRUE

###

# majority rule 过半数规则
preda <- function(data, k){
  n <- length(data)
  preds <- vector(length = n-k)
  for (i in 1:(n-k)) {
    # sum() 求和
    if(sum(data[i:(i+k-1)]) >= k/2){
      preds[i] <- 1
    }else{
      preds[i] <- 0
    }
  }
  # abs() 取绝对值，mean() 求平均值
  effect <- mean(abs(preds - data[(k+1):n]))
  return(effect)
}

str(Nile)
Nile
preda(rep(c(0,1,1,0,1,0,1,1), 3), 3)

# cumsum() 累计求和
cumsum(c(1,2,3,4,5,6)) == c(1,3,6,10,15,21)
predc <- function(data, k){
  n <- length(data)
  preds <- vector(length = n-k)
  csx <- c(0, cumsum(data))
  for (i in 1:(n-k)) {
    if(csx[i+k] - csx[i] >= k/2){
      preds[i] <- 1
    }else{
      preds[i] <- 0
    }
  }
  effect <- mean(abs(preds - data[(k+1):n]))
  return(effect)
}
predc(rep(c(0,1,1,0,1,0,1,1), 3), 3)
# 向量化 vectorize 即将操作应用到向量中的每一个元素
# 向量化操作符：+，-，*，/，^，%，>，<，==
#向量化函数：三角函数，平方根，取整等
round(c(1.2, 4.5, 8.4, 6.0)) == c(1, 4, 8, 6) #round() 向下取整

# 矩阵输出
matrix(1:20, nrow = 4, ncol = 5) # matrix()将向量转矩阵，需要指定行数和列数，矩阵默认是按列排布
matrix(1:20, nrow = 3)

###

# NA 缺失值，未知的值，往往是一个必要的值，不会直接忽略
# NULL 不存在的值，从一开始就不存在的值，会被自动忽略
withNA <- c(10, 45, 23, NA, 67)
withNA
mean(withNA) # mean() 无法自动跳过NA，因此无法计算结果
mean(withNA, na.rm = TRUE) # 将 na.rm 参数设置为TRUE可以忽略NA
withNULL <- c(10, 45, 23, NULL, 67)
withNULL # NULL 为不存在的值，在输出是就被自动忽略了
mean(withNULL)
stringWithNA <- c("A", NA, "C")
mode(stringWithNA[1]) == "character"
mode(stringWithNA[2]) == "character" # NA 表示向量中一个丢失的值，因此它的模式会与向量中的其他元素一致
numberWithNA <- c(10, NA, 8)
mode(numberWithNA[1]) == "numeric"
mode(numberWithNA[2]) == "numeric"

mode(NULL) == "NULL"
mode(NA) == "logical"
# 筛选
v1 <- c(3, 4, 2, 6, 1)
v1[c(1,4)] # 索引组成的向量取值
v1[c(TRUE, FALSE)] # 使用bool类型的向量进行元素筛选，TRUE是要返回的，用于筛选的bool向量会进行循环补齐
v1[v1*v1 > 10] == c(4, 6) # 平方大于10的元素
# 向量元素赋值
v2 <- c(3, 4, 2, 6, 1)
v2[1] <- 10 # 指定某个下标的元素赋值
v2[1:3] <- 8 # 同时对多个下标的元素进行赋值，循环补齐
# 可见 <- 也是一个向量化的操作符
v2[1] <- c(1, 0) # 警告，一个下标只能赋值为一个一元向量，使用多元向量进行赋值时，只去第一个元素
v2[1:2] <- c(1, 0) 
x <- c(65,22,76,34,6,23)
x[x%%2 == 0] <- 0 # 将所有偶数改成0
x
v2 <- c(0,1) # 直接对变量名进行赋值，那就是对整个对象进行重新赋值，使用[]那就只是针对部分元素赋值
v2[NA] # 返回NA
v2[NULL]

# 对NA的操作返回结果为NA
# NA == NA  结果为NA
NA > 0
NA * 100

#subset()筛选
# 类似[] 与bool向量的筛选，只是可以自动过滤NA
v3 <- c(2,4,NA,7,5,6)
subset(c(2,4,1,7,5,6), TRUE) # 向量，用于筛选的bool向量
subset(v3, v3 > 4)

# which() 选择(下标)函数
# 返回向量中值为TRUE的元素的下标
v4 <- c(4,76,23,45,2,56)
which(v4%%4 == 0) # 值是4的倍数的元素下标
v100 <-which(v4%%100 == 0) #integer(0)

# 返回第一个满足条件的元素的下标
findIndex <- function(v, target){
  finds <-which(v == target)
  print(mode(finds))
  if(length(finds)){
    return(finds[1])
  }
  return(NULL)
}

findIndex(c(2,4,1,6,4), 4)
findIndex(c(2,4,1,6,4), 5)

###

# if-else的向量化函数
v1 <- 1:12
v1%%2==0
ifelse(v1%%2==0, 0, 1) == rep(c(1, 0), 6) #c(1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0)
ifelse(v1%%2==0, c("A", "B"), "N")
# condition:   FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE
# if TRUE:     "A"    "B"  "A"    "B"  "A"    "B"  "A"    "B"  "A"    "B"  "A"    "B"  
# if FALSE:    "N"    "N"  "N"    "N"  "N"    "N"  "N"    "N"  "N"    "N"  "N"    "N"  
# result:      "N"    "B"  "N"    "B"  "N"    "B"  "N"    "B"  "N"    "B"  "N"    "B"
# ifelse(bools, yes, no) 
# bool向量的元素值为TRUE时返回yes向量中相应下标的元素，否则返回no向量中的元素，yes和no都会循环补齐
v2 <- c(3,6,1,8,9)
ifelse(v2%%2==0, v2, 1+v2)

# bool值自动转换成数字
TRUE == 1 
FALSE == 0

#
findud <- function(v){
  vud <- v[-1] - v[-length(v)]
  return(ifelse(vud > 0, 1, -1))
}

udcorr <- function(x, y){
  ud <- lapply(list(x, y), findud)
  return(mean(ud[[1]] == ud[[2]]))
}

x <- c(12,15,65,23,34,5,15)
y <- c(4,6,4,2,4,6,9)
udcorr(x, y)

# diff()向量滞后求差
diff(x)
# sign() 根据向量元素的正负性，返回1和-1的向量
sign(diff(x))
# 简化udcorr函数
udcorrs <- function(x, y){
  return(mean(sign(diff(x)) == sign(diff(y))))
}

udcorrs(x, y)
# 
abalone <- c("M", "I", "F", "F", "M", "F", "F", "M", "I", "I", "F", "I", "I", "F", "M")
# mapping: M - 1, F - 2, I - 3
ifelse(abalone == "M", 1, ifelse(abalone == "F", 2, 3)) # 先执行外部ifelse(), 在必要是执行内部ifelse()，惰性求值(lazy evaluation)

# args()获取方法参数的名字
args(ifelse)

###

# 向量是否相等
# 1. == 和 all()
x1 <- c(3,2,1,4)
x2 <- 1:4
x3 <- 1:4
x4 <- c(1,2,3,4)
all(x1 == x2)
all(x2 == x3)
isEuqal <- function(v1, v2){
  return(all(v1 == v2))
}

isEuqal(x1, x2)
isEuqal(x3, x2)
# 2. identical(x, y)
# identical() 要求向量的元素类型相同
identical(x1, x2)
identical(x2, x3)
identical(x2, x4)
# typeof() 获取向量的元素类型
typeof(1:2) == "integer"
typeof(c(1,2)) == "double"
# 使用 : 时，如果开始的数是整数，则产生的向量元素都是整数，否则都是浮点数
# c() 生成的数字向量元素类型都是浮点数

# 向量元素命名
# names() 为向量元素命名或获取向量元素名称
v1 <- c(1,2,3)
names(v1) # NULL, 没有为向量元素命名时names()返回NULL
names(v1) = c("a", "b", "c") # 用一个代表名称的向量为向量中的每一个元素命名，可以是字符串或者数字
names(v1) == c("a", "b", "c") # 返回元素命名组成的向量
v1["b"] # 使用向量元素名称获取元素
names(v1) = NULL # 赋值为NULL时，可以移除所有元素的名称
names(v1) = c(9, 8) # 当名称向量的个数少于目标向量的元素个数时，没有获得名称的元素的名称为缺省值

# c() 类型降级
# 当传入c() 的参数有不同数据类型是，这些数据会被转换成统一类型
c(1, FALSE) 
c(1, FALSE, "a") 
# bool < number < string
c(1, FALSE, "a", list(x=5, y=6)) # 列表具有更高的优先级
# c() 扁平化效果
c(1, 2, c(3,4,5)) # 拆解成一元向量，再组合成一个向量
