# Redux
## 相关模块
- redux
- react-redux

## Introduce
### 动机
JavaScript 的 `state` (状态)包括服务器响应、缓存数据、本地生成尚未持久化到服务器的数据，也包括 UI 状态，如激活的路由，被选中的标签，是否显示加载动效或者分页器等等。  

state 管理的复杂性很大程度上来自于：我们总是将两个难以理清的概念混淆在一起：变化和异步。 我称它们为`曼妥思和可乐`。一些库如 `React` 试图在视图层禁止异步和直接操作 DOM 来解决这个问题。美中不足的是，`React` 依旧把处理 state 中数据的问题留给了你。

Redux 试图让 `state` 的变化变得可预测.

### 核心概念
- state: 用普通对象来描述应用的 state ，而且通常没有修改器方法
- action: action 就像是描述发生了什么的指示器
- reducer: reducer 只是一个接收 state 和 action，并返回新的 state 的函数

### 三大原则
#### 单一数据源
整个应用的 state 被储存在一棵 object tree 中，并且这个 object tree 只存在于唯一一个 store 中。

#### State 是只读的
唯一改变 state 的方法就是触发 `action`，`action` 是一个用于描述已发生事件的普通对象。

#### 使用纯函数来执行修改
为了描述 action 如何改变 state tree ，你需要编写 `reducers`。

Reducer 只是一些纯函数，它接收先前的 `state` 和 `action`，并返回新的 state。

### 先驱技术
- Flux
- Elm
- Immutable
- Baobab
- RxJS

## Action
Action 是把数据从应用传到 `store` 的有效载荷。它是 store 数据的唯一来源。一般来说你会通过 `store.dispatch()` 将 action 传到 store。
```javascript
// example of Action
{
  type: ADD_TODO,
  text: 'Build my first Redux app'
}
```

Action 本质上是 JavaScript 普通对象。我们约定，action 内必须使用一个字符串类型的 `type` 字段来表示将要执行的动作。多数情况下，`type` 会被定义成字符串常量。当应用规模越来越大时，建议使用单独的模块或文件来存放 action。
```javascript
// when create action
import { ADD_TODO, REMOVE_TODO } from '../actionTypes'

// actionTypes.js
export const ADD_TODO = "ADD_TODO";
export const REMOVE_TODO = "REMOVE_TODO";
```

#### action index
这时，我们还需要再添加一个 `action index` 来表示用户完成任务的动作序列号。因为数据是存放在数组中的，所以我们通过下标 `index` 来引用特定的任务。而实际项目中一般会在新建数据的时候生成唯一的 ID 作为数据的引用标识。

即redux会通过action对象中的 `index` 属性来指代特定的任务和数据，而不是直接吧数据写着action中
```javascript
{
  type: TOGGLE_TODO,
  index: 5
}
```

我们应该尽量减少在 action 中传递的数据。比如上面的例子，传递 index 就比把整个任务对象传过去要好。

最后，再添加一个 `action type` 来表示当前的任务展示选项。
```javascript
{
  type: SET_VISIBILITY_FILTER,
  filter: SHOW_COMPLETED
}
```

### Action 创建函数
Action 创建函数 就是生成 action 的方法。在 Redux 中的 action 创建函数只是简单的返回一个 action:
```javascript
function addTodo(text) {
  return {
    type: ADD_TODO,
    text
  }
}
```

只要把action相关的数据传给 action 创建函数，再将 action 创建函数的结果传给 `dispatch()` 方法即可发起一次 dispatch 过程。
```javascript
dispatch(addTodo(text))
dispatch(completeTodo(index))
```

或者创建一个 `与dispatch绑定的 action 创建函数` 来自动 dispatch, 然后直接调用这个函数：
```javascript
// dispatch binding action creating function
const boundAddTodo = text => store.dispatch(addTodo(text))
const boundCompleteTodo = index => store.dispatch(completeTodo(index))
// call them
boundAddTodo(text);
boundCompleteTodo(index);
```
在开发react应用时，通常会使用 `react-redux` 提供的 `connect()` 帮助器来调用dispatch。`bindActionCreators()` 可以自动把多个 action 创建函数 绑定到 dispatch() 方法上。


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
