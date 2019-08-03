# 线性代数运算
# crossprod() 计算2个向量的点积(内积)
crossprod(1:3, c(2,3,4)) ==  1*2 + 2*3 + 3*4

# %*% 用于线性代数中矩阵的乘法
m1 <- matrix(c(1,2,3,4), nrow = 2)
m2 <- matrix(c(1,1,2,2), nrow = 2)
m1 %*% m2

# solve(m) 计算矩阵的逆矩阵
m4 <- c(3, 4)
m3 <- matrix(c(1,0,2,4), nrow = 2)
solve(m3)
# solve(m1, m2) 解线性方程组
solve(m3, m4)
# 解这个方程组
# 1*x + 2*y = 3
# 0*x + 4*y = 4

# 其他矩阵相关的函数
t(m3) # 转置
qr(m3) # QR分解
det(m3) # 矩阵对应行列式的值
eigen(m3) # 特征值和特征向量
diag(m3) # 提取对角的向量
diag(c(1,2,3)) # 生成对角矩阵
diag(3) # 生成指定大小的单位矩阵

# sweep(m, d, args, func) 对矩阵的某个维度进行批量操作
m5 <- matrix(1:9, nrow = 3)
sweep(m5, 1, c(3,2,1), "+") # 对矩阵的每一行加上参数对应的数值

# 向量交叉
# 两个n维向量的叉积依然是n维向量
# (a, b, c) X* (x, y, z) = (b*z-c*y, c*x-a*z, a*y-b*x)

xprod <- function(x, y){
  m <- rbind(rep(NA, 3), x, y)
  result <- vector(length=3)
  for (i in 1:3) {
    result[i] <- -(-1)^i * det(m[2:3,-i])
  }
  return(result)
}

xprod(c(1,2,3), c(1,1,1))
# 集合操作
x <- c(1,2,5)
y <- c(5,1,8,9)
union(x, y) # 并集
intersect(x, y) # 交集
setdiff(x, y) # 差集，x有y没有
setdiff(y, x) # 差集，y有x没有
setequal(x, y) # 集合内容是否相同
setequal(x, c(1,2,5))
2 %in% x # %in% 运算符，元素是否在集合中
c(1,2) %in% x # 支持向量化操作
choose(5, 2) # 从含有5个元素的集合中，取出含有两个元素的子集的个数

# 元素是否只属于2个集合的其中一个
belongOneSide <- function(x, y){
  belongX <- setdiff(x, y)
  belongY <- setdiff(y, x)
  return(union(belongX, belongY))
}

belongOneSide(c(1,3,6), c(3,5,2))

# combn() 输出所有可能的子集
combn(c(1,2,3), 2) # 包含两个元素的所有子集，以矩阵形式输出，每个子集为一列
combn(c(1,2,3), 2, sum) # 指定函数对每个子集执行操作，输出最终的结果













