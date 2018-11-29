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

### 异步 Action
当调用异步 API 时，有两个非常关键的时刻：发起请求的时刻，和接收到响应的时刻（也可能是超时）。

这两个时刻都可能会更改应用的 `state`；一般情况下，每个 API 请求都要考虑 `dispatch` 至少三种 action：
- 通知 reducer 请求开始的 action：
对于这种 action，reducer 可能会切换一下 state 中的 `isFetching` 标记。以此来告诉 UI 来显示加载界面。
- 通知 reducer 请求成功的 action：
对于这种 action，reducer 可能会把接收到的新数据合并到 state 中，并重置 `isFetching` 。UI 则会隐藏加载界面，并显示接收到的数据。
- 通知 reducer 请求失败的 action：
对于这种 action，reducer 可能会重置 `isFetching` 。另外，有些 reducer 会保存这些失败信息，并在 UI 里显示出来。

为了区分这三种 action，可能在 action 里添加一个专门的 `status` 字段作为标记位：
```javaScript
{ type: 'FETCH_POSTS' }
{ type: 'FETCH_POSTS', status: 'error', error: 'Oops' }
{ type: 'FETCH_POSTS', status: 'success', response: { ... } }
```

又或者为它们定义不同的 type：
```javaScript
{ type: 'FETCH_POSTS_REQUEST' }
{ type: 'FETCH_POSTS_FAILURE', error: 'Oops' }
{ type: 'FETCH_POSTS_SUCCESS', response: { ... } }
```

#### 异步 action 创建函数
thunk action 创建函数

```javaScript
import fetch from 'cross-fetch'

export const REQUEST_POSTS = 'REQUEST_POSTS'
function requestPosts(subreddit) {
  return {
    type: REQUEST_POSTS,
    subreddit
  }
}

export const RECEIVE_POSTS = 'RECEIVE_POSTS'
function receivePosts(subreddit, json) {
  return {
    type: RECEIVE_POSTS,
    subreddit,
    posts: json.data.children.map(child => child.data),
    receivedAt: Date.now()
  }
}

 export const INVALIDATE_SUBREDDIT = ‘INVALIDATE_SUBREDDIT’
 export function invalidateSubreddit(subreddit) {
   return {
     type: INVALIDATE_SUBREDDIT,
     subreddit
   }
 }

//带异步请求的action函数
export function fetchPosts(subreddit) {
  //这里把 dispatch 方法通过参数的形式传给函数，以此来让它自己也能 dispatch action。
  return function (dispatch) {
    //首次 dispatch：更新应用的 state 来通知 API 请求发起了。
    dispatch(requestPosts(subreddit))

    return fetch(`http://www.subreddit.com/r/${subreddit}.json`)
      .then(
        response => response.json(),
        error => console.log('An error occurred.', error)
      )
      .then(json =>
        //可以多次 dispatch！ 这里使用 API 请求结果来更新应用的 state。
        dispatch(receivePosts(subreddit, json))
      )
  }
}
```

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
const bigReducer = (preState = bigState, action={}) = >{
  let nextTodos = todo(preState.todos, action);
  let nextVisibility = visibility(preState.visibilityFilter, action);
  return {
    todos : nextTodos,
    visibility : nextVisibility
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

## 数据的生命周期
1. 调用 `store.dispatch(action)`
2. Redux store 调用传入的 reducer 函数，把当前的 `state` 树和 `action` 传入 reducer，返回下一个 state
3. 根 reducer 应该把多个子 reducer 输出合并成一个单一的 state 树
4. Redux store 保存了根 reducer 返回的完整 state 树，通过 `getState` 函数获取完整的 state

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

### Reducer
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

-----------------

# React Redux
相关模块：
- redux
- react-redux

安装：
> npm install --save react-redux

## 容器组件（Smart/Container Components）和展示组件（Dumb/Presentational Components）

|                  |展示组件                |容器组件|
|:-|:-|:-|
|**作用**          |描述如何展现（骨架、样式）|描述如何运行（数据获取、状态更新）|
|**直接使用 Redux**|否                      |是|
|**数据来源**      |props                   |监听 Redux state|
|**数据修改**      |从 props 调用回调函数    |向 Redux 派发 actions|
|**调用方式**      |手动                    |通常由 React Redux 生成 |

从技术上讲可以直接使用 `store.subscribe()`
来编写容器组件。但不建议这么做的原因是无法使用 React Redux 带来的性能优化。也因此，不要手写容器组件，而使用 React Redux 的 `connect()` 方法来生成。

### 展示组件
只定义外观并不关心数据来源和如何改变的组件。传入什么就渲染什么。如果你把代码从 Redux 迁移到别的架构，这些组件可以不做任何改动直接使用。它们并不依赖于 Redux。

### 容器组件
监听 Redux store 变化并处理如何过滤出要显示的数据

#### 使用 connect 创建容器组件
使用 `connect()` 前，需要先定义 `mapStateToProps` 这个函数来指定如何把当前 Redux store state 映射到展示组件的 `props` 中，处理直接将store state 中的属性映射到 组件的 props 以外， 也可以添加一些计算逻辑，会去 store state 计算后的结果作为组件的 prop

`mapStateToProps` 函数的参数是 store 的完整 state

```javascript
// 获取prop的逻辑
const getVisibleTodos = (todos, filter) => {
  switch (filter) {
    case 'SHOW_COMPLETED':
      return todos.filter(t => t.completed)
    case 'SHOW_ACTIVE':
      return todos.filter(t => !t.completed)
    case 'SHOW_ALL':
    default:
      return todos
  }
}
// props 映射 store state
const mapStateToProps = state => {
  return {
    todos: getVisibleTodos(state.todos, state.visibilityFilter)
  }
}
```

定义 `mapDispatchToProps()` 方法接收 `dispatch()` 方法并返回期望注入到展示组件的 props 中的回调方法，即绑定了 dispatch 的行为相关的props

 `mapDispatchToProps()` 函数的参数是 store 对象的 `dispatch` 方法

```javascript
const mapDispatchToProps = dispatch => {
  return {
    onTodoClick: id => {
      dispatch(toggleTodo(id))
    }
  }
}
```

使用 `connect()` 创建已有展示组件的容器组件，`connect()`以`mapStateToProps`和`mapDispatchToProps`为参数，返回一个新的函数，该新函数接受一个容器组件的 `构造器` 为参数，返回与容器组件同名的 容器组件

```javascript
import { connect } from 'react-redux'
import React, {Component} from 'react'
export class VisibleTodoList extends Component {
    ...
}

const VisibleTodoList = connect(mapStateToProps, mapDispatchToProps)(TodoList)
export default VisibleTodoList
//export default connect(mapStateToProps, mapDispatchToProps)(TodoList)
```

有了容器组件之后，要讲store传入组件中才能使组件正常工作，一种方式是把store以 `props` 的形式传入到所有容器组件中。

redux官方推荐使用React Redux 组件 `<Provider>` 来 魔法般的 让所有容器组件都可以访问 store，而不必显式地传递它。只需要在渲染根组件时使用即可。

```javaScript
import React from 'react'
import { render } from 'react-dom'
import { Provider } from 'react-redux'
import { createStore } from 'redux'
import todoApp from './reducers'
import App from './components/App'

let store = createStore(todoApp)

render(
  <Provider store={store}>
    <App />
  </Provider>,
  document.getElementById('root')
)
```

------------------
# Link

### Official Site
EN Offical  
https://redux.js.org/  
CN Offical  
https://cn.redux.js.org/  
React redux  
https://react-redux.js.org/  
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
