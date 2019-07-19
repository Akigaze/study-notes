# matrix() 创建矩阵
m1 <- matrix(c(1,2,3,4,5,6), nrow = 3, ncol = 2)
m2 <- matrix(1:10, nrow = 2)
m1
m1[2,1] #使用 行序号,列序号 的形式获取指定位置的元素
m2[,2] # 省略行号，表示获取所有行，省略列号同理
m2[1,]
m2[,2:3] # 使用向量指定多列或多行
m2[1,] <- 10 # 给指定位置赋值
m3 <- matrix(nrow = 2, ncol = 2) # 创建矩阵时不初始化，只是分配空间大小，此时所有值为NA
m3[1,1] <- 0
m3[1,2] <- 1
m3[2,1] <- 0
m3[2,2] <- 1
m3
matrix(1:6) # 默认按列排序，因此默认情况下只有一列
# 矩阵是对向量进行按列存储，byrow属性可以设置排列方式
matrix(1:8, nrow = 4, byrow = TRUE) # byrow = TRUE 别是按行排列，但实际上还是按列排，只是改变了对向量的取值顺序而已
# 矩阵运算
m4 <- matrix(1:4, nrow = 2)
m4 %*% m4 # 矩阵相乘
m4 * 2 # 矩阵数乘
m4 + 10 # 矩阵与数字运算
m4 + m4 # 矩阵相加
# 矩阵时具有行维度和列维度的向量，但是普通向量并没有行和列的概念
# 向量索引的用法对矩阵同样适用
m2[c(TRUE, TRUE), 1]
# 使用矩阵为子矩阵赋值
subm <- matrix(rep(0:1, 2), nrow = 2)
subm
parm <- matrix(nrow = 3, ncol = 3)
parm
parm[1:2, c(1,3)] <- subm
parm
parm + subm

# & 向量的与操作，支持向量化
c(TRUE, FALSE) & c(TRUE, TRUE)
# && 不支持向量化操作
c(TRUE, FALSE) && c(TRUE, TRUE)
# 矩阵降维，由于矩阵时一种特殊的向量，所以在进行运算时可能出现降维：which()
m5 <- matrix(c(42,14,34,56,54,23), nrow = 3)
which(m5 > 30)






























