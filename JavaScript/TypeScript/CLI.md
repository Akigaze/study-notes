## 安装

- typescript: TypeScript解释器, 提供 `tsc` 命令降ts文件编译成js文件
- ts-node: 直接执行TypeScript文件的工具

> npm install --save typescript ts-node

### 执行.ts文件
> ts-node xxx.ts

### 编译.ts文件
将ts文件编译成js文件
> tsc xxx.ts

生成 `.d.ts` 文件, 用于模块引用时的代码提示，`.d.ts` 文件保存的是TypeScript文件中一些变量，方法等的定义
> tsc xxx.ts -d

