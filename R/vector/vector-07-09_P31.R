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

