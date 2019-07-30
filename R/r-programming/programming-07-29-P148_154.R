# 递归 recursive
# 快速排序 quick sort
quickSort <- function(v){
  if(length(v) <= 1) return(v)
  pivot <- v[1]
  rest <- v[-1]
  smaller <- rest[rest < pivot]
  bigger <- rest[rest >= pivot]
  smaller <- quickSort(smaller)
  bigger <- quickSort(bigger)
  
  return(c(smaller, pivot, bigger))
}

quickSort(c(3,5,1,3,7,4))

v1 <- c(1,2,3)
v1[v1 > 4] # 没有满足条件的元素时，返回一个空的向量，也可以理解为NULL
length(v1[v1 > 4]) # 长度为0
c(v1[v1 > 4], 0) # 空向量会被自动忽略

# 使用R实现二叉查找树：R没有指针，所以采用索引来查找节点
# 使用一个矩阵存储树的信息，每一行为一个节点
# 每行第三个元素为节点的值，第一，二个元素分别是左右字数所在行的索引

printTree <- function(hdidx, tree){
  left <- tree$mat[hdidx, 1]
  if(!is.na(left)) printTree(left, tree)
  print(tree$mat[hdidx, 3])
  right <- tree$mat[hdidx, 2]
  if(!is.na(right)) printTree(right, tree)
}


createTree <- function(root, inc){
  m <- matrix(rep(NA, inc*3), ncol = 3)
  m[1,3] <- root
  return(list(mat=m, nxt=2, inc=inc))
}

insertNode <- function(hdidx, tree, value) {
  dir <- if(value <= tree$mat[hdidx, 3]) 1 else 2
  if(is.na(tree$mat[hdidx, dir])){
    newids <- tree$nxt
    if(tree$nxt == nrow(tree$mat)+1){
      tree$mat <- rbind(tree$mat, matrix(rep(NA, tree$inc*3), ncol = 3))
    }
    tree$mat[newids, 3] <- value
    tree$mat[hdidx, dir] <-newids
    tree$nxt <- tree$nxt + 1
    return(tree)
  }else{
    return(insertNode(tree$mat[hdidx, dir], tree, value))
  }
}


tree <- createTree(8, 3)
tree <- insertNode(1, tree, 5)
tree <- insertNode(1, tree, 6)
tree <- insertNode(1, tree, 2)
tree <- insertNode(1, tree, 12)
tree <- insertNode(1, tree, 9)



tree
printTree(1, tree)
















