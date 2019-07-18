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
