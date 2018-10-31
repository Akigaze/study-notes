# webpack

* JS文件的打包工具
* 转化nodeJS和ES6语法中的`export`, `improt`, `require`等成分为浏览器能够识别的内容
* webpack 不会更改代码中 `export`, `improt`, `require` 以外的部分, 如果要在浏览器使用其它 ES6 特性，就需要在 webpack 的 `loader` 系统中使用了一个像是 Babel 或 Bublé 的转译器

## 下载安装

> npm install -g webpack  
> npm install -g webpack-cli

## 打包JS文件
将`main.js`中的代码和引用的模块的代码都打包到`all.js`文件中。

> webpack main.js -o all.js

通常webpack只能打包JS代码中`import`或`require`显式导入模块，而使用HTML的script标签隐式导入的JS代码则无法直接打包，这些隐式的依赖模块需要在打包的目标JS文件之前导入HTML中。

而在默认情况下，webpack会打包项目的`src`目录中的JS文件，生成`main.js`存放到到`dist`目录下，而这一动作只需要一个`npx webpack`命令即可。打包命令：
> npx wepack

若使用了全局安装，可用下面的命令：
> webpack

可在package.json中配置npm命令进行打包，此时只需使用`webpack`命令，npm会自动检索项目中的 `./node_modules/.bin/webpack`模块执行：
```json
"scripts": {
    "build": "webpack"
 }
```

```js
// 打包前的项目结构
webpack-demo
|- package.json
|- /src
  |- index.js
```

```js
// 打包后的项目结构
webpack-demo
|- package.json
|- /src
  |- index.js
|- /dist
  |- main.js  
```

## webpack.config.js
* 使用`webpack.config.js`文件配置管理webpack的工作
* 在项目根目录下创建该文件
* 使用nodeJS语法编写配置信息

```javascript
const path = require('path');

module.exports = {
    //打包的入口文件
    entry: './src/index.js',
    //打包的出口文件
    output: {
        filename: 'bundle.js',
        path: path.resolve(__dirname, 'dist')
    },
    //监听修改，自动打包
    watch:true
};
```

执行打包命令时，可以使用`--config`选项指定打包的配置文件，该文件可以使任何文件格式，而默认情况下会找`webpack.config.js`

> npx webpack --config webpack.config.js

## 配置babel
babel主要用于JS文件打包时的语法翻译，可将ES版本高的代码翻译成低版本的代码，以兼容IE等浏览器  
**相关依赖**：`babel=-core`, `babel-loader`, `babel-preset-env`
> npm install --save-dev babel-core
npm install --save-dev babel-loader
npm install --save-dev babel-preset-env

## webpack-dev-server配置虚拟服务
更改启动项目的方式  
> webpack-dev-server --content-base 根路径 --port 端口

在`webpack.config.js`的`output`参数中添加一项：
> publicPath:自定义虚拟路径


# Link
### 官网
中文官网  
https://www.webpackjs.com/  
英文官网  
https://webpack.js.org/  
### Blog
陈三 —— webpack 4 教程  
https://blog.zfanw.com/webpack-tutorial/
