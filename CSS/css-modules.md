## Link

[w3ctech  CSS 模块](<https://www.w3ctech.com/topic/1479>)

[webpack  css-loader](<https://webpack.js.org/loaders/css-loader/#root>)

[github  css-modules](<https://github.com/css-modules/css-modules>)

[github  webpack-loader-util loader-options](<https://github.com/webpack/loader-utils#interpolatename>)

[掘金 CSS模块化之路1-3](<https://juejin.im/post/5b20e8e0e51d4506c60e47f5>)

[阮一峰 CSS Modules 用法教程](<http://www.ruanyifeng.com/blog/2016/06/css_modules.html>)

**demo:**   

- [github  wepack-demo](<https://github.com/css-modules/webpack-demo>)



## 思想

1. 定义有意义的 **类选择器** 名称
2. 使用 `require`  或 `import` 像引入js模块一样引入css文件
3. 为每个class选择器设置独一无二的 **哈希名称** (`[hash:base64]`)



## 项目如何引入CSS模块

在 webpack 的配置文件中，为 [`css-loader` 添加一些参数](https://webpack.js.org/loaders/css-loader/#root) . 

```json
module: {
    rules: [{
        test: /\.css/,
        use: ["style-loader", "css-loader?modules"],
        exclude: /(node_modules|bower_components)/
    }]
},
```

- `modules` : 表示开启CSS模块的开发方式



## css-loader

### 参数

![css-loader options](.\pic\css-loader-options.png)

#### modules

是否开启CSS模块的开发方式

- false：默认
- true：默认使用 `local` 的策略
- local
- global

#### camelCase

js引入CSS模块是，类选择器的名称是否使用驼峰

- false：默认
- true：使用驼峰，当时原有的选择器名称保留
- only：使用驼峰，并删除原有的选择器名称
- dashes, dashesOnly

#### localIdentName

编译后的css选择器的命名规则

相关参数和占位符：  

`path` `name` `folder` `ext` `emoji` `hash:baseXX:N` ....

![localIdentName options](.\pic\localIdentName-options.png)



## 使用

#### 1. 像编写普通css文件一样编写css模块文件

#### 2. 使用 `composes` 引用其他类选择器

`.className{ composes: className1 className2 className3 ...  }`

这种方式在编译css文件时，编译后的类选择其中 `large-border` 中并不会包含 `large` 的样式，它们依然只是持有自己独有的样式，JS只是将使用 `large-border` 选择器的地方，同时将 `large` 也加到标签上了而已。

#### 3. 使用 `composes` 引用其他样式文件

` .className{ composes: className1 className2 className3 ... from "css module file"}`

只用引用其他文件选择器的方式，编译原理和引用同一文件的选择器是一样的。

#### Example

```css
/* app.css */
.large{
    font-size: 60px;
}

.bolder{
    font-weight: bolder;
}

.italic{
    font-style: italic;
}

.large-border{
    composes: large;
    composes: bolder italic;
    composes: dotted-thin from "./border.css";
    composes: blue bg-light-green from "./color.css";
    padding: 10px 20px;
}

/* border.css */
.dotted-thin{
    border: 1px dotted #999;
    border-radius: 5px;
}

/* color.css */
.blue{
    color: rgb(40, 181, 248);
}

.bg-light-green{
    background-color: rgb(89, 188, 183, .1);
}
```

####  4. `:local` vs. `:global`

在CSS模块的模式下

- 默认的class选择器都是 `:local` 级别的，即会被 `css-loader` 解释重命名管理的
- 使用 `:global` 可以将特定的class选择器从CSS模块中排除，保持原有的名称，使用 `className="name"` 的形式进行引用

定义方式：

1. `:local(.classA){....}`  `:global(.classB){...}`
2. `:local .classA{....}`  `:global .classB{...}`

引用方式：

1. 对于 `:local` 的选择器，直接使用 `composes: classA` 的形式在其它选择器中引用
2. 对于 `:global` 的选择器，要从webpack提供的 `global` 名称空间进行引用 `composes: classB from global` ，对于多个模块中的 `:global` 选择器，共用一个 `global` 名称空间

#### Example

```css
/* app.css */
:global .large{
    font-size: 40px;
}

:global .shadow{
    text-shadow:  #FC0 1px 0 10px;
}

.large-border{
    composes: large shadow radius-5px from global;
    composes: radius-5px from global;
    padding: 10px 20px;
}

/* border.css */
:global .radius-5px{
    border-radius: 20px;
}
```

