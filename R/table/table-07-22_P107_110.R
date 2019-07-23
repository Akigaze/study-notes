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
