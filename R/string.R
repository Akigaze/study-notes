# grep() 查找匹配的元素
grep("like", c("dislike", "Like me", "hate", "lide")) # 在第二个向量参数中找到包含第一个参数的字符串，返回找到的下标，否则返回空向量

# nchar() 获取字符串长度
nchar("123 456,abc") == 11
nchar(NA) # 当参数不是字符串或数字时，应该是返回参数本身
nchar(vector())
nchar(000) # 当参数是数字时，会将参数转成字符串
nchar(123)
nchar(1.23)
nchar(c("123", "abc")) # 支持向量化操作
nchar(c(123, 0.3))

# paste() 连接字符串
paste("I", "don't", "know") == "I don't know" # 默认使用空格连接
paste("I", "don't", "know", sep = ",") == "I,don't,know" # sep参数设置连接符
paste("I", "don't", "know", 1, sep = "") == "Idon'tknow1" # 数字会被转成字符串
paste(c("I", "don't", "know"), "!") # 支持向量化操作
paste(c("I", "don't", "know"), c("!", ".")) # 以元素最多的一个向量参数为基准，会进行循环补齐

# sprintf() 格式化字符串
i <- 2
sprintf("the square of %d is %d", i, i^2) # 用法与java的String.format相似，使用%作为占位符
sprintf(c("the square of %d is %d", "%d is %d"), i, i^2) # 第一个参数的字符串模板支持向量化操作
sprintf(c("the square of %d is %d", "%d is %d"), c(i,1), c(i^2,0)) # 所有参数都支持向量化操作，按元素位置取值，会循环补齐

# substr(x, start, stop) 截取子串
substr("123456", 3, 5) # 包头包尾
substr(c("123456", "abcdefg"), 3, 5)
substr(c("123456", "abcdefg"), c(1,3), 5) # 同样支持向量化操作，会循环补齐
substr("123", 3, 5) # 当终点位置越界时，取起点之后的所有字符
substr("12", 3, 5) # 当起点都越界时，返回空字符串

# strsplit(x, splitor) # 分割字符串
strsplit("I think nothing is OK", split = " ") # splite 参数指定分割的字符
strsplit("I think nothing is OK") # splite参数是必须的
strsplit("I, think, nothing, is, OK", split = ", ") # splite参数可以是多个字符
strsplit(c("I think nothing is OK", "like everything"), split = " ") # 被分割的参数也可以是一个向量
# 返回一个list，每个被分割的字符串的分割结果会作为相应的组件
strsplit(c("I think nothing is OK", "like, everything"), split = c(" ", ", ")) # splite参数也可以是向量，作用于不同的字符串

# regexpr(pattern, x) 类似于indexOf
regexpr("uat", "Equator equator") # 只返回第一个匹配的位置
regexpr("uat", "xyxyxyxyxy") # 没有匹配的就返回-1
regexpr(c("uat", "or"), "Equator oruat") # pattern只能有一个元素
regexpr("uat", c("Equator", "oruat")) # 被查找的字符串可以是一个向量，会返回在每一个字符串中找到的位置

# gregexpr(pattern, x) 类似于all indexOf
gregexpr("uat", "Equator oruat") # 只返回所有匹配的位置，结果是一个list
# 其他很多特性与regexpr相似
gregexpr("uat", "xyxyxyxyxy") 
gregexpr(c("uat", "or"), "Equator oruat")
gregexpr("uat", c("Equatoruate", "oruat")) # 被查找的字符串可以是一个向量，每个字符串的结果会作为返回的list的一个组件

# grep(), grepl(), regexpr(), gregexpr(), sub(), gsub(), strsplite()等函数用于匹配的字符串模式都支持正则表达式
# R在正则表达式中进行特殊字符转义时，依然使用反斜杠(\)，但是因为反斜杠本身需要转义，所以要用两个反斜杠(\\)
# 对于strsplite()，可以设置fixed参数为TRUE，取消split参数使用正则表达式

# 判断文件的扩展名
fileSuffix1 <- function(name, suffix){
  strs <- strsplit(name, split = ".", fixed = TRUE)
  extIndex <- length(strs[[1]])
  return(strs[[1]][extIndex] == suffix)
}

fileSuffix1("index.html", "html")
fileSuffix1("index.jsp", "html")

fileSuffix2 <- function(name, suffix){
  namelen <- nchar(name)
  suffixlen <- nchar(suffix)
  return(substr(name, namelen - suffixlen + 1, namelen) == suffix)
}

fileSuffix2("index.html", "html")
fileSuffix2("index.jsp", "html")


# 生成文件名
saveFile <- function(times){
  for (i in 1:times) {
    fname <- sprintf("q%d.pdf", i) # %f 为浮点数，%g 为去除多余0的浮点数
    pdf(fname) # 在工作目录下创建PDF文件，并将所有输出都转移到文件中
    hist(rnorm(100, mean = 0, sd = i))
    dev.off() # 关闭输出设置，保存文件
  }
}
saveFile(2)
