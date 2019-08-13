# 绘图核心函数：plot()
# plot() 函数实际上是一个泛型函数
?plot
# plot(x, y) 添加自变量和因变量的数据进行画图
plot(c(2,5,7,9), c(1,3,6,0)) # 只有数据的情况下，只绘制点，且形状为空心点
plot(c(2,5,7,9), c(1,3,2,4,5)) # 在变量的数据方面不支持循环补齐，因变量和自变量的数据个数必须一致
# 可以通过参数控制plot函数生成图像的过程
plot(c(2,5,7,9), c(1,3,6,0), type = "n", xlab = "name of x-axis", ylab = "name of y-axis", main = "plot title")
plot(c(2,5,7,9), c(1,3,6,0), type = "n")
plot(c(2,5,7,9), c(1,3,6,0), type = "l") # type = "l" 表示绘制折线图，而不绘制点
# type参数指定绘制的图像类型，n 表示一个空白图像，即不绘制数据，只绘制坐标轴
# xlab和ylab参数表示坐标轴的名称，在不指定的情况下，R会将相应坐标轴上的数据作为名称
# main参数设置图像的标题

# abline()在图像中添加线条
x <- c(0,2,3,7,9)
y <- c(-1, 1,5,10,15)
plot(x, y)
# abline() 能从传入的参数中提取直线的斜率和截距，在plot()函数绘制的图像中添加直线
abline(lm(y~x)) # lm()进行回归分析的结果中，cofficients属性中存放了拟合结果的斜率和截距
intercept <- 4 # 截距
slope <- 2 # 斜率
abline(c(intercept, slope)) # abline()也可以接受一个向量参数，第一个元素为截距，第二个是斜率

# lines(x, y)在图像中添加线段
x1 <- 2; y1 <- 0
x2 <- 8; y2 <- 5
x3 <- 4; y3 <- 10
x4 <- 6; y4 <- 12
x5 <- 7; y5 <- 8
lines(c(x1, x2), c(y1, y2)) # 提供两个点的坐标，绘制两点间的线段
lines(c(x1, x2, x3,x4,x5), c(y1, y2,y3,y4,y5), col="red") # 也可以传入多个点，按顺序对点进行连线
# col参数控制线条颜色
# pch参数可以控制点的类型，lty参数可以控制线条的类型
?par # par是和图形相关的属性集合

# 绘制多个图像，即多个绘图窗口
hist(c(1,2,1,2,2,1,2))
windows() # 在windows系统下，windows() 会打开一个新的绘图窗口，将新绘制的图像放置在该窗口，但是一个窗口只能有一个图像
# 在linux系统下，要使用X11()函数
plot(1:5, c(3,6,8,12,16), type = "l")

?density
den <- density(rnorm(100, mean=5, sd=2)) # density()计算密度函数
den2 <- density(c(1:20, rnorm(50, mean=3, sd=1), rchisq(30, df=2))) # density()计算密度函数
class(den) == "density"
plot(den, main = "plot title?", xlab = "") # 使用plot.density泛型函数对density类对象进行绘图
lines(den2) # lines函数也可以对density类对象进行绘图，尽管他没有对应的泛型函数
methods(plot)
methods(lines)
edit(lines)

# 对OOP章节的多项式回归例子进行扩展
source("source/oop.R")
rm(plot.polyreg)
plot.ployreg <- function(fits){
  plot(fits$x, fits$y, xlab = "X", ylab = "Y")
  maxdg <- length(fits) - 2
  cols <- c("red", "green", "blue", "yellow", "black", "orange")
  dg <- curvecount <- 1
  while (dg < maxdg) {
    prompt <- paste("RETURN for XV fit for degree", dg, "or type degree", "or q for quit ")
    rl <- readline(prompt)
    dg <- if(rl == "") dg else if(rl != "q") as.integer(rl) else break
    lines(fits$x, fits[[dg]]$fitted.values,col=cols[curvecount%%3 + 1])
    dg <- dg + 1
    curvecount <- curvecount + 1
  }
}

print.ployreg <- NULL

testPloyfit <- function(){
  n <- 60
  x <- (1:n)/n
  y <- vector(length = n)
  for (i in 1:n) {
    y[i] <- sin((3*pi/2)*x[i]) + x[i]^2 + rnorm(1, mean = 0, sd=0.5)
  }
  dg <- 15
  lmo <- ployfit(y, x, dg)
  return(lmo)
}
lmo <- testPloyfit()
class(lmo)
lmo
plot(lmo)


# points() 添加点
plot(1:5, c(9,3,6,12,2))
points(3, 10, pch = "+") # 添加点(3, 10), pch设置点的形状为+
points(c(2, 4), c(10,10), pch = "*") # 添加点(2,10), (4,10)
points(c(5,5), c(10,3), pch="a") 
# par(bg="green")
example("legend")
# legend()用于添加图例

# text(x, y, content) # 在指定位置添加文字
text(5,4, "what's this?") # 会将文字的中心放在指定位置

# locator(n) 通过鼠标确定位置
loc1 <- locator(1) # 参数n为需要知道的位置的个数，即点击的次数
loc1
loc2 <- locator(2)
loc2
# 返回的一个包含x, y属性的list，记录每次点击的坐标
text(locator(1), "y=10") # text与locator的组合使用，通过鼠标选择文本添加的位置
# recordPlot()保存图像，replayPlot()回复图像

###

plot(1:5, c(4,8,0,12,15), xlab = "X", ylab = "Y value", main = "my plot", pch = "*")

?par

# 字符控制参数 cex: character expand
text(locator(1), "normal text")

text(locator(1), "bigger text", cex=1.5)

text(locator(1), "smaller text", cex=0.5)
# cex通过设置文字缩放的比例来改变文字大小

# xlim和ylim控制坐标轴的范围
# 在plot函数指定xlim和ylim参数，设置坐标轴显示的范围
plot(1:5, c(4,8,0,12,15), xlab = "X", ylab = "Y value", main = "my plot", pch = "*", ylim=c(0, 25), xlim=c(0, 15))
points(10,20)
points(8,20)

# curve(func, from, to) 绘制函数图像
f <- function(x) return(1-exp(-x))
curve(f, 0, 4) # 指定函数和要绘制的自变量范围

# polygon(xs, ys, col) 绘制多边形
polygon(c(2,2,3,3), c(0,f(2),f(3),0), col = "grey")
polygon(c(1,2,3), c(0,f(2),1), density = 10) # polygon() 会自动对图像进行闭合
# col参数指定使用颜色填充，density参数指定使用线条填充，数量表示线条的数量
polygon(c(0,0.3,0.6,0,0.6), c(0,0.8,0,0.6,0.6), col = "yellow") 


# 使用lowess()或loess()对数据进行平滑处理生成平滑曲线

# 使用plot()和curve()绘制函数曲线
f2 <- function(x) return(0.4*x)
curve(f2, 0, 4) # curve()会重置图像重新绘图
curve(f, 0, 4, add=TRUE) # 指定 add 参数可以将绘制的曲线添加到原有图像中
curve(sin, 0, 4, add=TRUE, n=4) # n 参数指定使用多少个点的数据绘制图像，默认是101个点
plot(cos, 0, 4, add=TRUE, n=200) # plot同样具有curve相同的功能和参数，它其实是调用了plot.function这个泛型函数

###

# 曲线局部放大
curve

crv <- edit(curve)
inset <- function(savexy, x1, y1, x2, y2, x3, y3, x4, y4){
  rect(x1, y1, x2, y2) # rect() 绘制矩形，指定左下角和右上角的坐标
  rect(x3, y3, x4, y4)
  
  savex <- savexy$x
  savey <- savexy$y
  
  n <- length(savex)
  xvalsinrange <- which(savex >= x1 & savex <= x2)
  yvalsforthosex <- savey[xvalsinrange]
  
  if(any(yvalsforthosex < y1 | yvalsforthosex > y2)){
    print("y value outside first box")
    return()
  }
  
  x2mnsx1 <- x2 - x1
  x4mnsx3 <- x4 - x3
  y2mnsy1 <- y2 - y1
  y4mnsy3 <- y4 - y3
  
  plotpt <- function(i){
    newx <- x3 + ((savex[i]-x1)/x2mnsx1) * x4mnsx3
    newy <- y3 + ((savey[i]-y1)/y2mnsy1) * y4mnsy3
    return(c(newx, newy))
  }
  
  newxy <- sapply(xvalsinrange, plotpt)
  lines(newxy[1,], newxy[2,])
}

xyout <- crv(exp(-x)*sin(1/(x-1.5)), 0.1, 4, n=5001)
inset(xyout, 1.3, -0.3, 1.47, 0.3, 2.5, -0.3, 4, -0.1)

# 查看输出设备
dev.list() # 查看当前所有输出设备及其编号
dev.cur() # 查看当前活跃的设备
pdf("pdf2.pdf") # 在工作目录下打开或新建一个PDF文件，并将其作为活跃的输出设备
dev.set(2) # 设置当前活跃的输出设备
dev.copy(which = 4) # 将当前活跃设备的内容复制到指定编号的设备，并切换活跃设备

dev.off() # 关闭保存设备

# 绘制3D图像
library(lattice)
x <- 1:10
y <- 1:15
eg <- expand.grid(x=x, y=y) # expand.grid()会生成包含所有x，y组合的数据框
eg$z <- eg$x^2 + eg$x * eg$y
wireframe(z ~ x+y, eg, shade = TRUE) # wireframe()根据指定的变量关系和数值，绘制3D图像

