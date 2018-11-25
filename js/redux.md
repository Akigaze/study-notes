# Redux
## 相关模块
- redux
- react-redux

## Only Redux
#### 安装  
> npm install --save redux

#### 创建store
`createStore()` 是redux创建状态管理的store的API

`createStore(reducer, [preloadedState], [enhancer])` 需要作为 `reducer` 的函数作为参数，创建返回一个 `Store` 对象

```javascript
import {createStore} from "redux";
import countReducer from "./reducer/counter";
// 创建store
const store = createStore(countReducer)
```

#### Store 对象
`store` 用于管理，操纵整个应用的共享状态数据，有以下职责：
- 维持应用的 state；
- 提供 `getState()` 方法获取 state；
- 提供 `dispatch(action)` 方法更新 state；
- 通过 `subscribe(listener)` 注册监听器;
- 通过 `subscribe(listener)` 返回的函数注销监听器。

##### getState()
要获取store中存放应用状态数据的 `state` ，只能通过 `getState()` 方法获取state对象，而不能通过 `.` 访问属性的方式

```javascript
const store = createStore(countReducer)
let count = store.getState().count
```

##### dispatch(action)
发出一个 `action` ，触发reducer去更新state

通常action对象中会包含一个 `type` 属性，指明action的类型，可能还会有其他属性用于传递action相关的数据

dispatch 触发了reducer之后，`subscribe` 也会被触发

```javascript
store.dispatch({type:"INCREAMENT", percent: 10})
```

##### subscribe(listener)
订阅store的监听器，`listener`是一个函数，在每次 `reducer` 被触发返回state后，subscribe 的监听器也相应会被触发，此时 `listener` 会被执行

```javascript
//每次reducer被触发后，"root" div都会被重新渲染
store.subscribe(() => {
    ReactDOM.render(
        <App count={store.getState().count}/>,
        document.getElementById("root")
    )
});
```

## Reducer
用于响应action，管理、控制应用的state的模块，一般暴露一个用于响应action的函数，该函数的返回值将作为应用的state被store控制，在 `createStore` 和 `dispatch` 是都会执行该函数。

reducer函数的通常有两个参数，`state` 和 `action` ，通常会在参数列表中设置默认参数，避免空值的异常；同时 `state` 是一个只读的参数，不能直接对其修改属性再最为返回值

```javascript
// ./src/reducer/counter.js
export default const countReducer = (state = {}, action = {}) => {
    switch(action.type){
        case "INCREAMENT":
            return {count: state.count+1};
        case "DESCREAMENT":
            return {count: state.count-1};
        default: return state;
    }
}
```

### 个人对store的理解
#### createStore
```js
createStore(countReducer) =>
1. const store = enew Store()
2. store.setState(countReducer())
```

#### dispatch 和 subscribe
```js
store.subscribe(() => {renderApp()})
store.dispatch({type:"ADD", data:{...}}) =>
1. let preState = store.getState()
2. store.setState(countReducer(preState, {type:"ADD", data:{...}}))
3. renderApp()
```

### Example 1:Counter only with Redux
#### project structure
```js
- src
  - reducer
    - counter.js
  - app.js
  - index.js
```

#### src/index.js
```javascript
import React from "react";
import ReactDOM from "react-dom";
import {createStore} from "redux";
import countReducer from "./reducer/counter";
import App from "./App";

const store = createStore(countReducer)
store.subscribe(() => {renderApp()});

const renderApp = () => {
    ReactDOM.render(
        <App onIncrease={() => {store.dispatch({type:"INCREAMENT"})}}
             onDecrease={() => {store.dispatch({type:"DECREaMENT"})}}
             count={store.getState().count}/>,
        document.getElementById("root")
    );
}
renderApp();
```

#### src/reducer/counter.js
```javascript
const initialState = {count:0}

export default const countReducer = (state = initialState, action = {}) => {
    let {type} = action;
    switch(type){
        case "INCREAMENT":
            return {count: state.count+1};
        case "DECREAMENT":
            return {count: state.count-1};
        default: return state;
    }
}
```

#### src/app.js
```javascript
import React, { Component } from "react";

export default class App extends Component {
    render() {
        let {count, onIncrease, onDescrease} = this.props;
        return (
            <div className="container">
                <h1 className="jumbotron-heading text-center">{count}</h1>
                <p className="text-center">
                    <button onClick={onIncrease} className="btn btn-primary mr-2">Increase</button>
                    <button onClick={onDescrease} className="btn btn-danger mr-2">Decrease</button>
                </p>
            </div>
        );
    }
}
```

------------------
# Link

### Official Site
EN Offical  
https://redux.js.org/  
CN Offical  
https://cn.redux.js.org/  
### egghead.io
Video : Getting Started with Redux  
https://egghead.io/courses/getting-started-with-redux  
Video : Building React Applications with Idiomatic Redux  
https://egghead.io/courses/building-react-applications-with-idiomatic-redux 
### 阮一峰
Redux 入门教程（一）：基本用法  
http://www.ruanyifeng.com/blog/2016/09/redux_tutorial_part_one_basic_usages.html  
Redux 入门教程（二）：中间件与异步操作  
http://www.ruanyifeng.com/blog/2016/09/redux_tutorial_part_two_async_operations.html  
Redux 入门教程（三）：React-Redux 的用法  
http://www.ruanyifeng.com/blog/2016/09/redux_tutorial_part_three_react-redux.html  
