# Babel
Babel是一个广泛使用的转码器，可以将ES6代码转为ES5代码  
而"`export`, `improt`等nodeJS成分为浏览器能够识别"是`webpack`的功能

```javascript
// 转码前
input.map(item => item + 1)

// 转码后
input.map(function (item) {
  return item + 1
})
```

![Babel](..\pic\babel-logo.png)  
## 配置文件.babelrc
配置文件`.babelrc`，存放在项目的根目录下，用来设置转码规则和插件，格式如下：

```json
{
    "presets": [],
    "plugins": []
}
```

`presets`字段设定转码规则，官方提供以下的规则集，你可以根据需要安装：

```javascript
// ES2015转码规则
$ npm install --save-dev babel-preset-es2015

// react转码规则
$ npm install --save-dev babel-preset-react

// ES7不同阶段语法提案的转码规则（共有4个阶段），选装一个
$ npm install --save-dev babel-preset-stage-0
$ npm install --save-dev babel-preset-stage-1
$ npm install --save-dev babel-preset-stage-2
$ npm install --save-dev babel-preset-stage-3
```

将规则加入`presets`如下：

```json
{
    "presets": [
        "es2015",
        "react",
        "stage-2"
    ],
    "plugins": [
        "transform-class-properties",
        "es2015-arrow-functions",
        "transform-decorators-legacy"
    ]
}
```

可以说，`presets`是`plugins`的集成，为了引入方便，Babel团队将ES2015的很多个transform plugin集成到babel-preset-es2015，所以你只需要引入es2015，大大降低了引入成本

plugin和preset运行顺序：
* plugin 会运行在 preset 之前
* plugin 会从第一个开始顺序执行
* preset 的顺序则刚好相反(从最后一个逆序执行)

## babel tools
* babel-cli
* babel-core
* babel-register
* babel-polyfill
* babel-runtime
* babel-loader

## babel presets
> Deprecated  
 ~~babel-preset-env~~  
 ~~babel-preset-es2015~~  
 ~~babel-preset-react~~  
 ~~babel-preset-stage-0 (0-3)~~  


- `@babel/preset-env` for compiling ES2015+ syntax
- `@babel/preset-typescript` for TypeScript
- `@babel/preset-react` for React
- `@babel/preset-flow` for Flow

## babel plugins

## babel-cli
命令行转码`babel-cli`，用于在命令行使用命令对文件进行转码

>  npm install --global babel-cli

基本用法如下:

```javascript
// 转码结果输出到标准输出
$ babel example.js

// 转码结果写入一个文件，--out-file (-o) 参数指定输出文件
$ babel example.js --out-file compiled.js

// 整个目录转码， --out-dir (-d) 参数指定输出目录
$ babel src --out-dir lib
// 整个目录转码， --out-file (-o) 参数指定输出到一个文件
$ babel src --out-dir lib/bundle.js

// -s 参数生成source map文件
$ babel src -d lib -s
```

在`package.json`中配置`babel`的 script可以使用npm命令转码。

将`babel-cli`安装在项目之中:

> npm install --save-dev babel-cli

然后，改写`package.json`:

```json
{
    "devDependencies": {
        "babel-cli": "^6.0.0"
    },
    "scripts": {
        "build": "babel src -d lib"
    },
}
```

转码的时候，就执行下面的命令。

> npm run build

## babel-node
`babel-node`是`babel-cli`工具自带的一个命令，提供一个支持ES6的REPL环境。它支持Node的REPL环境的所有功能，而且可以直接运行ES6代码。

可以在命令行输入`babel-node`命令，进入REPL环境，然后就可以在命令行直接执行ES6的语法或js文件，使用`.exit`命令退出REPL环境。

```javascript
$ babel-node
// 执行JS语句
> (x => x * 2)(1)
2

// 转码，执行js文件
$ babel-node es6.js
2
```

与`node`命令相比，`babel-node`会对js语法进行转码，再执行。

同样可以将`babel-cli`安装在项目中：

> npm install --save-dev babel-cli

在`package.json`文件中添加`babel-node`的命令：

```json
{
    "scripts": {
        "script-name": "babel-node script.js"
    }
}
```

## babel-register
`babel-register`模块会自动改写`require`命令，为它加上一个钩子。此后，每当使用require加载`.js`、`.jsx`、`.es`和`.es6`后缀名的文件，就会先用Babel进行转码。

> npm install --save-dev babel-register

使用`babel-register`时，必须首先加载babel-register:

```javascript
require("babel-register")
require("./index.js")
```

然后，就不需要手动对index.js转码了。  

需要注意的是，babel-register只会对require命令加载的文件转码，而不会对当前文件转码。另外，由于它是实时转码，所以只适合在开发环境使用。

## babel-core
如果某些代码需要调用Babel的API进行转码，就要使用`babel-core`模块。

> npm install babel-core --save

在项目中引入`babel-core`模块就可以调用babel-core的API了。

```javascript
var babel = require('babel-core')

// 字符串转码
babel.transform('code();', options)
// => { code, map, ast }

// 文件转码（异步）
babel.transformFile('filename.js', options, function(err, result) {
  result // => { code, map, ast }
})

// 文件转码（同步）
babel.transformFileSync('filename.js', options)
// => { code, map, ast }

// Babel AST转码
babel.transformFromAst(ast, code, options)
// => { code, map, ast }
```

配置对象`options`，可以参看官方文档:  
http://babeljs.io/docs/usage/options/

下面是一个例子:

```javascript
var es6Code = 'let x = n => n + 1'
var es5Code = require('babel-core')
  .transform(es6Code, {
    presets: ['es2015']
  })
  .code
// '"use strict";\n\nvar x = function x(n) {\n  return n + 1;\n};'
```

上面代码中，`transform`方法的第一个参数是一个字符串，表示需要转换的ES6代码，第二个参数是转换的配置对象。

## babel-polyfill
Babel默认只转换新的JavaScript句法（syntax），而不转换新的API，比如`Iterator`、`Generator`、`Set`、`Maps`、`Proxy`、`Reflect`、`Symbol`、`Promise`等全局对象，以及一些定义在全局对象上的方法（比如`Object.assign`）都不会转码。

举例来说，ES6在Array对象上新增了Array.from方法。Babel就不会转码这个方法。如果想让这个方法运行，必须使用babel-polyfill，为当前环境提供一个垫片。

> npm install --save babel-polyfill

然后，在脚本头部，加入如下一行代码:

```javascript
import 'babel-polyfill'
// 或者
require('babel-polyfill')
```

Babel默认不转码的API非常多，详细清单可以查看`babel-plugin-transform-runtime`模块的`definitions.js` (https://github.com/babel/babel/blob/master/packages/babel-plugin-transform-runtime/src/definitions.js)。

## babel-runtime
babel-runtime和babel-polyfill有点类似，都是去兼容新API的"垫片"，它和babel-polyfill最大的不同就是可以做到`按需引用`，哪里需要什么就用什么，在`babel-runtime/core-js/`的路径后面跟上所需要的API。比如我需要Promise。一般在生成环境，首先安装依赖，然后引入：

> npm install --save babel-runtime

```javascript
import Promise from 'babel-runtime/core-js/promise';
```

`babel-plugin-transform-runtime`是babel-runtime的一个插件，可以减少相同API的重复引入，使用时只需安装，配置到plugins中即可

```json
// .babelrc
{
  "plugins": [
    "transform-runtime"
  ]
}
```

## babel-preset-env
babel-preset-env是一个新的preset，可以根据配置的目标运行环境（environment）自动启用需要的babel插件。

Babel是每个Node.js的使用者都会使用的一个代码转换器，它可以把ES6、ES7等语法转换成ES5的语法，使其能在更多环境下运行。

但是随着浏览器和Node.js的版本迭代，他们对新语法的支持也越来越好。但是非常尴尬的是，我们总是使用Babel把所有代码一股脑转换成ES5。这意味着我们抛弃了性能优秀的let、const关键字，放弃了简短的代码，而选择了又长又丑像坨屎的经过变换后的代码。

目前我们写javascript代码时，需要使用N个preset，比如：babel-preset-es2015、babel-preset-es2016。babel-preset-latest可以编译stage 4进度的ECMAScript代码。

问题是我们几乎每个项目中都使用了非常多的preset，包括不必要的。例如很多浏览器支持ES6的generator，如果我们使用babel-preset-es2015 的话，generator函数就会被编译成ES5代码。

babel-preset-env的工作方式类似babel-preset-latest，唯一不同的就是babel-preset-env会根据配置的env, 只编译那些还不支持的特性。

使用这个插件，就再也不需要使用 es20xx presets 了。

> npm install --save-dev babel-preset-env

babel-preset-env在presets中可以添加许多配置项，用于配置运行环境。

1. 当没有配置项将会运行所有转换

```json
{
    "presets": ["env"]
}
```

使用`targets.browsers`和`targets.node`配置运行环境

```javascript
{
  "presets": [
    ["env", {
      "targets": {
        "browsers": ["last 2 versions", "safari >= 7"],
        "node": "6.10" // "node": "current"
      }
    }]
  ]
}
```

## 翻译箭头函数
由于箭头函数是ES7的新语法，而不是ES6的内容，因而只引入es2015的preset是不够的，还用引入`stage-1`
> npm install -D babel-preset-stage-1
```json
{
    "presets": [
        "es2015",
        "stage-1"
    ]
}
```


## 浏览器环境使用Babel
Babel也可以用于浏览器环境。但是，从`Babel 6.0`开始，不再直接提供浏览器版本，而是要用构建工具构建出来。如果你没有或不想使用构建工具，可以通过安装`5.x`版本的`babel-core`模块获取。

> npm install babel-core@old

运行上面的命令以后，就可以在`node_modules/babel-core/`目录里面，找到babel的浏览器版本`browser.js`（未精简）和`browser.min.js`（已精简）。

然后，将下面的代码插入网页:

```html
<script src="node_modules/babel-core/browser.js"></script>
<script type="text/babel">
// Your ES6 code
</script>
```

上面代码中，`browser.js`是Babel提供的转换器脚本，可以在浏览器运行。用户的ES6脚本放在script标签之中，但是要注明`type="text/babel"`。

另一种方法是使用`babel-standalone`模块提供的浏览器版本，将其插入网页。

```javascript
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.4.4/babel.min.js"></script>
<script type="text/babel">
// Your ES6 code
</script>
```

注意，这种方式是在浏览器上实时将ES6代码转为ES5，对性能会有影响。生产环境需要加载已经转码完成的脚本。

下面是如何将代码打包成浏览器可以使用的脚本，以Babel配合Browserify为例。首先，安装`babelify`模块。

> npm install --save-dev babelify babel-preset-es2015

然后，再用命令行转换ES6脚本。
> browserify script.js -o bundle.js \
  -t [ babelify --presets [ es2015 react ] ]

上面代码将ES6脚本script.js，转为bundle.js，浏览器直接加载后者就可以了。

在package.json设置下面的代码，就不用每次命令行都输入参数了。

```json
{
    "browserify": {
        "transform": [["babelify", { "presets": ["es2015"] }]]
    }
}
```

## Babel在线转换
Babel提供一个REPL在线编译器，可以在线将ES6代码转为ES5代码。  
https://babeljs.io/repl/

# Link
### 阮一峰
Babel 入门教程  
http://www.ruanyifeng.com/blog/2016/01/babel.html

### 官网
中文官网  
https://babel.docschina.org/  
英文官网    
https://babeljs.io/   
Env preset  
https://www.babeljs.cn/docs/plugins/preset-env/  
Class properties transform  
https://babel.bootcss.com/docs/plugins/transform-class-properties/

### Blog
REPL环境  
https://www.cnblogs.com/AnnieShen/p/6028304.html  
天天の記事簿 —— Node.js神器之babel-preset-env  
http://blog.ttionya.com/article-1695.html  
babel 7 教程  
https://blog.zfanw.com/babel-js/  
BABEL PRESETS STAGE  
http://www.cnblogs.com/rock-roll/p/6250149.html  

### 掘金
谈谈常用Babel配置与babel-preset-env  
https://juejin.im/entry/5b5e69246fb9a04fac0d2202

### fly63前端网
babel-preset-env：一个帮你配置babel的preset  
http://www.fly63.com/article/detial/609
