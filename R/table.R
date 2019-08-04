# table() 生成列表或数据框的列联表，即统计不同因子水平的组合数，它会将列表的每一个组件当成一个因子，或将数据框的每一列当成因子
vote <- read.table("vote.txt", header = TRUE)
class(vote)
voteTable <- table(vote) #通常序号靠后的列或组件会被放置在更高的维度
class(voteTable) == "table"
str(voteTable)
# table() 也可以应用于普通的向量，此时就是统计向量水平的个数
vTable <- table(c(1,4,2,5,3,2,1))
class(vTable) == "table"
# 表类似于矩阵或数组，所以矩阵和数组的操作方式对表同样适用
voteTable[2,2]
voteTable[,2]
voteTable[,2, drop=FALSE]
voteTable[1,]
voteTable * 2
apply(voteTable, 1, sum)
# 为表添加边际统计数据，即计算某一个因子的作用域其他因子的总和
addmargins(voteTable) # addmargins() 可以为表的行和列都添加边际统计值，名称均为Sum
dim(voteTable)
ncol(voteTable)
dimnames(voteTable) # table()在生成表时，会根据因子自动为行和列(不同维度)的记录生成名称

###

vote <- read.table("vote.txt", header = TRUE)
voteTable <- table(vote)
voteTable

unclass(voteTable)
# subtable() 提取子表


class(unclass(voteTable))
voteTable[1,2]
"["(voteTable, 1,2)
subtable <- function(tb, subnames){
  tarray <- unclass(tb) # table取出类属性之后，降维成矩阵
  dcargs <- list(tarray)
  ndims <- length(subnames)
  for (i in 1:ndims) {
    dcargs[[i+1]] <- subnames[[i]]
  }
  subarray <- do.call("[", dcargs) 
  # "[" 是下标操作([])的函数，第一个参数是数据源，之后的每个参数为每一个维度取值的下标向量
  # do.call(func, argsList), 将列表按组件拆解成相应数量的参数，作为func的参数
  dims <- lapply(subnames, length)
  subtb <- array(subarray, dims, dimnames = subnames)
  # 将矩阵转成table对象，需要向转成数组，设置维度，再添加class信息
  class(subtb) <- "table"
  return(subtb)
}

subtable(voteTable, list(for_X = c("No", "Yes"), for_X_last_time=c("No", "Yes")))

# 提取频数最大的元素
voteTable
as.data.frame(voteTable) 
# as.data.frame() 将table转成数据框，同时会增加一列对不同记录的统计数Freq
# 将table的维度最为列，对table中不同维度的水平进行自由组合，并增加Freq列记录每一种组合对于table的单元格中的值
tabledom <- function(tb, ntop){
  tbf <- as.data.frame(tb)
  freqorder <- order(tbf$Freq, decreasing = TRUE)
  ntopIndex <- freqorder[1:ntop]
  return(tbf[ntopIndex,])
}
tabledom(voteTable, 4)

# aggregate() 对数据框进行分组，对分组中的每个变量执行指定方法
abalone <- read.table("abalone.txt", ",", header = TRUE)
f3 <- abalone[,1:3]
names(f3) <- c("Gender", "Length", "Width")
head(f3)
f <- f3[,-1]
gl <- list(c("A", "B"))
f
aggregate(f, by=gl, median) # 分组依据的因子向量必须放在列表中
aggregate(f3[,-1], list(f3$Gender), median)

# cut() 获取数据所在区间
data <- c(0.34, 0.93, 0.23, 0.67, 0.10, 0.46, 0.93, 0.38, 0.84, 0.24)
interval <- seq(0, 1, by=0.1)
interval <- c(0.3, 0.9, 0.5)
interval
cut(data, interval) 
# 根据第二个参数，将向量的元素按大小排列，相邻元素形成一个区间，将这些区间最为因子的水平，根据data参数中的元素落在哪一个区间为因子添加元素
# 将label参数设置为false时，则只记录data每个元素所在区间的编号，返回一个编号组成的向量
cut(data, interval, labels = FALSE)
