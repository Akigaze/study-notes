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
