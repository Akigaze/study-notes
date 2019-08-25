# 数据框，类似于每个组件长度都相等的列表
# 但是列表的组件也可以是数据框，所以数据框更像是一种列mode可以不同的矩阵

# data.frame() 创建数据框
name <- c("xiao", "ming")
age <- c(10, 17)
data.frame(name, age) # 将多个向量按列组合，取向量的名称为列的名称
df1 <- data.frame(name, age, stringsAsFactors = FALSE)
str(df1)
# 访问数据框的元素
df1$name #$colName 类似列表，使用列名获取某一列的向量
df1[,2] #[nrow,ncol] 类似矩阵，使用索引获取的元素值的向量
df1[1,1]
df1[1,"name"] #列名也可以代替索引
df1[[1]] # [[index]] 类似列表获取组件的值，每一列相当于一个组件
df1[["name"]] # [["colName"]] 同样可以使用列名，列名相当于组件的标签
class(df1[1]) # [index] 或 ["colName"] 的形式获取的是指定列组成的子数据框
class(df1["age"]) 

scoresTable <- read.table("scores.txt", header = TRUE) # read.table() 可读取txt文件转换成数据框，并设置数据框列名
help("read.table")
scoresTable$Exam.1

scoresTable[1,] # 若只提取数据框的某些行，则结果依然是数据框
scoresTable[,1] # 只提取一列时，结果会自动降维成普通向量
scoresTable[2:5,1]
scoresTable[,1:2] # 当提取多于1列时，结果将是数据框
scoresTable[1,1:2]
scoresTable[,1,drop=FALSE] # 同样可以设置drop=FALSE取消自动降维

scoresTable[scoresTable$Exam.1 >= 60,] # 提取Exam1成绩大于等于60的所有学生的所有成绩
scoresTable[scoresTable$Exam.1 >= 60,1,drop=FALSE]

# ---
scoresWithNA <- read.table("scores-with-NA.txt", header = TRUE) # 若要文件中有缺失值，要用NA代替
scoresWithNA
mean(scoresWithNA$Quiz, na.rm = TRUE)
# subset() 对数据框去子集，自动除去NA
scoresWithNA[scoresWithNA$Quiz >= 60,] # 只要某一个数据为NA，则返回的整行都会是NA
subset(scoresWithNA, Quiz > 60) # subset(data, condition) 根据条件按行过滤去子集，并且自动去除condition中的NA
subset(scoresWithNA, scoresWithNA$Exam.1 > 60)
# 使用complete.cases() 判断数据框的记录是否含有NA
complete.cases(scoresWithNA) # 不含NA返回TRUE，有则返回FALSE
scoresWithNA[complete.cases(scoresWithNA),] # 使用complete.cases的结果取数据框中的行，就能做到去除有缺省值的记录了

#cbind() rbind() 同样可以用于数据框的添加行或列
# cbind() 只能用于数据框之间的合并，要求数据框列数相同
size <- c("big", "small")
price <- c(10.5, 17.3)
tag <- c("A", "B")
df2 <- data.frame(size, price, stringsAsFactors = FALSE)
df3 <- data.frame(tag, stringsAsFactors = FALSE)
df2
df3
cbind(df2, df3)
# rbind() 可以将列表或数据框合并到数据框中，但要求列表的组件数与数据框列数相同，且标签名与列名相同或使用默认标签吗
wrongList <- list(tag="C", price=23)
rightList1 <- list(size="C", price=23)
rightList2 <- list("Food", 34.6)
rightList3 <- list(size=c("X", "youger"), price=c(23.1, 90))

rbind(df2, rightList1)
rbind(df2, rightList2)
rbind(df2, rightList3)

scoresTable$Exam1vs2 <- scoresTable$Exam.1 - scoresTable$Exam.2 # 也可以使用数据框的列表属性 $ 添加新列
scoresTable$gender <- c(0, 1) # 添加列也支持循环补齐
head(scoresTable) # head() 查看数据框的前6行

# 由于数据框也是一种矩阵，所以apply函数同样使用，1-行，2-列
sncol <- ncol(scoresTable)
sncol
scoresTable$gender <- NULL
scoresTable$average <- apply(scoresTable[,1:3], 1, mean)
scoresTable

help("grep")
paste(1,3,"a", TRUE, sep = ",") # paste() 将元素用指定符号连接成一个字符串
# merge() 合并数据框，类似于数据表的join连接，两个数据框可以根据同名的列或指定的列进行合并
d1 <- data.frame(kids=c("Jack", "Mike", "Rose"), age=c(9, 7, 12))
d1
d2 <- data.frame(kids=c("Mike", "King", "Jack", "Lala"), city=c("MA", "LD", "LD", "NY"))
d2
d3 <- data.frame(child=c("Mike", "King", "Jack", "Lala"), city=c("MA", "LD", "LD", "NY"))
merge(d1, d2) # 根据同名的列kids进行合并
merge(d1, d3) # 没有同名的列时，两个数据框中的记录两两组合
merge(d1, d3, by.x = "kids", by.y = "child") # 使用指定的列进行合并

# lapply() sapply() 同样能应用于数据框
# lapply() 都会对数据框的每一列执行函数，将列名和结果作为列表的一个组件进行返回
scoresTable <- read.table("scores.txt", header = TRUE)
lapply(scoresTable, mean)
lapply(scoresTable, sort)
# sapply() 则会将结果降维成普通向量或矩阵
sapply(scoresTable, mean)
sapply(scoresTable, sort)
names(scoresTable)

# 方言学习
install.packages("canman8")

# 小写字母和大写字母的向量集合
letters
LETTERS

cans <- read.csv("can.csv", header = TRUE)
mans <- read.csv("man.csv", header = TRUE)
head(mans)
#   Ch.char   Man
#1      Äã    ni3
mans[2]
class(names(mans)[2])
mode(names(mans)[2])


seperateSoundTone <- function(p){
  pronun <- as.character(p)
  nchr <- nchar(pronun) # nchar() 获取字符串中字符的个数
  vowels <- c("a", "o", "i", "e", "u")
  conIndex <- 0
  for (i in 1:nchr) {
    chr <- substr(pronun, i, i)
    if(chr %in% vowels){
      break
    }
    conIndex <- i
  }
  cons <- if(conIndex > 0) substr(pronun, 1, conIndex) else NA
  tone <- substr(pronun, nchr, nchr)
  numtone <- !tone %in% letters # A %in% B 判断向量A的元素是否在B向量中，也是向量化操作
  if(!numtone) tone <- NA
  therest <- substr(pronun, conIndex+1, nchr-numtone)
  return(c(cons, therest, tone))
}

mergeCanMan <- function(can, man){
  canMan <- merge(can, man)
  for(fy in list(can, man)){
    soundToneMatrix <- sapply(fy[,2], seperateSoundTone)
    fyWithTone <- data.frame(fy[[1]], t(soundToneMatrix), row.names = NULL, stringsAsFactors = FALSE)
    fyNames <- names(fy)
    consname <- paste(fyName[2], " cons", sep = "")
    soundname <- paste(fyName[2], " sound", sep = "")
    tonename <- paste(fyName[2], " tone", sep = "")
    names(fyWithTone) <- c(fyNames[1], consname, soundname, tonename)  
    
    canMan <- merge(canMan, fyWithTone)
  }
  return(canMan)
}

soundMap <- function(data, srcCol, targetCol, srcEval){
  baseIndexes <- which(data[[srcCol]] == srcEval)
  baseData <- data[baseIndexes,]
  sp <- split(baseData, baseData[[targetCol]])
  result <- list(count=sapply(sp, nrow), images=sp)
  return(result)
}


canMAns <- mergeCanMan(cans, mans)
canMAns
canMAns[["Man cons"]]
kMap <- soundMap(canMAns, "Man cons", "Can cons", "k")
kMap

nchar(c("2","123"))

### from R in Action ###

myDataFrame <- data.frame(age=numeric(0), gender=character(0), weight=numeric(0))
myDataFrame <- edit(myDataFrame) # 传入的参数是数据框，edit() 会调用相应的泛型函数，使用表格形式输入值
methods(edit)

myDataFrameStr <- "
age gender  weight
1   F       2
2   M       4
"
myDataFrame <- read.table(text=myDataFrameStr, header = TRUE) # read.table() 可以通过text参数从字符串中提取数据
myDataFrame
# read.table() 只能从存文本文件中提取数据
str(myDataFrame)