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

## Reducer
Reducer 指定了应用状态的变化如何响应 `actions` 并发送到 `store` 的，而 `actions` 只是描述了有事情发生了这一事实，并没有描述应用如何更新 `state`。

### 设计 State 结构
在 Redux 应用中，所有的 state 都被保存在一个单一对象中。在写代码前先想一下这个对象的结构。

通常，state 树需要存放应用相关的数据，以及一些 UI 相关的 state，但尽量把这些数据与 UI 相关的 state 分开。
```javascript
{
  visibilityFilter: "SHOW_ALL",
  todos: [
    {
      text: "Consider using Redux",
      completed: true,
    },
    {
      text: "Keep all state in a single tree",
      completed: false
    }
  ]
}
```

### Action 处理
reducer 就是一个纯函数，接收旧的 state 和 action，返回新的 state。
```javascript
const rerducer = (previousState, action) => newState
```

保持 reducer 纯净非常重要。永远不要在 reducer 里做这些操作：
- 修改传入参数；
- 执行有副作用的操作，如 API 请求和路由跳转；
- 调用非纯函数，如 `Date.now()` 或 `Math.random()`。


```javascript
import {
  ADD_TODO,
  TOGGLE_TODO,
  SET_VISIBILITY_FILTER,
  VisibilityFilters
} from "./actions";
//初始状态的 state
const initialState = {
  visibilityFilter: VisibilityFilters.SHOW_ALL,
  todos: []
};
// 使用默认参数为 state 赋予默认值
function todoApp(state = initialState, action) {
  switch (action.type) {
    case SET_VISIBILITY_FILTER:
      return Object.assign({}, state, {
        visibilityFilter: action.filter
      });
    case ADD_TODO:
      return Object.assign({}, state, {
        todos: [
          ...state.todos,
          {
            text: action.text,
            completed: false
          }
        ]
      });
    case TOGGLE_TODO:
      return Object.assign({}, state, {
        todos: state.todos.map((todo, index) => {
          if (index === action.index) {
            return Object.assign({}, todo, {
              completed: !todo.completed
            });
          }
          return todo;
        })
      });
    default:
      return state;
  }
}
```

**注意:**

1. 不要修改 state。 使用 `Object.assign()` 新建了一个副本。不能这样使用 `Object.assign(state, { visibilityFilter: action.filter })`，因为它会改变第一个参数的值。你必须把第一个参数设置为空对象。你也可以开启对 ES7 提案对象展开运算符的支持, 从而使用 `{ ...state, ...newState }` 达到相同的目的。
2. 在 default 情况下返回旧的 state。遇到未知的 action 时，一定要返回旧的 state。

我们需要修改数组中指定的数据项时，不希望导致突变, 因此我们的做法是在创建一个新的数组后, 将那些无需修改的项原封不动移入, 接着对需修改的项用新生成的对象替换。

### 拆分 Reducer
```javascript
// 新建，更新TODO
function todos(state = [], action) {
  switch (action.type) {
    case ADD_TODO:
      return [
        ...state,
        {
          text: action.text,
          completed: false
        }
      ]
    case TOGGLE_TODO:
      return state.map((todo, index) => {
        if (index === action.index) {
          return Object.assign({}, todo, {
            completed: !todo.completed
          })
        }
        return todo
      })
    default:
      return state
  }
}
// 处理action
function todoApp(state = initialState, action) {
  switch (action.type) {
    case SET_VISIBILITY_FILTER:
      return Object.assign({}, state, {
        visibilityFilter: action.filter
      })
    case ADD_TODO:
      return Object.assign({}, state, {
        todos: todos(state.todos, action)
      })
    case TOGGLE_TODO:
      return Object.assign({}, state, {
        todos: todos(state.todos, action)
      })
    default:
      return state
  }
}
```

现在 `todoApp()` 只把需要更新的一部分 `state` 传给 `todos()` 函数，`todos()` 函数自己确定如何更新这部分数据。这就是所谓的 **reducer 合成**，它是开发 Redux 应用最基础的模式。

**reducer 拆分与合成**
将todoList分成管理数据和显示的两个reducer

每个 reducer 只负责管理全局 state 中它负责的一部分。每个 reducer 的 state 参数都不同，分别对应它管理的那部分 state 数据。
```javascript
// 管理todo数据列表，全局的state中的数据
function todos(state = [], action) {
  switch (action.type) {
    case ADD_TODO:
      return [
        ...state,
        {
          text: action.text,
          completed: false
        }
      ]
    case TOGGLE_TODO:
      return state.map((todo, index) => {
        if (index === action.index) {
          return Object.assign({}, todo, {
            completed: !todo.completed
          })
        }
        return todo
      })
    default:
      return state
  }
}
// 管理显示的列表内容，全局的state中的显示设置
function visibilityFilter(state = SHOW_ALL, action) {
  switch (action.type) {
    case SET_VISIBILITY_FILTER:
      return action.filter
    default:
      return state
  }
}
// 合并reducer，持有全局的state
function todoApp(state = {}, action) {
  return {
    visibilityFilter: visibilityFilter(state.visibilityFilter, action),
    todos: todos(state.todos, action)
  }
}
```

Redux 提供了 `combineReducers()` 工具类来做上面 todoApp 做的事情，这样就能消灭一些样板代码了。有了它，可以这样重构 todoApp：
```javascript
import { combineReducers } from 'redux'

export default const todoApp = combineReducers({
  visibilityFilter,
  todos
})
```

`combineReducers()` 所做的只是生成一个函数，这个函数来调用你的一系列 reducer，每个 reducer 根据它们的 `key` 来筛选出 `state` 中的一部分数据并处理，然后这个生成的函数再将所有 reducer 的结果合并成一个大的对象。没有任何魔法。正如其他 reducers，如果 `combineReducers()` 中包含的所有 reducers 都没有更改 `state`，那么也就不会创建一个新的对象。

```javascript
const reducer = combineReducers({
  todos,
  visibilityFilter
})
```

`combineReducers` 会生成一个大的state，这个state的 `key` 就是其参数对象的key，执行 `dispatch` 时，每个key对应那部分 `state` 的数据会传入对应的reducer函数中
```javascript
const bigState = {
  todos : todo(),
  visibilityFilter : visibilityFilter()
}
const bigReducer = (state = bigState, action={}) = >{
  return {
    todos : todo(state.todos, action),
    visibility : visibility(state.visibilityFilter, action)
  }
}
```
## Store
Store 是把 `action`，`reducers` 和 `state` 联系到一起的对象。

Store 有以下职责：

- 维持应用的 state；
- 提供 `getState()` 方法获取 state；
- 提供 `dispatch(action)` 方法更新 state；
- 通过 `subscribe(listener)` 注册监听器;
- 通过 `subscribe(listener)` 返回的函数注销监听器。

 Redux 应用只有一个单一的 store，当需要拆分数据处理逻辑时，你应该使用 reducer 拆分组合 而不是创建多个 store。

使用 `combineReducers()` 将多个 reducer 合并成为一个 reducer ，再通过 `createStore()` 将这个 reducer 作为参数来创建 store 。
```javascript
import { createStore } from 'redux'
import todoApp from './reducers'
let store = createStore(todoApp)
```

`createStore()` 的第二个参数是可选的, 用于设置 state 初始状态。这对开发 `同构应用` 时非常有用，服务器端 redux 应用的 state 结构可以与客户端保持一致, 那么客户端可以将从网络接收到的服务端 state 直接用于本地数据初始化。

```javascript
let store = createStore(todoApp, window.STATE_FROM_SERVER)
```

### 发起 Actions
使用 `dispatch` 函数，传入一个作为 action 的对象可以发起一个Action

`subscribe` 函数会接受一个 `listener` 处理函数，监听action的发生，每次action处理之后，会执行 `listener` 处理函数；同时 `subscribe` 函数会返回一个注销监听器，执行该注销监听器可以终止监听


```javascript
import {
  addTodo,
  toggleTodo,
  setVisibilityFilter,
  VisibilityFilters
} from './actions'

// 打印初始状态
console.log(store.getState())

// 每次 state 更新时，打印日志
// 注意 subscribe() 返回一个函数用来注销监听器
const unsubscribe = store.subscribe(() => console.log(store.getState()))

// 发起一系列 action
store.dispatch(addTodo('Learn about actions'))
store.dispatch(addTodo('Learn about reducers'))
store.dispatch(addTodo('Learn about store'))
store.dispatch(toggleTodo(0))
store.dispatch(toggleTodo(1))
store.dispatch(setVisibilityFilter(VisibilityFilters.SHOW_COMPLETED))

// 停止监听 state 更新
unsubscribe()
```
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
`store` 用于管理，操纵整个应用的共享状态数据，有以下API：
- `getState()`
- `dispatch(action)`
- `subscribe(listener)`
- `subscribe(listener)`

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
