# 向量是否相等
# 1. == 和 all()
x1 <- c(3,2,1,4)
x2 <- 1:4
x3 <- 1:4
x4 <- c(1,2,3,4)
all(x1 == x2)
all(x2 == x3)
isEuqal <- function(v1, v2){
  return(all(v1 == v2))
}

isEuqal(x1, x2)
isEuqal(x3, x2)
# 2. identical(x, y)
# identical() 要求向量的元素类型相同
identical(x1, x2)
identical(x2, x3)
identical(x2, x4)
# typeof() 获取向量的元素类型
typeof(1:2) == "integer"
typeof(c(1,2)) == "double"
# 使用 : 时，如果开始的数是整数，则产生的向量元素都是整数，否则都是浮点数
# c() 生成的数字向量元素类型都是浮点数

# 向量元素命名
# names() 为向量元素命名或获取向量元素名称
v1 <- c(1,2,3)
names(v1) # NULL, 没有为向量元素命名时names()返回NULL
names(v1) = c("a", "b", "c") # 用一个代表名称的向量为向量中的每一个元素命名，可以是字符串或者数字
names(v1) == c("a", "b", "c") # 返回元素命名组成的向量
v1["b"] # 使用向量元素名称获取元素
names(v1) = NULL # 赋值为NULL时，可以移除所有元素的名称
names(v1) = c(9, 8) # 当名称向量的个数少于目标向量的元素个数时，没有获得名称的元素的名称为缺省值

# c() 类型降级
# 当传入c() 的参数有不同数据类型是，这些数据会被转换成统一类型
c(1, FALSE) 
c(1, FALSE, "a") 
# bool < number < string
c(1, FALSE, "a", list(x=5, y=6)) # 列表具有更高的优先级
# c() 扁平化效果
c(1, 2, c(3,4,5)) # 拆解成一元向量，再组合成一个向量
