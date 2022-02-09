## 简写列表
* 安装模块时 --save 是默认选项，可以省略不写
* i 是 install 的简写
* -y 是 --yes 的简写
* -g 是 --global 或 -global 的简写，但使用全称时最好使用 --global
* -D 是 --save-dev 的简写

## 默认初始化
> npm i -y  


## 查看所有安装的全局模块
> npm list --depth=0 -global

## 卸载已安装的全局模块
> npm uninstall -g <package>

## npm全局模块的安装目录
> C://Users//username//AppData//Roaming//npm

## 更新npm
> npm install npm@latest -g

## 更新项目中的模块
> npm update <package>

## 降低模块版本
> npm install <package>@version

## 登录NPM账户
> npm login

## 发布和更新npm包
在要发布的包的目录下执行命令：
> npm publish

## 撤销已发布的包
在要撤销的包的目录下执行命令：
> npm unpublish --force

该撤销只会撤销项目的当前版本，若发表过多个版本，则要每个版本都撤销一次，默认只撤销 `package.json` 中标明的版本


## 合并多个命令
在`package.json`的`script`属性中可以定制用户的npm命令，在一个若想在一个script中同时执行多个命令，并且命令有前后顺序，后一个命令必须等待前一个命令，本可以使用 `&` 连接过个命令
```json
{
    "script": {
        "gptp": "git pull -r & jasmine & git push"
    }
}
```

> npm run gptp

windows 合并命令的 & 与 && 的区别
`&&`: will execute command 2 when command 1 is complete providing it didn't fail.(若有一个命令执行的结果是fail，包括测试结果，则后面的命令不在执行)  
`&` : will execute regardless.

## 设置镜像代理
### 安装包时添加临时代理
> npm --registry=https://registry.npm.taobao.org install webpack 

### 设置全局代理
npm config set registry https://registry.npm.taobao.org



# Link
### 表严肃
npm常用命令速查表  
http://biaoyansu.com/20.cheatsheet  
npm火速上手  
http://biaoyansu.com/20.0
### Blog
利用npm安装/删除/发布/更新/撤销发布包  
https://www.cnblogs.com/penghuwan/p/6973702.html


## 2022-02-09

[npm 官网](https://www.npmjs.com/)
[npm 官方文档](https://docs.npmjs.com/)

### 语义版本控制
[NPM Semantic Versioning](https://docs.npmjs.com/about-semantic-versioning)
[Semantic Versioning](https://semver.org/)

`x.y.z`  
- x: major 
- y: minor 
- z: patch

1. Caret Dependencies
   `^1.1.1`: 只更新左侧第一个非0版本之后的版本号
2. Tilde Dependencies
   `~1.1.1`: 只更新右侧版本号


### package-lock.json
[package-lock.json](https://docs.npmjs.com/cli/v8/configuring-npm/package-lock-json)

记录执行 `npm install` 时各个模块的依赖关系，构成一个依赖树
当执行 `npm install` 时所安装的最新版本的包与 `package-lock.json` 中记录的版本不兼容时，则会更新 `package-lock.json`