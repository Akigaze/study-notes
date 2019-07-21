# 因子(factor) 可以看做是一个具有附加信息的向量，其中一个信息就是“水平(Level)”，记录了因子向量中所有不同的值
v1 <- c(3,56,8,56)
fv1 <- factor(v1) # factor() 将向量转换成因子对象，这个因子对象可以像普通向量一样使用
fv1 # 输出因子会看到两部分值：1. 原本的向量；2. 向量中包含的水平(Level)，即去除重复元素后的所有元素
# [1] 3  56 8  56
# Levels: 3 8 56
str(fv1) # 在因子中，并不会真实保存原本的向量，只保存了水平，已经向量中每个元素对应的水平的下标
# Factor w/ 3 levels "3","8","56": 1 3 2 3
unclass(fv1)
# [1] 1 3 2 3
# attr(,"levels")
# [1] "3"  "8"  "56"

length(fv1) == 4 # length() 因子的长度是指原向量中元素的格式

v2 <- c(4,67,23,45)
fv2 <- factor(v2, levels = c(4,23,45,67,88)) # 可以在创建因子对象时，提前设置好水平
fvw <- factor(v2, levels = c(4,23,45,88)) # 当原向量中存在设置的水平以外的元素时，该元素会被置为NA 
fvw #[1] 4    <NA> 23   45  
fv2
fv2[5] <- 88
fv2[6] <- 90 # 因子只能添加水平中有的值，强行添加值会变成NA
fv2[5] <- 4 # 因子的水平并不会因元素的变化而变化
fv2

# tapply()
ages <- c(25,32,21,43,32,22,38, 49)
affils <- c("R", "D", "D", "R", "U", "D", "U", "R")
tapply(ages, affils, mean) # 第二个参数的向量会被被转换成因子，利用水平的下标对第一个参数的向量进行分组
#  D  R  U 
# 25 39 35 

df <- data.frame(list(gender=c("M", "F" ,"M", "M", "F", "F"), age=c(34,23,32,21,33,29), income=c(6900, 7000, 5800, 8000, 5000, 9100)))
df$over25 <- ifelse(df$age >= 30, 1, 0)
tapply(df$income, list(df$over25, df$gender), mean) # 存在多种因子时，第二个参数可以使用包含多种因子的list，此时不同种类的因子自由组合
# split() 可以根据因子对向量或者数据框进行分组，返回分组后的list
split(df$income, list(df$gender, df$over25)) # 它的原理与tapply相同，只是少了调用函数的一步
# 获取不同因子的下标
abalone <- c("M", "F", "M", "M", "I", "F", "F", "M", "I", "M")
split(1:length(abalone),abalone)
# tapply的第一个参数只能是普通向量，而split还可以是数据框


abalone <- read.table("abalone.txt", ",", header = FALSE)[,1:3]
names(abalone) <- c("Gender", "Diameter", "Length")
head(abalone)
by(abalone, abalone$Gender, function(df) lm(df[,2]~df[,3])) # by() 与tapply相似，但是可以输入数据框
# by() 会将数据框按因子分组成不同的子数据框，在执行函数
