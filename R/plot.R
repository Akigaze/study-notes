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

### from R in Action ###

?mtcars
mtcars

drawmtcars <- function(){
  attach(mtcars)
  plot(wt, mpg)
  abline(lm(mpg~wt))
  title("Regression of MPG on Weight")
  detach(mtcars)
}

pdf("mtcars-mpg-wt.pdf")
drawmtcars()
dev.off()

savetopdf <- function(name, draw){
  fullname <- paste(name, "pdf", sep = ".")
  pdf(fullname)
  draw()
  dev.off()
}

savetopng <- function(name, draw){
  fullname <- paste(name, "png", sep = ".")
  png(fullname)
  draw()
  dev.off()
}

savetopdf("mtcars-mpg-wt", drawmtcars)
savetopng("mtcars-mpg-wt", drawmtcars)

### example ###
dose <- c(20,30,40,45, 60)
druga <- c(16, 20, 27, 40, 60)
drugb <- c(15, 18, 25, 31, 40)
dev.new()
plot(dose, druga, type = "b", main = "Drug A", ylim = c(0, 60))
dev.new()
opar <- par(no.readonly = TRUE) # no.readonly = TRUE 参数可以复制一份当前全局图像参数的设置
par(lty=2, pch=17) # par函数会修改全局的图像参数
plot(dose, drugb, type = "b", main = "Drug B", ylim = c(0, 60))
par(opar) # 将图形参数设置还原成最开始的
dev.off()

### R color ###

colors() # 查看内置颜色
# R 中有丰富的生成不同模式的颜色的函数
rainbow(7) # 生成指定数量的彩虹颜色
heat.colors(3)
terrain.colors(3)
topo.colors(3)
cm.colors(3)

# 设置颜色的属性
# col
# col.main, col.axis, col.lab, col.sub, bg, fg

n <- 14
barplot(rep(1, n), col=rainbow(n), main = "Hello world", col.main="#FF8000FF", col.axis="#FF8000FF") #barplot() 绘制柱状图
mycolors <- rainbow(n)
pie(1:n, col = mycolors, labels = mycolors) #pie() 绘制饼图

### R 文字 ###
opar <- par(no.readonly = TRUE)
par(cex=3, cex.main=4, cex.axis=2, cex.lab=2)     # cex 参数主要是设置字号
par(font=4, font.main=3, font.axis=2, font.lab=5) # font 参数是设置字体样式
plot(dose, druga, type = "b", main = "Drug A")
text(locator(1), "A point")
par(opar)

### 尺寸 ###
dev.new()
opar <- par(no.readonly = TRUE)
par(pin=c(2,3), mai=c(5,2,2,5))
par(lwd=2, cex=1.5)
par(cex.axis=.75, font.axis=3)
plot(dose, druga, type = "b", pch=19, lty=2, col="red")

plot(dose, drugb, type = "b", pch=23, lty=6, col="blue", bg="green")
par(opar)
dev.off()
### 标题，坐标轴 ###
hist(
  drugb, 
  col = "red",
  main = "Clinical Trials for Drug B", 
  sub="This is hypothetical data", 
  xlab = "Dosage", 
  ylab = "Drug Response", 
  xlim = c(0, 60),
  ylim = c(-10, 60)
)

### title ###
hist(drugb, ann=FALSE)
# title() 不仅设置所有和标题相关的内容和参数，包括主标题，副标题，坐标轴标题等
title(
  col.main="orange",
  main = "Clinical Trials for Drug B", 
  sub="This is hypothetical data", 
  xlab = "Dosage", 
  ylab = "Drug Response",
  col.iab="blue"
)

### 禁用绘图的默认设置 ###
# ann=FALSE 禁用标题
# axes=FALSE 禁用坐标轴和边框
# frame.plot = FALSE 禁用边框，对边框控制的优先级高于axes 
# xaxt="n", yaxt="n" 禁用指定坐标轴
plot(dose, druga, type = "b", ann=FALSE, axes = FALSE)
plot(dose, druga, type = "b", frame.plot = FALSE)
plot(dose, druga, type = "b", xaxt="n")
plot(dose, druga, type = "b", yaxt="n")

### 坐标轴 ###
# axis() 添加坐标轴
# side参数设置坐标轴的位置：1下，2左，3上，4右
# at参数设置刻度的位置，同时也限定了轴的范围
# labels刻度上的文本
x = c(20, 30, 40, 50, 60)
z = c(20, 30, 40, 50, 50)
opar <- par(no.readonly = TRUE)
par(mar=c(5,4,4,8) + 0.1)
plot(dose, druga, type = "b", pch=21, lty=3, col="red", ann=FALSE, yaxt="n")
lines(x, z, type = "b", pch=22, col="blue", lty=2)
axis(2, at=druga, labels = druga, col="yellow", lty=5, col.axis="red", las=2)
axis(4, at=z, labels = z, col="green", col.axis="blue", las=2, cex.axis=0.7, tck=-0.01)
mtext("y=1/x", side = 4, line = 3, cex.lab=1, las=2, col="blue")
title("An Example of Creative Axes", xlab = "X value", ylab = "Y = X")
par(opar)
dev.off()

### abline 参考线 ###
plot(dose, druga, type = "b", pch=21, lty=3, col="red", main="Test Line of Reference")
abline(h=c(30, 50), col="blue", lty=3) # h 参数指定水平参考线
abline(v=c(25, 40), col="green", lty=4) # v 参数指定竖直参考线
abline(a=0, b=1, col="pink") # a, b 代表截距和斜率
abline(c(60, -1), col="orange") # 截距和斜率

### Hmisc 次级刻度线 ###
install.packages("Hmisc")
library()
### legend 图例 ###
opar <- par(no.readonly = TRUE)
par(lwd=2, cex=1.5, font.lab=2)
plot(dose, druga, type = "b", pch=15, lty=1, col="red", ylim = c(0, 60), xlab = "Drug Dosage", ylab = "Drug Response")
lines(dose, drugb, type = "b", pch=17, col="blue", lty=2)
abline(h=30, lwd=1.5, lty=2, col="grey")
title(main = "Drug A vs. Drug B")
legend("topleft", inset = 0.05, title = "Drug Type", legend = c("A", "B"), lty=c(1, 2), col=c("red", "blue"), pch = c(15, 17))
# legend() 通过 x, y 参数指定图例的位置， 也可以使用locator(), 或者"topleft" 这样的定位方式
# legend参数指定图例的数量，顺序和名称， 在指定其他相关属性时也必须按该顺序和数量来设置
par(opar)
dev.off()

### text/mtext 文本标注 ###
attach(mtcars)
plot(wt, mpg, main = "Mileage vs. Car Weight", xlab = "Weight", ylab = "Mileage", pch=18, col="blue")
text(wt, mpg, row.names(mtcars), cex=0.6, pos=4, col="red")
# pos 参数可以设置文本相对于坐标的方位：1下，2左，3上，4右
detach(mtcars)
# mtext() 可以在图标边框外添加文本

### 图形组合 ###
mfrowexample <- function(){
  attach(mtcars)
  oper <- par(no.readonly = TRUE)
  par(mfrow=c(2,2)) # mfrow 可以将绘图区划分成指定行数和列数，每次绘制图形时往不同区域填充图形，mfrow 指定按行填充，mfcol 指定按列填充
  plot(wt, mpg, main = "1. Mileage vs. Car Weight")
  plot(wt, disp, main = "2. Displacement  vs. Car Weight")
  hist(wt, main = "3. Histogram of Weight")
  boxplot(wt, main = "4. Boxplot of Weight")
  par(opar)
  detach(mtcars)
}

multiplot <- function(mf, draw){
  opar <- par(no.readonly = TRUE)
  par(mfrow=mf) # mfrow 可以将绘图区划分成指定行数和列数，每次绘制图形时往不同区域填充图形，mfrow 指定按行填充，mfcol 指定按列填充
  draw()
  par(opar)
}
dev.new()
multiplot(c(3,1), function(){
  attach(mtcars)
  hist(mpg)
  boxplot(disp)
  pie(wt, pin=c(3,4))
  detach(mtcars)
})

layoutplot <- function(mx, draw, ws=NULL, hs=NULL){
  layout(mx, widths = ws, heights = hs)
  draw()
}

plotdistribution <- c(1,1,2,3,4,4)
layoutplot(
  matrix(plotdistribution, 3,2, byrow = TRUE),
  function(){
    attach(mtcars)
    hist(mpg)
    boxplot(disp)
    pie(wt, )
    plot(wt, gear)
    detach(mtcars)
  }
)

layoutplot(
  matrix(c(1,2), nrow = 1),
  function(){
    plot(1:8, 8:1)
    layoutplot(
      matrix(plotdistribution, 3,2, byrow = TRUE),
      function(){
        attach(mtcars)
        hist(mpg)
        boxplot(disp)
        pie(wt, )
        plot(wt, gear, cex=9)
        detach(mtcars)
      }
    )
  }
)

layoutplot(
  matrix(plotdistribution, 3,2, byrow = TRUE),
  function(){
    attach(mtcars)
    hist(mpg)
    boxplot(disp)
    pie(wt)
    plot(wt, gear)
    detach(mtcars)
  },
  ws=c(3,1), 
  hs=c(1,2,1)
)

sort(mtcars$disp)
median(mtcars$disp)
max(mtcars$disp)
boxplot(mtcars$disp)
layout(matrix(1, 1,1))

layout(matrix(c(1,2,3,0,2,3,0,0,3),nrow =3))
layout.show(4)
layout(matrix(1))

figexample <- function(){
  opar <- par(no.readonly = TRUE)
  par(fig = c(0, 0.8, 0, 0.8))  # (x1, x2, y1, y2) 按百分百从这个绘图区域选出指定的范围进行绘图，绘图一般是居中绘制的
  plot(mtcars$wt, mtcars$mpg, ylab = "Miles Per Gallon", xlab = "Weight of Car")
  par(fig = c(0, 0.8, 0.65, 1), new=TRUE) # new 参数让par函数冉伟当前图像就是一个新开的图像
  boxplot(mtcars$wt, horizontal = TRUE, axes=FALSE)
  par(fig = c(0.65,1, 0, 0.8), new=TRUE)
  boxplot(mtcars$mpg, axes=FALSE)
  mtext("Enhanced Scatterplots", side = 3, line = -3, outer = TRUE, font=2)
  par(opar)
}

figexample()


symbolschart <- function(){
  attach(mtcars)
  r <- sqrt(disp/pi)
  symbols(wt, mpg, circle = r, inches = 0.1, fg="aliceblue", bg="lightblue", ann=FALSE) 
  title(main="Bubble Plot", xlab = "Weight of Car", ylab = "Miles Per Gallon")
  text(wt, mpg, row.names(mtcars), cex=0.4)
  detach(mtcars)
}
pdf("bubble.pdf")
symbolschart()
dev.off()

cs <- colors()
csblue <- cs[endsWith(cs, "blue")]
barplot(1:length(csblue), col = csblue, names.arg=1:length(csblue))
axis(side = 1, at)
