## Flex 布局

**flex** 是 *Flexible Box* 的简写



## Link

1. [阮一峰——Flex 布局教程](<http://www.ruanyifeng.com/blog/2015/07/flex-grammar.html>)

2. [CSS-TRICKS——A Complete Guide to Flexbox](<https://css-tricks.com/snippets/css/a-guide-to-flexbox/>)





## 基本使用

### 1. 引入flex布局

对于 **块级元素** ，使用 `display: flex`

```css
.flex-box {
    display: flex;
}
```

对于 **行内元素** ，使用 `display: inline-flex`

```css
.flex-box {
    display: inline-flex;
}
```

*注意*，设为 flex 布局以后，子元素的 `float`、`clear` 和 `vertical-align` 属性将失效



### 2. 基本概念

采用 flex 布局的元素，称为 flex 容器。容器默认存在两根轴：

1. 水平的主轴（main axis）：主轴开始位置（与边框的交叉点）叫做 **main start **，结束位置叫做 **main end**
2. 垂直的交叉轴（cross axis）：交叉轴的开始位置叫做 **cross start** ，结束位置叫做 **cross end**

flex容器中的元素 **默认沿主轴排列**。单个子元素占据的主轴空间叫做 **main size** ，占据的交叉轴空间叫做 **cross size** 。



### 3. flex容器的属性

在flex容器上可以通过一下 **6** 个属性来调节容器内元素的排布方式

>- flex-direction
>- flex-wrap
>- flex-flow
>- justify-content
>- align-items
>- align-content

#### 3.1 flex-direction

`flex-direction` 属性决定主轴的方向，即容器中元素的排列方向

```css
.flex-box {
    display: flex;
    flex-direction: row | row-reverse | column | column-reverse;
}
```

它有4个可选的值：`row`（默认） 、`row-reverse` 、 `column` 、`column-reverse`

`row` 表示容器中的元素是沿着行的方向排列，即从左到右排；`column` 表示容器中的元素是沿着列的方向排列，即从上到下排

#### 3.2  flex-wrap

默认情况下，容器中的元素都排在一条线（又称 *"轴线"*）上。`flex-wrap` 属性定义了如果一条轴线排不下的情况下，要如何换行。

```css
.flex-box {
    display: flex;
    flex-wrap: nowrap | wrap | wrap-reverse;
}
```

它有3个可选的值：`nowrap`（默认）、`wrap` 、 `wrap-reverse`

`flex-wrap` 的默认值是 `nowrap`，即不换行，在选择了`wrap` 或者 `wrap-reverse` 后开启换行模式，而新行的排列方向与原有行保持一致，沿 `flex-direction` 设置的方向，唯一不同的是，`wrap-reverse` 会颠倒 **行之间** 的顺序。

#### 3.3 flex-flow

`flex-flow` 属性是 `flex-direction` 属性和 `flex-wrap` 属性的组合简写形式，值为 `flex-direction` 和 `flex-wrap` 各自一个值的组合，用空格隔开，默认值为 `row nowrap`。

```css
.flex-box {
	display: flex;
	flex-flow: <flex-direction> <flex-wrap>;
}
```

*注意*：对于`flex-direction` 和 `flex-wrap` 的值可以省略任意一个

#### 3.4 justify-content

`justify-content` 属性定义了元素在主轴上的对齐方式，如向开始位置对其(左对齐)，向结束位置对其(右对齐)，居中对齐等

```css
.flex-box {
    display: flex;
    justify-content: flex-start | flex-end | center | space-between | space-around | space-evenly;
}
```

它主要有6个可选的值：`flex-start`（默认）、 `flex-end` 、 `center` 、 `space-between` 、 `space-around` 、 `space-evenly`

##### 3.4.1 flex-start 与 flex-end

1. `flex-start`：向开始位置对齐，类似左对齐
2. `flex-end`：向结束位置对齐，类似右对齐

##### 3.4.2 space-between，space-around 和 space-evenly

1. `space-between`：两端的元素对齐容器边缘，中间的元素均等分布
2. `space-around`：每个元素两端都添加均等的间隔，即边缘的元素与容器边缘有1单位的间隔，两个元素之间是2单位的间隔
3. `space-evenly`：元素均等分布，元素与容器边缘，元素之间的间隔都相等

#### 3.5 align-items

`align-items` 属性定义容器元素在交叉轴的方向上的对齐方式。因为不同元素的高度可能不同，所以会有顶端对齐，垂直居中，底端对齐等交叉方向上的对齐。

```css
.flex-box {
    display: flex;
    align-items: flex-start | flex-end | center | baseline | stretch;
}
```

它主要有6个可选的值：`stretch` （默认）、`flex-start` 、 `flex-end` 、 `center` 、 `baseline` 

##### 3.5.1 stretch

元素的占满整个交叉轴方向的高度

##### 3.5.2 flex-start 和 flex-end

1. `flex-start`：向交叉轴开始位置对齐，类似顶端对齐
2. `flex-end`：向交叉轴结束位置对齐，类似底端对齐

##### 3.5.3 baseline

所有容器元素的第一行文字的基线对齐

#### 3.6 align-content

`align-content` 属性定义了多根轴线（出现换行）的对齐方式。如果项目只有一根轴线（没有换行），该属性不起作用。

```css
.flex-box {
    display: flex;
    align-content: flex-start | flex-end | center | space-between | space-around | space-evenly | stretch;
}
```

它主要有6个可选的值：`stretch` （默认）、`flex-start` 、 `flex-end` 、 `center` 、 `space-between` 、 `space-around` 、`space-evenly`

`align-content` 与 `justify-content` 类似，只是  `justify-content`  是针对一行内元素的对齐方式，而 `align-content` 则提升了一个维度，针对多行在交叉轴上的对齐方式。



### 4. flex 容器元素的属性

> - order
> - flex-grow
> - flex-shrink
> - flex-basis
> - flex
> - align-self

#### 4.1 order

定义元素在主轴方向上的顺序，值越小，越靠近主轴开始的位置

在没有设置 `order` 属性的情况下，元素根据其定义的顺序和主轴来显示

```css
.item {
  order: <integer>; /* default 0 */
}
```

`order` 的默认值是 **0** ，可以设置为负数

#### 4.2 flex-grow

由于有 `justify-content` 可以控制元素在一行内的排布方式，所以一行之内就可能出现没有元素占据的空白空间，而 `flex-grow` 则是定义了元素通过吸收这些空白的区域来进行放大。

```css
.item {
  flex-grow: <number>; /* default 0 */
}
```

`flex-grow` 的默认值是 **0**，flex布局会统计flex容器中所有元素的 `flex-grow` 值的总和，将空白区域等分，再按每个元素定义的 `flex-grow` 值进行分配。

*注意*，`flex-grow` 统计的是一行，当出现换行是，新的一行会另外计算

#### 4.3 flex-shrink

当设置flex容器为不换行的情况下，所有元素都会挤在一行，当一行无法完全容纳所有元素时，flex容器就会对元素的大小进行压缩，而 `flex-shrink` 就是设置元素被压缩的程度。

```css
.item {
  flex-shrink: <number>; /* default 1 */
}
```

`flex-shrink` 的默认值是 **1**，一行的空间不足时，flex容器就要压缩元素的大小。压缩步骤如下：

1. 计算所有元素的完全大小之和，减去一行的大小，算出要被压缩掉的大小 `W`
2. 计算每个元素的权重：`n1 : n2 : ... = (flex-shrink1)*width1 ： (flex-shrink2)*width2 ： ...` 
3. 
4. 为每个元素分配压缩的大小：`reduce1 = [W / (n1 + n2 +...)] * n1`

*注意*，当flex容器的 `flex-wrap` 设置为换行模式时，该属性无效；**负数** 对该属性无效

当把设置 `flex-shrink` 为 **0** , 则该元素不会被压缩，而当所有元素的 `flex-shrink` 都设置为 **0**  时，所有元素都不压缩，flex容器反而会被撑大。

#### 4.4 flex-basis

在 `flex-grow` 属性生效之前，设置元素的大小，可以认为是对 `width` 或 `height` 的重新设置

```css
.item {
  flex-basis: <length> | auto; /* default auto */
}
```

在 `flex-grow` 属性生效后，设置了 `flex-basis` 的元素的大小会变成 `flex-basis` + 分配的空白空间

#### 4.5 flex

`flex` 属性是 `flex-grow` ,  `flex-shrink`  和 `flex-basis` 的组合简写，默认值为 `0 1 auto`，后两个属性可选。

```css
.item {
  flex: none | auto | [ flex-grow flex-shrink? || flex-basis ] /* default 0 1 auto */
}
```

便捷值：

1. `none`：0 0 auto
2. `auto`：1 1 auto

建议优先使用这个属性，而不是单独写三个分离的属性，因为浏览器会推算相关值。

#### 4.6 align-self

`align-self` 属性允许单个项目有与其他项目不一样的对齐方式，可覆盖 `align-items` 属性。

```css
.item {
  align-self: auto | flex-start | flex-end | center | baseline | stretch;
}
```

`align-self` 的属性值基本与 `align-items` 一样，多了一个 `auto`；

默认值为`auto`，表示继承父元素的 `align-items` 属性