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






