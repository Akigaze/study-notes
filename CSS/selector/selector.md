Link

1. [阮一峰——CSS选择器笔记](<http://www.ruanyifeng.com/blog/2009/03/css_selectors.html>)
2. [segmentfault——详解 CSS 属性 - 伪类和伪元素的区别](<https://segmentfault.com/a/1190000000484493>)
3. [知乎——CSS中伪类与伪元素，你弄懂了吗](<https://zhuanlan.zhihu.com/p/46909886>)



## 1. 基本选择器

|      | 选择器          | 含义                                                         |
| ---- | --------------- | ------------------------------------------------------------ |
| 1    | *****           | 通用元素选择器，匹配任何元素                                 |
| 2    | **element**     | 标签选择器，匹配所有指定名称的标签元素                       |
| 3    | **.class-name** | class选择器，匹配所有class属性中包含指定class的元素，以 **点(.)** 开头 |
| 4    | **#element-id** | id选择器，匹配所有id属性为指定值的元素，以 **井号(#)** 开头  |



## 2. 多元素的组合选择器

**E** 和 **F** 代表不同的基本选择器

|      | 选择器 | 含义                                                         |
| ---- | ------ | ------------------------------------------------------------ |
| 1    | EF     | 选择同时拥有E和F两种选择器的元素，E和F之间 **没有任何分隔符** |
| 2    | E,F    | 多元素选择器，同时匹配所有包含E或F选择器的元素，E和F之间用 **逗号(,)** 分隔 |
| 3    | E F    | 后代元素选择器，匹配所有属于E元素后代的F元素，E和F之间用 **空格** 分隔 |
| 4    | E > F  | 子元素选择器，匹配所有E元素的子元素F，E和F之间用 **大于号(>)** 分隔 |
| 5    | E + F  | 毗邻元素选择器，匹配所有紧随E元素之后的同级元素F，E和F间用 **加号(+)** 分隔 |
| 6    | E ~ F  | 同级选择器，匹配任何在E元素之后所有同级的F元素               |

##### 注：选择器间的选择顺序

```css
#big-father p + ul {
    border: 3px solid #f44336;
    border-radius: 10px;
}
```

多元素的选择器组合会从左到右执行，先找出满足 `#big-father p` 的元素，在找相邻的 `ul` .



## 3. 属性选择器

1. 对于属性选择器，最前面的选择器种类是可以省略的，比如 `[cheacked]`，只筛选具有指定属性或值的元素
2. 选择器中的属性值 val 可以加引号，也可以不加

|      | 选择器       | 含义                                                         |
| ---- | ------------ | ------------------------------------------------------------ |
| 1    | E[att]       | 匹配所有具有att属性的E元素，不考虑它的值。                   |
| 2    | E[att=val]   | 匹配所有att属性等于"val"的E元素                              |
| 3    | E[att~=val]  | 匹配所有att属性具有多个 **空格** 分隔的值、其中一个值等于"val"的E元素 |
| 4    | E[att\|=val] | 匹配所有att属性具有多个 **连字号(-)** 分隔（hyphen-separated）的值、其中一个值 **以val开头** 的E元素，主要用于lang属性，比如"en"、"en-us"、"en-gb"等等 |
| 5    | E[att^=val]  | 属性att的值以"val" **开头** 的元素                           |
| 6    | E[att$=val]  | 属性att的值以"val" **结尾** 的元素                           |
| 7    | E[att*=val]  | 属性att的值 **包含** "val"字符串的元素                       |

## 4. 伪类 vs 伪元素

1. 伪类和伪元素十分相似，所以在使用时，推荐伪类使用 **:pseudo-class** ，伪元素使用 **::pseudo-element** ，依次在代码中对两者进行区分，当然伪元素使用 **:pseudo-element** 也是没问题的
2. **伪类**：用于定义元素在特殊状态的效果，或者为某些特殊元素定义 **样式效果** (*可以在指定元素上添加class进行替代*)，资料：[w3c](<https://www.w3schools.com/Css/css_pseudo_classes.asp>)，[MDN](<https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-classes>)
3. **伪元素**：用于为元素定义 **特殊的效果** (*可以通过添加新元素进行替代*) ，资料：[w3c](<https://www.w3schools.com/Css/css_pseudo_elements.asp>)，[MDN](<https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-elements>)

### 4.1 伪元素

用于为元素定义 **特殊的效果** ，*可以通过添加新元素进行替代*，**MDN** 上记录的伪元素也只有14个，而常用的伪元素也不过四五个。

|      | 选择器          | 含义                      |
| ---- | --------------- | ------------------------- |
| 1    | E::first-line   | 匹配E元素的第一行         |
| 2    | E::first-letter | 匹配E元素的第一个字母     |
| 3    | E::before       | 在E元素之前插入生成的内容 |
| 4    | E::after        | 在E元素之后插入生成的内容 |
| 5    | E::selection    | 匹配用户所选中的部分元素  |

伪元素可以通过添加新的元素达到一样的效果，如 **::first-letter** 可以对元素中的第一个字母添加样式，也可以通过对元素中的第一个字母使用 **span** ，再添加样式

#### 4.1.1 ::before 和 ::after

1. **::before** 和 **::after** 伪元素可以在指定元素的 **前或后** 添加一个新的元素，该元素默认为一个 **行内元素**
2. 使用 **content** 样式属性为元素添加文本内容
3. 同时可以使用其他CSS样式属性为该伪元素添加样式
4. 一般像 *自定义checkbox*，*气泡的小箭头* 等都使用这两个伪元素制作的

#### 4.1.2 ::selection

1. **::selection** 貌似只对文本颜色和背景色起作用，对改变文本形态或元素形态不起作用

### 4.2 伪类

用于定义元素在特殊状态的效果，或者为某些特殊元素定义 **样式效果** 这种用法可以通过 *在指定元素上添加class进行实现*。CSS的伪类很多，按功能分为好几类，有不同的用法，大致如下图：

![伪类的功能分类](..\pic\pseudo-class.jpg)

#### 4.2.1 状态 伪类

|      | 选择器    | 含义                                      |
| ---- | --------- | ----------------------------------------- |
| 1    | E:link    | 匹配所有未被点击的链接                    |
| 2    | E:visited | 匹配所有已被点击的链接                    |
| 3    | E:active  | 匹配鼠标已经在其上按下、还没有释放的E元素 |
| 4    | E:hover   | 匹配鼠标悬停其上的E元素                   |
| 5    | E:focus   | 匹配获得当前焦点的E元素                   |

转态相关的伪类主要有5个：**:link**，**:visited**，**:active**，**:hover**，**:focus**，其中 **:link** 和 **:visited** 是与超链接相关的

#### 4.2.2 结构化 伪类

|      | 选择器                   | 含义                                                        |
| ---- | ------------------------ | ----------------------------------------------------------- |
| 1    | E:first-child            | 匹配作为第一个子元素且是E选择器的元素                       |
| 2    | E:last-child             | 匹配作为最后一个子元素且是E选择器的元素                     |
| 3    | E:nth-child(an+b)        | 匹配第an+b个子元素，n的起始值为0，第一个子元素的编号为1     |
| 4    | E:nth-last-child(an+b)   | 匹配倒数第an+b个子元素，n的起始值为0，第一个子元素的编号为1 |
| 5    | E:first-of-type          | 匹配在同一级的兄弟元素中，第一个出现的指定类型的元素        |
| 6    | E:last-of-type           | 匹配在同一级的兄弟元素中，最后一个出现的指定类型的元素      |
| 7    | E:nth-of-type(an+b)      | 匹配第an+b个指定类型的子元素                                |
| 8    | E:nth-last-of-type(an+b) | 匹配倒数第an+b个指定类型的子元素                            |
| 9    | E:only-child             | 匹配没有任何兄弟元素的元素                                  |
| 10   | E:only-of-type           | 匹配没有任何兄弟元素的指定类型的元素                        |
| 11   | E:not(s)                 | 匹配所有与 **s** 不相匹配的元素                             |
| 12   | E:empty                  | 匹配所有没有子元素的元素                                    |

##### 4.2.2.1 :first-child 和 :last-child

**:first-child** 和 **:last-child** 的用法相似，所以此处只对 **:first-child** 进行说明

1. **E:first-child** 要求匹配的元素必须作为 **第一个子元素**，而不是第一个出现的元素，这一点与 **:first-of-type** 有所不同
2. 选择器的种类 **E** 可以省略，此时表示取第一个子元素，不区分具体的选择器类型
3. `p:first-child` 表示匹配的元素必须为p标签，且是第一个子元素；`article :first` 表示article 标签的第一个子元素 

##### 4.2.2.2 :nth-child(an+b) 和 nth-last-child(an+b)

**:nth-child** 和 **:nth-last-child** 的用法相似，所以此处只对 **:nth-child** 进行说明

1. 要求匹配的元素必须作为子元素，这一点与 **nth-of-type(an+b)** 有所不同
2. 首先找到所有当前元素的兄弟元素，然后按照位置先后顺序从 **1** 开始排序，选择的结果为 **:nth-child** 括号中表达式***（an+b）*** 匹配到的元素集合
3. `a` 和 `b` 都必须为整数，并且元素的第一个子元素的下标为 **1**。换言之就是，该伪类匹配所有下标在集合：    **{ an + b; n = 0, 1, 2, ...}**  中的子元素。另外需要特别注意的是，`an` 必须写在 `b` 的前面，不能写成 `b+an` 的形式。
4. **an+b** 也可以用 **odd** （奇数）或者 **even** （偶数） 代替 

##### 4.2.2.3 :only-child

1. 匹配没有任何兄弟元素的元素，但 **并不要求** 该元素必须是一个子元素
2. 可以用 `:first-child:last-child` 或者 `:nth-child(1):nth-last-child(1)` 替代，但是前者权重较低

##### 4.2.2.4 :first-of-type

1. 匹配在 **同一级的兄弟元素** 中 **第一个出现** 的指定类型的元素
2. 当不指定元素类型是，默认指定 **所有类型的标签选择器** 

##### 4.2.2.5 :not(s)

1. **s** 为另一个自定义的选择器规则，表示匹配所有与 **s** 不相匹配的元素
2. **:not(s)** 自身没有权重，而是有 **s** 决定

##### 4.2.2.6 :empty

1. 匹配所有没有子元素的元素，这里的子元素包括 *html标签*  和 *普通文本（包括空格和换行）* ，注释不生效 

#### 4.2.3 表单 伪类

|      | 选择器         | 含义                                                      |
| ---- | -------------- | --------------------------------------------------------- |
| 1.   | E:checked      | 匹配选中状态，一般用于 checkbox，radio，和section的option |
| 2    | E:enabled      |                                                           |
| 3    | E:disabled     |                                                           |
| 4    | E:in-range     | 根据表单的min和max属性作为范围                            |
| 5    | E:out-of-range | 根据表单的min和max属性作为范围                            |



#### 4.2.4 其他伪类

|      | 选择器  | 含义                                                         |
| ---- | ------- | ------------------------------------------------------------ |
| 1    | :target | 代表一个唯一的页面元素(目标元素)，其`id` 与当前URL片段匹配 . |

##### 4.2.4.1 :target

1. **target** 其实代表页面的URL中包含的一个元素ID，如当前URL http://www.example.com/index.html#section2 包含的 id=section2，所有 `p:target` 能匹配出 id=section2 的 `p` 标签
