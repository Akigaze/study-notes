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
