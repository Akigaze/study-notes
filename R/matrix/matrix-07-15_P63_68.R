# 找对角矩阵中最小值及其位置

minOfDiagonalMatrxi <- function(m){
  minOfRow <- function(row){
    len <- length(row)
    rowx <- row[len]
    indexOfMin <- which.min(row[(1+rowx):(len-1)]) + rowx
    return(c(indexOfMin, row[indexOfMin]))
  }
  
  rown <- nrow(m)
  mWithRown <- cbind(m, 1:rown)
  
  minOfEachRow <- apply(m[-rown,], 1, minOfRow)
  colnOfTheMin <- which.min(minOfEachRow[2,])
  rownOfTheMin <- minOfEachRow[1,colnOfTheMin]
  return(c(m[rownOfTheMin, colnOfTheMin], rownOfTheMin, colnOfTheMin))
}

m1 <- matrix(c(2,5,3,6,1,6), nrow = 2)
which(m1 == 1) == 5
m2 <- matrix(c(2,5,3,6,1,6), nrow = 2, byrow = TRUE)
which(m2 == 1) == 4 # which()应用于矩阵时，按列顺序将矩阵转换成一个长向量，在对向量执行which()
r1 <- which(m2 == 1, arr.ind = TRUE) # 设置arr.ind参数为TRUE，可以将输出转化成包含行下标和列下标的一个矩阵
class(r1) # class() 查看变量的数据结构类型
attributes(r1)
# 矩阵对象有一个dim属性，该属性的值为一个二元向量，分别是矩阵的行数和列数
m2 <- matrix(c(5,3,2,5,2,6,3,2), nrow = 2)
attributes(m2)
m2$dim # 但是这个属性不能直接访问
dim(m2)
nrow(m2) == dim(m2)[1]
ncol(m2) == dim(m2)[2]
# nrow() 和 ncol() 是对向量dim属性的简单封装

# 对矩阵取子矩阵时，如果结果只有一行或者一列，R会自动将这个结果降维成一个向量
# 对于矩阵取子矩阵的操作，[] 在R中也是一个函数 "[]"(matrix, row, colo, args)
# 使用[]其子矩阵时，可以设置drop参数的值为FALSE，这样结果就自动降维了
m3 <- matrix(c(5,3,2,5,2,6,3,2), nrow = 2)
m3[1,]
m3[1,,drop=FALSE]

# 矩阵的行列命名
# colnames(), rownames() 获取或设置矩阵的行列名
m4 <- matrix(c(5,3,2,5,2,6,3,2), nrow = 2)
colnames(m4) # 没有设置时结果为NULL
rownames(m4)
colnames(m4) <- c("gd", "bj", "hn", "gx")
colnames(m4) 
m4
rownames(m4) <- c("area", "population")
rownames(m4)
m4
