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

