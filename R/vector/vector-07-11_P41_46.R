# if-else的向量化函数
v1 <- 1:12
v1%%2==0
ifelse(v1%%2==0, 0, 1) == rep(c(1, 0), 6) #c(1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0)
ifelse(v1%%2==0, c("A", "B"), "N")
# condition:   FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE FALSE  TRUE
# if TRUE:     "A"    "B"  "A"    "B"  "A"    "B"  "A"    "B"  "A"    "B"  "A"    "B"  
# if FALSE:    "N"    "N"  "N"    "N"  "N"    "N"  "N"    "N"  "N"    "N"  "N"    "N"  
# result:      "N"    "B"  "N"    "B"  "N"    "B"  "N"    "B"  "N"    "B"  "N"    "B"
# ifelse(bools, yes, no) 
# bool向量的元素值为TRUE时返回yes向量中相应下标的元素，否则返回no向量中的元素，yes和no都会循环补齐
v2 <- c(3,6,1,8,9)
ifelse(v2%%2==0, v2, 1+v2)

# bool值自动转换成数字
TRUE == 1 
FALSE == 0

#
findud <- function(v){
  vud <- v[-1] - v[-length(v)]
  return(ifelse(vud > 0, 1, -1))
}

udcorr <- function(x, y){
  ud <- lapply(list(x, y), findud)
  return(mean(ud[[1]] == ud[[2]]))
}

x <- c(12,15,65,23,34,5,15)
y <- c(4,6,4,2,4,6,9)
udcorr(x, y)

# diff()向量滞后求差
diff(x)
# sign() 根据向量元素的正负性，返回1和-1的向量
sign(diff(x))
# 简化udcorr函数
udcorrs <- function(x, y){
  return(mean(sign(diff(x)) == sign(diff(y))))
}

udcorrs(x, y)
# 
abalone <- c("M", "I", "F", "F", "M", "F", "F", "M", "I", "I", "F", "I", "I", "F", "M")
# mapping: M - 1, F - 2, I - 3
ifelse(abalone == "M", 1, ifelse(abalone == "F", 2, 3)) # 先执行外部ifelse(), 在必要是执行内部ifelse()，惰性求值(lazy evaluation)

# args()获取方法参数的名字
args(ifelse)
