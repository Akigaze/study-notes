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
