# 找对角矩阵中最小值及其位置

minOfDiagonalMatrxi <- function(m){
  minOfRow <- function(row){
    len <- length(row)
    rowx <- row[len]
    indexOfMin <- which.min(row[(1+rowx):(len-1)]) + rowx
    return(c(indexOfMin, row[indexOfMin]))
  }
  
  rown <- nrow(m)
  mWithRown <- cbind(m, 1:rown)
  
  minOfEachRow <- apply(m[-rown,], 1, minOfRow)
  colnOfTheMin <- which.min(minOfEachRow[2,])
  rownOfTheMin <- minOfEachRow[1,colnOfTheMin]
  return(c(m[rownOfTheMin, colnOfTheMin], rownOfTheMin, colnOfTheMin))
}

m1 <- matrix(c(2,5,3,6,1,6), nrow = 2)
which(m1 == 1) == 5
m2 <- matrix(c(2,5,3,6,1,6), nrow = 2, byrow = TRUE)
which(m2 == 1) == 4 # which()应用于矩阵时，按列顺序将矩阵转换成一个长向量，在对向量执行which()
r1 <- which(m2 == 1, arr.ind = TRUE) # 设置arr.ind参数为TRUE，可以将输出转化成包含行下标和列下标的一个矩阵
class(r1) # class() 查看变量的数据结构类型
attributes(r1)
# 矩阵对象有一个dim属性，该属性的值为一个二元向量，分别是矩阵的行数和列数
m2 <- matrix(c(5,3,2,5,2,6,3,2), nrow = 2)
attributes(m2)
m2$dim # 但是这个属性不能直接访问
dim(m2)
nrow(m2) == dim(m2)[1]
ncol(m2) == dim(m2)[2]
# nrow() 和 ncol() 是对向量dim属性的简单封装

# 对矩阵取子矩阵时，如果结果只有一行或者一列，R会自动将这个结果降维成一个向量
# 对于矩阵取子矩阵的操作，[] 在R中也是一个函数 "[]"(matrix, row, colo, args)
# 使用[]其子矩阵时，可以设置drop参数的值为FALSE，这样结果就自动降维了
m3 <- matrix(c(5,3,2,5,2,6,3,2), nrow = 2)
m3[1,]
m3[1,,drop=FALSE]

# 矩阵的行列命名
# colnames(), rownames() 获取或设置矩阵的行列名
m4 <- matrix(c(5,3,2,5,2,6,3,2), nrow = 2)
colnames(m4) # 没有设置时结果为NULL
rownames(m4)
colnames(m4) <- c("gd", "bj", "hn", "gx")
colnames(m4) 
m4
rownames(m4) <- c("area", "population")
rownames(m4)
m4

###

# ????????????
# ??????????????????????????????????????????,??????array()??????????????????????????????
test1 <- matrix(c(3,4,5,6,7,3), nrow = 3)
test2 <- matrix(c(7,5,6,8,3,3), nrow = 3)
ha <- array(data = c(test1, test2), dim = c(3,2,2))
# ??????????????????????????????,data???????????????????????????,dim?????????????????????,??????????????????"???,???,????????????"
dim(ha)
attributes(ha)

###

# matrix() 创建矩阵
m1 <- matrix(c(1,2,3,4,5,6), nrow = 3, ncol = 2)
m2 <- matrix(1:10, nrow = 2)
m1
m1[2,1] #使用 行序号,列序号 的形式获取指定位置的元素
m2[,2] # 省略行号，表示获取所有行，省略列号同理
m2[1,]
m2[,2:3] # 使用向量指定多列或多行
m2[1,] <- 10 # 给指定位置赋值
m3 <- matrix(nrow = 2, ncol = 2) # 创建矩阵时不初始化，只是分配空间大小，此时所有值为NA
m3[1,1] <- 0
m3[1,2] <- 1
m3[2,1] <- 0
m3[2,2] <- 1
m3
matrix(1:6) # 默认按列排序，因此默认情况下只有一列
# 矩阵是对向量进行按列存储，byrow属性可以设置排列方式
matrix(1:8, nrow = 4, byrow = TRUE) # byrow = TRUE 别是按行排列，但实际上还是按列排，只是改变了对向量的取值顺序而已
# 矩阵运算
m4 <- matrix(1:4, nrow = 2)
m4 %*% m4 # 矩阵相乘
m4 * 2 # 矩阵数乘
m4 + 10 # 矩阵与数字运算
m4 + m4 # 矩阵相加
# 矩阵时具有行维度和列维度的向量，但是普通向量并没有行和列的概念
# 向量索引的用法对矩阵同样适用
m2[c(TRUE, TRUE), 1]
# 使用矩阵为子矩阵赋值
subm <- matrix(rep(0:1, 2), nrow = 2)
subm
parm <- matrix(nrow = 3, ncol = 3)
parm
parm[1:2, c(1,3)] <- subm
parm
parm + subm

# & 向量的与操作，支持向量化
c(TRUE, FALSE) & c(TRUE, TRUE)
# && 不支持向量化操作
c(TRUE, FALSE) && c(TRUE, TRUE)
# 矩阵降维，由于矩阵时一种特殊的向量，所以在进行运算时可能出现降维：which()
m5 <- matrix(c(42,14,34,56,54,23), nrow = 3)
which(m5 > 30)

###

m1 <- matrix(9:1, nrow = 3)
row(m1) #获取元素在矩阵中的行号组成的矩阵
col(m1) #获取元素在矩阵中的列号组成的矩阵
row(m1[1:2,2:3])
row(m1[2,3]) # row()和col()的参数要是矩阵，即必须要行和列的属性，而普通向量是没有的

#生成对称的协方差矩阵
makeCov <- function(rho, n){
  m <- matrix(nrow = n, ncol = n)
  covMatrix <-ifelse(row(m) == col(m), 1, rho)
  return(covMatrix)
}
makeCov(0.3, 3)

# applay(): 相关函数 tapplay(), lapplay()
# applay() 函数能够对矩阵的某个维度的数据同一调用某个函数
m2 <- matrix(rep(c(1,0,0,1,0), 4), nrow = 4)
m2
# apply(data, dimen, func, args)
# data: 用于计算的矩阵
# dimen: 选取的维度，1 - 行，2 - 列，按指定维度将矩阵分解成多个向量
# func: 对应维度的每个向量都调用的函数，至少需要指定一个参数，其他的参数有args提供
# args: func函数除向量参数以外的参数，为可变参数的形式
# 输出: 当对一个向量调用函数后的输出为多元向量是，结果会以矩阵形式显示，一个结果为一列
apply(m2, 1, mean)
apply(m2, 2, mean)

f1 <- function(v){
  return(v/c(1, 2, 3, 4))
}
apply(m2, 2, f1)
t(apply(m2, 2, f1)) # t() 用于对矩阵进行转置

f2 <- function(v, from, to){
  m <- sum(v[from:to])/(to - from + 1)
  return(if(m > 0.5) 1 else 0)
}

apply(m2, 1, f2, 1, 4)

# 寻找异常值
findOdds <- function(data){
  findOddIndex <- function(v){
    mdn <- median(v) # median() 求中位数
    diffs <- abs(v - mdn)
    return(which.max(diffs)) # which.max() 是which的一个子函数，返回最大值的下标
  }
  return(apply(data, 1, findOddIndex))
}

v1 <- c(1:3, 10, 7:3, 12, 9, 12, c(1,4,6,2), 10:4, 0)
length(v1)
m3 <- matrix(v1, nrow = 4 )
m3
findOdds(m3)

# cbind() 和 rbind()：按列或行组合向量生成矩阵
m3 <- cbind(c(1,3), c(4,5)) # 多个向量作为参数
cbind(c(0, 0), m3) # 也支持使用矩阵作为参数，此时会将矩阵分解成向量
cbind(10, m3) # 支持循环补齐
cbind(1, c(2,2), c(4,5,6,7))
