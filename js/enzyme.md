# Enzyme
# 使用Jasmine搭建enzyme的测试环境
## 准备
1. 搭建一个React的开发环境
2. 搭建基本的Jasmine测试环境

## 依赖模块
- enzyme
- jasmine-enzyme
- jsdom
- enzyme-adapter-react-16(针对react 16.x)

enzyme 为react测试提供核心的API  
enzyme-adapter-react-16 enzyme的react适配器，用于向Enzyme配置正确的react版本   
jasmine-enzyme 是jasmine配合enzyme使用的扩增matcher库，增加了许多UI测试的断言API，但不是必须的  
jsdom 由于nodeJS没有DOM环境，jsdom可以提供一个node的DOM环境，用于react构造组件和虚拟DOM  

- react
- react-dom
- babel-core 或 babel-register
- babel-preset-react
- jasmine

这部分依赖是在构建react和jasmine环境是要用到的，同时也是搭建Enzyme测试环境必须的依赖  

Jasmine似乎不支持ES6的一些语法(import)，所以在测试文件开头都要导入`babel-register`或`babel-core\register`进行语法的转码，而`babel-core\register`在Babel 7.x之后就从`babel-core`移除

![Jasmine的Enzyme测试环境依赖](./pic/enzyme/jasmine-enzyme-dependency.png)

## 配置
- babel setup
- enzyme setup
- jsdom setup
- style setup

这些配置都是在测试的前期准备，可以理解为`beforeEach`，通过创建相应的配置文件，配置到`jasmine.json`的`helpers`列表中即可  

同时这些配置文件的引入顺序也要按上述的顺序

### babel setup
引入babel对ES6的语法进行翻译

```javascript
// babel.setup.js
require("babel-register");
```
或
```javascript
// babel.setup.js
require("babel-core/register");
/*
"babel-core/register" is same as "babel-register"
Since Babel7.x, "register" was removed from "babel/core"
*/
```

### enzyme setup
配置Enzyme的React适配器  
在每个spec启动前加载jasmine-enzyme

```javascript
//enzyme.setup.js
import jasmineEnzyme from "jasmine-enzyme";
import { configure } from "enzyme";
import Adapter from "enzyme-adapter-react-16";

configure({ adapter: new Adapter() });

beforeEach(function() {
  jasmineEnzyme();
});
```

若不使用jasmine-enzyme，则只需要：
```javascript
//enzyme.setup.js
import { configure } from "enzyme";
import Adapter from "enzyme-adapter-react-16";

configure({ adapter: new Adapter() });
```
### jsdom setup
提供node的DOM环境，若没有DOM环境，enzyme的`mount`和`shallow`无法成功模拟react控件，测试启动会抛异常

```javascript
//jsdom.setup.js
import {JSDOM} from 'jsdom';

const dom = new JSDOM('<html><body></body></html>');
global.document = dom.window.document;
global.window = dom.window;
global.navigator = dom.window.navigator;
```

### style setup
对于Enzyme模拟的组件来说，真正去加载组件中的图片或CSS样式是比较消耗资源，也是没有必要的，因此有一些文件是必须被忽略掉的，否则

`ignore-styles`这么包可以忽略文件中导入的样式文件
> npm install --save-dev ignore-styles

在测试文件中直接导入该模块即可自动忽略CSS样式文件的加载
```javascript
import "ignore-styles";
```

### jasmine.json helpers
将所有setup文件依次添加到jasmine.json的helpers列表中

```json
{    
    "helpers": [
        "helper/babel.setup.js",
        "helper/enzyme.setup.js",
        "helper/jsdom.setup.js",
        "helper/*.js"
    ]
}
```

![helpers配置](./pic/enzyme/jasmine-enzyme-spec-setup.png)

## 使用Enzyme
在引入被测试的组件之前，必须向引入"react"
```javascript
import React from "react";
import { mount, shallow } from "enzyme";

import TodoList from "../../src/component/todo-list";

describe("todo list", () => {
  let wrapper = {};
  beforeEach(() => {
    wrapper = shallow(<TodoList />);
  });

  it("title", () => {
    //toHaveClassName 和 toHaveClassName 都是jasmine-enzyme的断言API
    expect(wrapper.find("header")).toHaveClassName("title");
    expect(wrapper.find("header")).toHaveText("Todo List");
  });
});
```

# 脚手架React项目使用enzyme测试
使用`create-react-app`搭建的项目需要将测试文件编写在src目录下，且以`.test.js`为后缀名  

`create-react-app`搭建的react项目默认使用Jest测试框架，要使用Enzyme是需要下载相关依赖：
> npm install --save enzyme enzyme-adapter-react-16 react-test-renderer

再在src目录下放置一个`setupTests.js`文件，类似jasmine的`enzyme.setup.js`:
```javascript
import { configure } from 'enzyme';
import Adapter from 'enzyme-adapter-react-16';

configure({ adapter: new Adapter() });
```

然后就可以使用enzyme的API进行测试了

# Link
### Github
FormidableLabs/enzyme-matchers/packages/jasmine-enzyme
https://github.com/FormidableLabs/enzyme-matchers/tree/master/packages/jasmine-enzyme  
jsdom/jsdom  
https://github.com/jsdom/jsdom
### Jasmine官网
Testing a React app with Jasmine npm  
https://jasmine.github.io/tutorials/react_with_npm
### Enzyme Document
https://airbnb.io/enzyme/
### Create React App Official
test  
https://facebook.github.io/create-react-app/docs/running-tests
