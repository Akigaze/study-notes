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

























