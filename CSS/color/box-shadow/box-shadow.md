# CSS box-shadow



## link

1. [CSS TRICKS - CSS Box Shadow](https://css-tricks.com/snippets/css/css-box-shadow/)



## 1. 基本认识
1. `box-shadow` 只能用于块级元素(block)
2. 元素阴影的大小是在原有元素的基础上，通过 `box-shadow` 的各个属性进行调节和变化的
3. 可以通过浏览器的开发这工具查看 `box-shadow` 的各个参数属性   

![](.\pic\box-shadow in devtool.png)



## 2. 基本使用

### 2.1 基本属性

````css
.shadow {
    box-shadow: [type] x-offset y-offset [blur] [spread] [colour];
}
````

1. *Type*：阴影类型，有 **外阴影** 和 **内阴影** 两种，默认为 **外阴影** ，当要设置 **内阴影** 时可以设置为`inset`
2. X offset：水平方向的偏移量，**左负右正**
3. Y offset：垂直方向的偏移量，**上负下正**
4. *Blur radius*：虚化的半径，对阴影整起作用，会增大阴影的面积
5. *Spread radius*：扩展半径，在原有阴影大小的基础上，在水平和垂直两个方向同时扩大阴影面积
6. *Colour*：阴影颜色，默认为黑色

***注意：***

1. Type、Blur radius、Spread radius 和 Colour 为可选属性，X offset 和 Y offset 为必填属性
2. 对于 Type，它只有一个可选的值 `inset`
3. 对于 x-offset、y-offset、blur 和 spread 这几个数字值的属性，浏览器会按照这个顺序进行解释，同时这四个属性也只能连续放在一起，而不能将 type 或 colour 插在中间
4. x-offset、y-offset、blur 和 spread 应用的顺序为 `x-offset = y-offset  >  spread  >  blur` 

#### 2.1.1 type

1. 对于 type，它只有一个可选的值 `inset` 
2. 当 type 设置为 `inset` 时，blur 和 spread 属性都会变成向内收缩

#### 2.1.2 blur

当设置虚化半径为负数时，相当于取消阴影

#### 2.1.3 spread

当设置扩展半径为负数时，整个阴影会收缩



## 3. 多层阴影

对于 `box-shadow` 样式，可以通过设置多组阴影的属性来应用叠加阴影，多个阴影之间使用逗号(,) 分隔

```CSS
.multiple-shadow {
    box-shadow: 5px 0 5px -5px yellowgreen, 0 5px 5px -5px olive;
}
```



## 4. Demo

### 4.1 outside box-shadow

![](.\pic\box-shadow demo.png)

### 4.2 inset box-shadow

![](.\pic\box-shadow inset demo.png)

### 4.3 one-side box-shadow

![](.\pic\one side shadow.png)

