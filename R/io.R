# scan() 读取键盘输入
# scan() 读取键盘的输入，生成向量，通常使用空格，制表符，换行等作为元素分隔的标志
vString <- scan(what = "") # what参数指明输入元素的mode，""表示输入的内容为字符串，默认的元素类型是浮点数
vNumber <- scan()
# scan读取文件
scan1 <- scan("io/scan1.txt") # 读取R工作目录下的文件内容，并将其转化为一个向量
scan2 <- scan("io/scan2.txt", what = "") # 若内容为字符串类型，依然要使用what参数指明元素的mode
scan3 <- scan("io/scan3.txt", what = "", sep = ",") # sep参数指明分隔元素的符号，只能是一个字符
sacn4 <- matrix(scan("io/scan4.txt"), nrow = 3, byrow = TRUE) # scan与matrix组合将文件内容读取到矩阵

# readline() 从键盘读取单行数据
line1 <- readline() # 将输入的一整行作为一个元素，返回一个一元向量，元素的类型都是字符串
name <- readline("please input your name: ") # 可将一个字符串作为输入前的提示内容

# cat()输出内容
# cat与print相比，输出的内容更为简洁，它的输出是一个纯字符串，不带有向量元素的序号
# 还可以拼接字符串进行输出
cat(1, 3, "a", "xxx", "\n") # 默认使用空格连接字符串
cat(c("I", "don't", "know"), "haha", "\n") # cat() 会将所有元素扁平化成一个向量，再拼接输出
# cat() 默认不会在结尾添加换行符，所以一般需要手动添加
cat(c("I", "don't", "know"), sep = ",") # sep参数指定元素连接的字符
cat(c("I", "don't", "know", "what", "is", "that"), sep = c(",", ".", "?")) # sep参数实际上是一个向量, 使用时会自动循环补齐

# read.table() 读取数据框
table1 <- read.table("io/table1.txt", header = TRUE) # 读取文件的内容，根据内容个样式和分隔符将其转换成数据框
table2 <- as.matrix(read.table("io/scan4.txt")) # as.matrix与read.table组合将文本内容读取到矩阵
table2

# readLines() 按行读取文件
lines <- readLines("io/readlines1.txt") # 每行的内容作为一个元素，返回一个向量
lines

###

# connection 是R中用于进行IO操作的一种机制
# R提供了file()，url()等函数针对不同IO设备创建连接
?connection # 查看连接相关的函数
# file() 读取文件
connect <- file("io/file1.txt", "r") # 创建一个文件读取的连接
readLines(con = connect, n=1) # readLines()从指定连接读取内容，n参数指定读取一行，之后连接的指针会自动移动到下一行的开头
close(connect) # close() 关闭连接
readAll <- function(path){
  connect <- file(path, "r")
  while (TRUE) {
    line <- readLines(con = connect, n = 1) # readLines() 读取的内容会放到一个向量中
    if(length(line) == 0){ # 当到达文件末尾没有内容时，会返回一个空的向量
      print("reach end of the file.")
      break
    } else {
      print(line)
    } 
  }
  close(connect)
}

readAll("io/file1.txt")
# seek() 设置连接指针的位置，实现倒带
connect <- file("io/file1.txt", "r") 
readLines(con = connect, n=3) 
seek(con = connect, where = 0) # where 参数指定指针的位置，0表示文件的最开始
# seek() 会返回执行时指针所在的位置
readLines(con = connect, n=1) 
close(connect)  

### 读取PUMS普查数据
extractPUMS <- function(path, modes){
  dtf <- data.frame()
  connect <- file(path, "r")
  repeat{
    hrec <- readLines(con = connect, n = 1)
    if(length(hrec) == 0) break
    serno <- intextract(hrec, c(2, 8))
    npr <- intextract(hrec, c(106, 107))
    if(npr > 0){
      for (i in 1:npr) {
        prec <- readLines(con = connect, n = 1)
        person <- makeRow(serno, prec, modes)
        dtf <- rbind(dtf, person) # 将一个list合并到数据框中
      }
    }
  }
  return(dtf)
}

intextract <- function(s, rng){
  fld <- substr(s, rng[1], rng[2]) # 截取字符串
  return(as.integer(fld)) # 字符串转数字, 自动去掉前面的0
}

makeRow <- function(srn, pr, m){
  line <- list()
  line[["serno"]] <- srn
  for(nm in names(m)){
    line[[nm]] <- intextract(pr, m[[nm]])
  }
  return(line)
}

# as.integer("000123")
pums <- extractPUMS("io/PUMS.txt", modes = list(Gender=c(23,23), Age=c(25,26)))
head(pums)

# read.table(), read.csv(), scan()等函数也可以通过URL访问网络上的资源

# 写文件
# write.table() 将数据框，矩阵写入文件中
name <- c("Jack", "Milk", "King")
age <- c(23, 13, 30)
df <- data.frame(name, age, stringsAsFactors = FALSE)
write.table(df, "io/writetable.txt") # 将数据框写入文件中，若文件不存在，会自动创建，如存在，直接替换内容
mx <- matrix(1:100, nrow = 10)
write.table(mx, "io/writematrix.txt", row.names = FALSE, col.names = FALSE) # 将矩阵写入文件时，只需指定不要列名和行名即可
# cat(file=) 指定文件将内容输出到文件中
cat("Only one", file = "io/catfile.txt") # 每次执行完文件自动保存
cat("Only you", file = "io/catfile.txt") # 默认也是替换整个文件内容
cat("Only you", "only one", 1,2,3,"\n", file = "io/catfile.txt") # 传入多项内容时，默认用空格分隔
cat("no problem","\n", file = "io/catfile.txt", append = TRUE) # append参数指定写入的模式是追加内容
# writeLines() 类似readLines，写文件
writeAll <- function(path, content){
  connect <- file(path, "w") # 指定文件的打开模式为写模式，文件不存在时会创建文件
  for (s in content) {
    writeLines(s, con = connect) # 此处内容的写入会根据连接的指针，对于一个连接的写操作，第一次写入时会清空文件中的内容
  }
  close(connect)
}

content <- c("I","J")
writeAll("io/writeLines.txt", content)
# 文件信息，目录信息
file.info("io/writeLines.txt") # 获取文件信息
file.exists("io/writeLines.txt") # 判断指定文件是否存在，支持向量化操作
file.exists(c("io/writeLines.txt", "io/123.txt")) 
getwd() # 获取当前工作目录
setwd("") # 修改当前工作目录

dir() # 返回指定目录下子目录和文件名的向量，默认问当前工作目录
dir(recursive = TRUE) # recursive 参数可以实现对子目录进行递归，获取子目录中的文件信息

###

# 遍历输出文件中所有文件的内容
sumDir <- function(dirpath){
  result <- list()
  result$content <- NULL
  filepaths <- dir(dirpath, recursive = TRUE)
  for (path in filepaths) {
    filepath <- file.path(dirpath, path) # file.path() 根据操作系统拼接路径
    if(!file.info(filepath)$isdir){ # file.info()返回结果为一个数据框，其中isdir属性表示路径是否为文件夹
      result$content <-  c(result$content, scan(filepath, quiet = TRUE)) # quite参数设置scan()读取文件时不打印读取的元素个数
    }
  }
  result$total <- sum(result$content)
  return(result)
}

sumDir("io/sumdir")
