## Link

[w3ctech- CSS 模块](<https://www.w3ctech.com/topic/1479>)

[webpack- css-loader](<https://webpack.js.org/loaders/css-loader/#root>)

[github- css-modules](<https://github.com/css-modules/css-modules>)

**demo:**   

- [github- wepack-demo](<https://github.com/css-modules/webpack-demo>)



## 思想

1. 定义有意义的 **类选择器** 名称
2. 使用 `require`  或 `import` 像引入js模块一样引入css文件
3.  ```



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