# sum() 向量元素求和，prod() 向量元素求乘积
prod(1:4)
# 计算n个独立事件恰好只有一个发生的概率
exactlyOne <- function(ps){
  notPs <- 1 - ps
  total <- 0.0
  for (i in 1:length(ps)) {
    onlyI <- ps[i] * prod(notPs[-i])
    total <- total + onlyI
  }
  return(total)
}

exactlyOne(c(0.2, 0.5, 0.5))

exp(2) # 自然数e为底的指数
log(2) # 自然数e为底的对数
log10(100) # 10为底的对数
round(6.50) # round() 四舍五入取整，但要求小数点后部分要大于5才进
round(6.6)
floor(9.9) # floor() 向下取整
ceiling(9.1) # ceiling() 向上取整

cumsum(c(4,2,1)) # cumsum() 累计求和
cumprod(c(4,2,1)) # cumsum() 累计求积

m1 <- matrix(c(3,6,1,7,6,4,8,2), nrow = 4)
m1
min(m1) # 求向量所有元素中数值最小的元素
min(m1[1,], m1[3,], c(9,2)) # 会将所有参数合并成一个向量，在取最小元素
max(m1) # 取最大值

pmin(m1[,1], m1[,2]) # 比较每个向量参数相同所以处数值的大小，取小的组成一个新向量
pmax(m1[1,], m1[4,], m1[2,], m1[3,])

nlm(function(x) return(sin(x)+1), 8) # nlm() 计算函数的最小值，第二个参数只是指定一个演算次数
optim() # optim() 计算函数的最大值

# R也有许多求微积分的函数和包
D(expression(exp(x^2)), 'x') # 对函数求导
integrate(function(x) x^2, 0, 1) # 求积分
# 还有 odesolve 包可以计算微分方程

# R的统计分布函数
# R中的统计分布函数有一套统一的前缀
# d: 概率密度函数或概率质量函数，第一个参数是分位数概率的向量，第二个参数是自由度df
# p: 累计分布函数，同上
# q: 分位数计算，同上
# r: 随机数生成函数，第一个参数为随机数个数，第二个是自由度df

# 下面是三种常见类型的分布函数
# norm: 正态分布
# chisq: 卡方分布
# binom: 二项分布

# 由这几类函数和不同的前缀就能组成不同功能的函数
hist(rchisq(100, df=2)) # 生成100个自由度为2的卡方随机数
qchisq(c(0.5, 0.95), df=2) #自由度为2的卡方分布的50%分位数和95%分位数

sort(c(2,4,1,5,3)) # sort() 按从小到大排序
order(c(2,4,1,5,3)) # order() 对向量从小到大排序，但返回的是元素在原向量中的下标，也可以对字符串进行排序

df <- data.frame(list(name=c('Jack', 'Bale', 'Zoo'), age=c(10,8, 12)))
df[order(df$age),] # 对数据框根据某字段排序

class(sort(df$name)) # sort()对字符串向量进行排序会返回因子
df[order(df$name),] # order()按字母顺序排序

rank(c(5, 12, 5, 13)) # rank()返回元素在向量中的排名，元素大小一样时，名次取平均数

###

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

###

x <- rbinom(100, 5, 0.5) 
# 生成100个二项分布的随机数，每次实验5次，成功的概率为0.5，即每次实验返回1的概率
# 生成的每一个数字，代表每五次实验中成功的次数
mean(x >= 4) # 5次实验至少成功4次的概率
help("rbinom")
rnorm() # 生成正态分布随机数
rexp() # 生成指数分布随机数
runif() # 生成均匀分布随机数
rgamma() # 生成伽马分布随机数
rpois() # 生成泊松分布随机数

eOfMaxOf2Norm <- function(n){
  sum <- 0
  for (i in 1:n) {
    xy <- rnorm(2) # 生成2个标准正态分布随机数
    sum <- sum + max(xy)
  }
  return(sum/n)
}

eOfMaxOf2Norm(10000000)  
pmax(c(1,2,3), c(2,2,2)) # 逐个比较两个向量中相同下标的元素，返回大的那个

sample(1:5, 2) # 从集合中随机取出指定数量的元素
chooseCom <- function(data, comsize){
  committee <- sample(data$left, comsize)
  data$chosen <- length(intersect(1:2, committee))
  if(data$chosen == 2){
    data$success <- data$success + 1
  }
  data$left <- setdiff(data$left, committee)
  return(data)
}

sim <- function(n){
  data <- list()
  data$success <- 0
  for (i in 1:n) {
    data$left <- 1:20
    data$chosen <- 0
    data <- chooseCom(data, 5)
    if(data$chosen > 0) next
    data <- chooseCom(data, 4)
    if(data$chosen > 0) next
    data <- chooseCom(data, 3)
  }
  return(data$success)
}

sim(10)
sim(20)
apply(rep(100, 100),2, FUN = sim)

