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

可以使用`--watch`命令，让webpack持续监视entry，只要有变化就自动打包
```json
"scripts": {
    "build": "webpack --watch"
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

执行打包命令时，可以使用`--config`选项指定打包的配置文件，该文件可以使任何格式，而默认情况下会找`webpack.config.js`

> npx webpack --config webpack.config.js

---
由于`webpack.config.js`采用的是CommonJS的语法，因此可以灵活使用JS的语法构建配置对象，以支持开发，生产等不同环境的需要。

# 概念(Concept)
本质上，webpack 是一个现代 JavaScript 应用程序的静态模块打包器(module bundler)。当 webpack 处理应用程序时，它会`递归`地构建一个`依赖关系图`(dependency graph)，其中包含应用程序需要的每个模块，然后将所有这些模块打包成一个或多个 bundle。  

At its core, webpack is a static module bundler for modern JavaScript applications. When webpack processes your application, it internally builds a dependency graph which maps every module your project needs and generates one or more bundles.

四个核心概念：
* 入口(entry)
* 输出(output)
* loader
* 插件(plugins)

## 入口(entry)
入口起点(entry point)指示 webpack 应该使用哪个模块，来作为构建其内部依赖图的开始，即代码打包的起点。  
在webpack的配置文件中，使用 `entry` 属性指定入口，默认为 `./src` 目录。

### 单个入口（简写）语法
用法：`entry: string|Array<string>`

```javascript
module.exports = {
  entry: './path/to/my/entry/file.js'
};
```

完整的写法如下：
```javascript
module.exports = {
  entry: {
    main: './path/to/my/entry/file.js'
  }
};
```

### 对象语法
用法：`entry: {[entryChunkName: string]: string|Array<string>}`

这种方式可以生成多个依赖图，每个依赖图是彼此完全分离、互相独立的。每个入口称为一个`chunk`。

```javascript
module.exports = {
  entry: {
    app: './src/app.js',
    vendors: './src/vendors.js'
  }
};
```

## 出口(output)
output 属性告诉 webpack 在哪里输出它所创建的 bundles，包括路径和文件名，默认为`./dist/bundle.js`。  
可以存在多个入口起点，但只指定一个输出配置。
配置出口需要用到 `output` 属性，其 `path` 和 `filename` 子属性用于指定出口目录和输出文件名。

### 单个入口的输出
```javascript
const path = require('path');

module.exports = {
  entry: './path/to/my/entry/file.js',
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: 'my-first-webpack.bundle.js'
  }
};
```  

## 多个入口的输出
如果配置创建了多个单独的 `chunk`，则应该使用占位符(substitutions)来确保每个文件具有唯一的名称。
```javascript
{
    entry: {
        home: './src/app.js',
        search: './src/search.js'
    },
    output: {
        filename: '[name].bundle.js',
        path: __dirname + '/dist'
    }
}
// 写入到硬盘：./dist/home.bundle.js, ./dist/search.bundle.js
```

占位符`[name]`指代的是entry中每个`chunk`的名字(home,search).

当存在多个入口时，不能只有一个出口，不然会打包失败，必须为每个入口分配一个出口，即使用占位符`[name]`
> Conflict: Multiple chunks emit assets to the same filename bundle.js (chunks 0 and 1)


## loader
loader 让 webpack 能够去处理那些非 JavaScript 文件（webpack 自身只理解 JavaScript）。loader 可以将所有类型的文件转换为 webpack 能够处理的有效模块，然后你就可以利用 webpack 的打包能力，对它们进行处理。  

loader 能够 import 导入任何类型的模块（例如 .css 文件），这是 webpack 特有的功能。  
本质上，webpack loader 将所有类型的文件，转换为应用程序的依赖图（和最终的 bundle）可以直接引用的模块。

在webpack配置文件的 module.rules 属性中可配置多个 loader ， 每个loader由两部分组成：
1. test ：用于标识出应该被对应的 loader 进行转换的某个或某些文件。
2. use ：表示进行转换时，应该使用哪个 loader。
3. exclude : 排除项目中不需要转码加载的模块

```javascript
//webpack.config.js

const path = require('path');

module.exports = {
  output: {
    filename: 'my-first-webpack.bundle.js'
  },
  module: {
    rules: [
      {
          test: /\.txt$/,
          use: 'raw-loader',
          exclude: /(node_modules|bower_components)/
       }
    ]
  }
};
```
翻译上述配置：
> “嘿，webpack 编译器，当你碰到「在 require()/import 语句中被解析为 '.txt' 的路径」时，在你对它打包之前，先使用 raw-loader 转换一下。”

use 属性也可以配置成对象的形式，通过 `loader` 属性指定Loader，`options` 为该Loader添加设置项，如使用 babel-loader 时，可以添加 babel 的配置，因此可以不需要`.babelrc`这些babel的配置文件，直接在`webpack.config.js`中配置即可。
```javascript
module: {
    rules: [{
        test: /\.js/,
        use: {
            loader:"babel-loader",
            options:{
                presets: ["env", "react"]
            }
        },
        exclude: /(node_modules|bower_components)/
    }]
},
```

loader 可以将文件从不同的语言（如 TypeScript）转换为 JavaScript，或将内联图像转换为 `data URL`。loader 甚至允许你直接在 JavaScript 模块中 `import CSS`文件！

示例：打包CSS
```javascript
> npm install -D css-loader style-loader

module.exports = {
  module: {
    rules: [
      {
        test: /\.css$/,
        use: [ 'style-loader', 'css-loader' ]
      }
    ]
  }
}
```

`use` 是从后往前加载loader列表，越往后的loader越先加载

### 使用 loader 三种的方式：

1. 配置（推荐）：在 webpack.config.js 文件中指定 loader。
2. 内联：在每个 import 语句中显式指定 loader。
3. CLI：在 shell 命令中指定它们。

#### 内联
可以在 import 语句或任何等效于 "import" 的方式中指定 loader。使用 ! 将资源中的 loader 分开。分开的每个部分都相对于当前目录解析。

使用 `!` 分隔loader，使用 `?` 可以传递查询参数，例如 `?key=value&foo=bar`，或者一个 JSON 对象，例如
`?{"key":"value","foo":"bar"}`。

```javascript
import Styles from 'style-loader!css-loader?modules!./styles.css';
```

#### CLI
通过 CLI 使用 loader：
> webpack --module-bind jade-loader --module-bind 'css=style-loader!css-loader'

这会对 `.jade` 文件使用 jade-loader，对 `.css` 文件使用 style-loader 和 css-loader。

## 插件(plugins)
loader 被用于转换某些类型的模块，而插件则可以用于执行范围更广的任务。插件的范围包括，从打包优化和压缩，一直到重新定义环境中的变量。插件接口功能极其强大，可以用来处理各种各样的任务。

想要使用一个插件，你只需要 require() 它，然后把它添加到 plugins 数组中。多数插件可以通过选项(option)自定义。因为不同目的需要多次使用同一个插件时，需要通过使用 new 来创建它的一个实例。
```javascript
//webpack.config.js

const HtmlWebpackPlugin = require('html-webpack-plugin'); // 通过 npm 安装
const webpack = require('webpack'); // 用于访问内置插件

module.exports = {
  module: {
    rules: [
      { test: /\.txt$/, use: 'raw-loader' }
    ]
  },
  plugins: [
    new HtmlWebpackPlugin({template: './src/index.html'})
  ]
};
```

插件目的在于解决 loader 无法实现的其他事。

webpack 插件是一个具有 `apply` 属性的 JavaScript 对象。apply 属性会被 webpack compiler 调用，并且 compiler 对象可在整个编译生命周期访问。

示例：ConsoleLogOnBuildWebpackPlugin.js
```javascript
const pluginName = 'ConsoleLogOnBuildWebpackPlugin';

class ConsoleLogOnBuildWebpackPlugin {
    apply(compiler) {
        compiler.hooks.run.tap(pluginName, compilation => {
            console.log("webpack 构建过程开始！");
        });
    }
}
```
`compiler.hook` 的 `tap` 方法的第一个参数，应该是驼峰式命名的插件名称。建议为此使用一个常量，以便它可以在所有 hook 中复用。

## 模式(mode)
通过选择 `development` 或 `production` 之中的一个，来设置 `mode` 参数，你可以启用相应模式下的 webpack 内置的优化  
用法：`mode: "development"|"production"`

```javascript
module.exports = {
    mode: 'production'
};
```

也可以从 CLI 参数中传递：
> webpack --mode=production

参数描述：

|选项|描述|  
|:---|:---|  
|development|会将 `process.env.NODE_ENV` 的值设为 development。启用 `NamedChunksPlugin` 和 `NamedModulesPlugin`|
|production|会将 `process.env.NODE_ENV` 的值设为 production。启用 `FlagDependencyUsagePlugin`, `FlagIncludedChunksPlugin`, `ModuleConcatenationPlugin`, `NoEmitOnErrorsPlugin`, `OccurrenceOrderPlugin`, `SideEffectsFlagPlugin` 和 `UglifyJsPlugin`|

## 配置babel
babel主要用于JS文件打包时的语法翻译，可将ES版本高的代码翻译成低版本的代码，以兼容IE等浏览器  
**相关依赖**：`babel-core`, `babel-loader`, `babel-preset-env`
> npm install --save-dev babel-core  
npm install --save-dev babel-loader  
npm install --save-dev babel-preset-env

## webpack-dev-server配置虚拟服务
更改启动项目的方式  
> webpack-dev-server --content-base 根路径 --port 端口

在`webpack.config.js`的`output`参数中添加一项：
> publicPath:自定义虚拟路径

# 配置项
## watch 和 watchOptions
### watch
用法：`watch ：boolean`

启用 Watch 模式。这意味着在初始构建之后，webpack 将继续监听任何已解析文件的更改。Watch 模式默认关闭(false)。

> webpack-dev-server 和 webpack-dev-middleware 里 Watch 模式默认开启。

# watchOptions
使用对象的形式来定制 Watch 模式。
用法：`watchOptions ：object`

```javascript

watchOptions: {
  aggregateTimeout: 300,
  ignored: "/node_modules/",
  poll: 1000
}
```

#### watchOptions.aggregateTimeout
`aggregateTimeout : number`

当第一个文件更改，会在重新构建前增加延迟。这个选项允许 webpack 将这段时间内进行的任何其他更改都聚合到一次重新构建里。以毫秒为单位：
```javascript
aggregateTimeout: 300 // 默认值
```

#### watchOptions.ignored
对于某些系统，监听大量文件系统会导致大量的 CPU 或内存占用。这个选项可以排除一些巨大的文件夹，例如 node_modules：
```javascript
ignored: "/node_modules/"
```

也可以使用 anymatch 模式：
```javascript
ignored: "files/**/*.js"
```

#### watchOptions.poll
`poll : boolean|number`

通过传递 true 开启 polling，或者指定毫秒为单位进行轮询。
```javascript
poll: 1000 // 每秒检查一次变动
```

### CLI启用 Watch 模式
在CLI命令加上`--watch`选项可以启动 Watch 模式。

在运行 webpack 时，通过使用 `--progress` 标志，来验证文件修改后，是否没有通知 webpack。如果进度显示保存，但没有输出文件，则可能是配置问题，而不是文件监视问题。

> webpack --watch --progress

# loader
## babel-loader

- babel-core
- babel-cli
- babel-loader
- babel-preset-env

> npm install --save-dev babel-core babel-cli babel-loader@7 babel-preset-env

```javascript
module: {
  rules: [
    {
      test: /\.js/,
      use: {
        loader: "babel-loader",
        options: {
          presets: ["env",...]
        }
      },
      exclude: /(node_modules|bower_components)/
    }
  ]
}
```

`use`属性使用对象赋值，可以添加`options` 属性添加babel的配置，也可以另外配置`.babelrc`文件

## 样式
* css-loader：遍历加载CSS文件
* style-loader：生成style标记

> npm install --save-dev css-loader style-loader

```javascript
//webpack.config.js
module: {
    rules: [
        {
            test: /\.css/,
            use: ["style-loader", "css-loader"],
            exclude: /(node_modules|bower_components)/
        }
    ]
}
```

`use` 必须将`css-loader`放在最后，因为use对loader的加载顺序是从后往前的，先遍历加载CSS资源，再生成style标记。

## webpack-dev-server
webpack-dev-server是一个小型的node.js Express服务器,它使用webpack-dev-middleware中间件来为通过webpack打包生成的资源文件提供Web服务。它还有一个通过Socket.IO连接着webpack-dev-server服务器的小型运行时程序。webpack-dev-server发送关于编译状态的消息到客户端，客户端根据消息作出响应。

webpack-dev-server 可以用于搭建本地服务器，比实现实时打包部署，动态更新。而webpack-dev-server生成的项目包并没有放在你的真实目录中，而是放在了内存中。默认的server地址是 `http://localhost:8080`，自动打开 `index.html` 为首页。

貌似使用了webpack-dev-server，就不再需要 `Watch` 模式了。

> Use webpack with a development server that provides live reloading. This should be used for development only. It uses webpack-dev-middleware under the hood, which provides fast in-memory access to the webpack assets.

### 安装
在项目中安装 webpack-dev-server :
> npm install --save-dev webpack-dev-server

### 启动
local install  
> node_modules/.bin/webpack-dev-server

globa install
> webpack-dev-server

配置npm命令，通常是使用`start`命令：
```json
{
    "script":{
        "start":"webpack-dev-server"
    }
}
```

> npm start 或 npm run start

`--open`选项可以在启动server的同时自动打开浏览器加载首页

### 配置(devServer)
webpack-dev-server 的相关配置是配置在 webpack.config.js 的 `devServer` 对象中  
用法：`devServer : object`

运行 webpack-dev-server 需要有一个server的目录，默认是在当前目录(webpack.config.js所在目录)，这个目录也可以在`contentBase`选项中设置
#### 项目目录(contentBase)
用法：`contentBase : boolean | string | array`

```javascript
devServer: {
    contentBase: "./dist"
}
```

也可以通过CLI配置：
> webpack-dev-server --content-base dist

#### server host && port
```json
"devServer": {
    "host": "localhost",
    "port": 8080
}
```

CLI配置  
> webpack-dev-server --host 127.0.0.1
> webpack-dev-server --port 8080

作者：tsyeyuanfeng
链接：https://www.jianshu.com/p/941bfaf13be1
來源：简书
简书著作权归作者所有，任何形式的转载都请联系作者获得授权并注明出处。

# Link
### 官网
中文官网  
https://www.webpackjs.com/  
英文官网  
https://webpack.js.org/  
开发中 Server(devServer)  
https://www.webpackjs.com/configuration/dev-server/
### Blog
陈三 —— webpack 4 教程  
https://blog.zfanw.com/webpack-tutorial/
### 表严肃
Webpack精讲 - 表严肃讲Webpack  
http://biaoyansu.com/21.x  
### SegmentFault
详解webpack-dev-server的使用  
https://segmentfault.com/a/1190000006964335
### 简书
WEBPACK DEV SERVER  
https://www.jianshu.com/p/941bfaf13be1
### Github
https://github.com/webpack/webpack-dev-server
### 阮一峰
JavaScript Source Map 详解  
http://www.ruanyifeng.com/blog/2013/01/javascript_source_map.html
