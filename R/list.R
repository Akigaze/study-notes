l1 <- list(name="quinn", age=18)
# R语言的列表类似于JSON对象或python的字典，存在key和value，支持相似的操作
# 在R的列表中，key称为标签tag，tag及其值得组合称为组件
l1
l1$name # 使用 $ 访问key的值
l1['name'] # ['key'] 获取tag和value的一个组合
l1[['name']] # [['key']] 获取tag值
# 列表的每个tag对应的value也是一个向量
# 列表的tag是以类似数组的形式存在的['key']
# 当不指定tag时，默认使用数字 
l2 <- list("quinn", 18)
l2[1]
l2[[1]]
  
# 列表实际上也是一种向量，所以可以指定vector函数的mode参数，用于构造列表
lv <- vector(mode = "list")
# 可以使用$tag 和 [["tag"]] 和 ['tag'] 三种形式对列表的标签赋值或创建标签值对
lv$name <- "quinn"
lv[["age"]] <- 18
lv["tall"] <- 180
lv[['tall']]

# 访问列表中组件的值的方式
# 1. $tag   2. [["tag"]]    3. [[index]]  这些方式返回的值都是向量
l3 <- list(name=c("A", "B"), size=c(2,5))
# 列表中的组件在定义或赋值时会有一个默认的index
l3$name
l3[['size']] # [[]] 一次只能取出一个组件值，不支持使用多元向量取值
l3[[2]]

# 使用 ['tag'] 或 [index]的形式返回的是原列表的一个子列表，这两种形式可以同时获取多个组件
class(l3[2]) == "list"
class(l3['name']) == "list"

# $tag，[["tag"]]，[[index]]，['tag']，[index] 五种形式都能用于列表组件的添加或修改
# 删除列表中的组件只需将组建值赋值为NULL，同时后面使用默认tag的组件的index都会自动做相应变化
l3["price"] <- list(c(1.2,3.2))
l3[4:5] <- c(0,1,2)
# 当使用[]为列表添加组件时，使用普通向量赋值时，默认支取一个元素作为组件的值
l3$price <- NULL
l3

# length()获取列表的组件个数
length(l3)

findWords <- function(f){
  words <- scan(f, "") #scan() 读取工作目录下的文件
  result <- list()
  for (i in 1:length(words)) {
    word <- words[i]
    result[[word]] <- c(result[[word]], i)
  }
  return(result)
}

findWords("words.txt")

###

l1 <- list(name="quinn", age=18)
names(l1) # names() 获取列表标签的向量
l1[3:4] <- c(1,2)
names(l1) # names() 标签名为字符串，使用默认数字标签时，返回空字符串

vl1 <- unlist(l1) # unlist()获取列表值得集合，会自动进行类型转换，且使用标签名为元素命名
class(vl1)
unname(vl1) # unname() 去除向量的元素名称

l2 <- list(size=c(10,20), number=c(8,6))
l2
lapply(l2, mean) # lapply() apply函数的list版本，对list中的每个组件执行方法，返回时一个相同结构的list
sapply(l2, mean) # sapply() 简化lapply的输出，可以将结果转化成矩阵或向量，依然保留原有list的标签

###

wordCount <- function(filePath){
  words <- scan(filePath, "")
  result <- list()
  for (i in 1:length(words)) {
    w <- words[i]
    result[[w]] <- c(result[[w]], i)
  }
  return(result)
}

sortByAlpha <- function(words){
  nms <- names(words)
  return(words[sort(nms)]) # sort() 对向量进行排序，返回排序后的结果
}

sortByCount <- function(words){
  frequence <- sapply(words, length)
  s <- order(frequence) # order() 与sort一样，有排序功能，但返回的是结果的每个元素在原向量中的下标
  print(s)
  return(words[s])
}

words <- wordCount("words.txt")
words
sortByAlpha(words)


freqwd <- sortByCount(words)
wordLen <- length(freqwd)
freqs9 <- sapply(freqwd[round(0.5*wordLen):wordLen], length) # round(0.5*wordLen):wordLen 表示数量在前50%的组件
barplot(freqs9) # barplot() 对向量绘制柱状图

# 列表中的组件也可以是列表，即列表是支持递归的(recursive)
# c() 的recursive参数可以设置的使用列表生成向量时，是否压平列表将其转化成普通向量
l1 <- list(a=2, b="x")
l2 <- list(a=0, b="y")
l3 <- list(a=c(6,8), b=c("m", "n"))
lg <- list(A=l1, B=l2)
cl <- c(lg) # 当c() 的参数有列表时，结果为列表形式
cv <- c(lg, recursive=TRUE) # recursive=TRUE 会压平列表生成普通矩阵
cl2 <- c(list(A=l1, B=l3))
cv2 <- c(list(A=l1, B=l3), recursive=TRUE)  # 列表中有组件是多元向量时，每个元素都会变成结果的一个元素
cv2
