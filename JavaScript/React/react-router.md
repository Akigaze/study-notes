# React Router



## Link

- [React Router Training](<https://reacttraining.com/react-router/>)
- [History of React Router](<https://github.com/ReactTraining/history>)
- [CSDN - react-router和react-router-dom的区别](<https://blog.csdn.net/weixin_37242696/article/details/80738392>)
- [[React Router 中文文档](https://github.com/react-guide/react-router-cn)](<https://react-guide.github.io/react-router-cn/index.html>)



## 一、react-router vs. react-router-dom

**react-router** 提供了react路由相关的基础功能和组件，包括 `Link`, `Router`, `Route`, `Switch` 等，而 **react-router-dom** 是在 **react-router** 的基础上进一步封装，加入了许多跟 web 开发相关的特性和组件，如 `BrowsweRouter`, `NavLink`, `HashRouter` 等；所以在开发web应用的话，通常只需导入 **react-router-dom** 就可以了

> `react-router-dom` 依赖 `react-router`，所以我们使用 `npm` 安装依赖的时候，只需要安装相应环境下的库即可，不用再显式安装 `react-router`。基于浏览器环境的开发，只需要安装 `react-router-dom`；基于 `react-native` 环境的开发，只需要安装 `react-router-native`。`npm` 会自动解析 `react-router-dom` 包中 `package.json` 的依赖并安装。



## 二、react-router 

### 1. 组件

#### 1.1 \<Router>

react-router 中提供的 `Router` 组件是最基础的，在此基础上还有许多高级的实现：

- BrowserRouter
- HashRouter
- MemoryRouter
- NativeRouter
- StaticRouter

`Router` 的作用更类似与 `Route` 和 `history` 的管理。它有两个属性：

- `children`
- `history` : 使用 `react-router` 所依赖的 `history` 包中提供的方法创建的history对象；该属性的值会通过 `children` 中的 `<Route>` 组件传递给UI组件

```javascript
import { Router } from "react-router";
import { createBrowserHistory } from "history";

const history = createBrowserHistory();

<Router history={history}><App /></Router>
```



#### 1.2 \<Route>

> Its most basic responsibility is to render some UI when its `path` matches the current URL.

`Route` 组件可以在当其 `path` 属性指定的 url path与当前url相匹配使，渲染器定义的UI元素；`Route` 可以通过3中方式渲染UI:

- `component` 属性 :  func， 每次path 匹配中就回渲染一次，`component={User}`
- `render` 属性 : func，每次path匹配中就会渲染一次 `render={() => <div>Home</div>}`
- `children` 属性 : func，不论 `Route` 的path是否match都会渲染，且每次页面的url有变化他都会重新渲染一遍； `children={({ match, ...rest }) => <Animate>{match && <Something {...rest}/>}</Animate>}`

这3中方式渲染的组件都能从 `Route` 接收到 `match`, `location` 和 `history` 3个 props

还有一种方式是将UI作为 `Route` 的子组件，此时子组件只有在path匹配的情况下才会渲染，且不会重复渲染；当path不匹配时组件卸载；当时这种方式的子组件无法接收 `Route` 的props

**属性：**

- `compinent`, `render`, `children`
- `path` : string 或 [string] ，当没有指定path属性时，该 Route 会一直匹配url； 使用 `:name` 做路径参数；定义规则参考 [`path-to-regexp`](https://github.com/pillarjs/path-to-regexp/tree/v1.7.0)
- `exact` : bool, 是否精确匹配，默认为false，即只要 path匹配url开头的一部分就行
- `strict` : bool，限定path结尾要有斜杠`/`的匹配规则
- `sensitive` ：bool，path大小写敏感
- `location` : 存放跟当前页面相关的信息，path 通常就是和 `location.pathname` 比较是否匹配的 



#### 1.3 \<Switch>

在没有 `Switch` 管理 `Route` 的情况下，所有path匹配的 `Route` 都会被渲染出来，而 `Switch` 可以管理这些 `Route` ，只有第一个匹配的才会渲染

> `<Switch>` is unique in that it renders a route *exclusively*. In contrast, every `<Route>` that matches the location renders *inclusively*. 

**属性：**

- `location` 属性: 与 `Route` 的 `location` 相似，当设置了该属性后，他会相应的传给子组件
- `children` 组件：`Switch` 的子组件只能是 `Route` 或 `Redirect` ，当子组件的 path 或 from  属性匹配时，给子组件就会被渲染



#### 1.4 \<Redirect>

> Rendering a `<Redirect>` will navigate to a new location. The new location will override the current location in the history stack

`Redirect` 没有UI的内容，当一个 `Redirect` 组件被渲染时，他会直接修改浏览器路径到指定路径(`to`) 

**属性：**

- `to` : string|object , 当使用 object时表示传递一个 `location` 对象
- `from` : 类似于 `Route` 的path属性，用于匹配当前url决定是否渲染该组件；当 `to` 使用了路径参数，则 `from` 也只能包含着相同的路径参数
- `push`: bool, 是否替换 `history` 的当前节点
- `exact`, `strict`, `sensitive`



#### 1.5 \<StaticRouter>

这种路由组件的 `location` 是固定不变的；常用于服务端，服务端将react的js代码返回到前端



#### 1.6 \<MemoryRouter>

这种路由组件会将 `history` 的url 保存在内存，而不是浏览器的地址栏；所以更多的是用于非浏览器的环境



#### 1.7 \<Link>

用于不同的url跳转，该组件会被解释成一个 `a` 标签

**属性：**

- `to` 属性： 要跳转的目标，可以是一个 path 字符串，或者是 location 对象，或者是一个接受当前location返回新location的函数
- `replace` 属性 : bool, 是否直接将目标location替换当前history中的节点
- 其他任何可以添加在 `a` 标签上的属性



#### 1.8 \<Prompt>



### 2. 属性props

#### 2.1 location

`location` 的属性大致如下，通过 `history.location` 也可以获取该对象，但是 `history` 通常是变化的，所以多数情况下还是直接使用较稳定的 `location` 对象

```js
{
  key: 'ac3df4', // not with HashHistory!
  pathname: '/somewhere',
  search: '?some=search-string',
  hash: '#howdy',
  state: {
    [userDefined]: true
  }
}
```



#### 2.2 history

`react-router` 的 history 依赖于[History of React Router](<https://github.com/ReactTraining/history>)

包括了如下 **属性** 和 **方法**：

- `length` - (number) The number of entries in the history stack
- `action` - (string) The current action (`PUSH`, `REPLACE`, or `POP`)
- `location` - (object) The current location. May have the following properties:
  - `pathname` - (string) The path of the URL
  - `search` - (string) The URL query string
  - `hash` - (string) The URL hash fragment
  - `state` - (object) location-specific state that was provided to e.g. `push(path, state)` when this location was pushed onto the stack. Only available in browser and memory history.
- `push(path, [state])` - (function) Pushes a new entry onto the history stack
- `replace(path, [state])` - (function) Replaces the current entry on the history stack
- `go(n)` - (function) Moves the pointer in the history stack by `n` entries
- `goBack()` - (function) Equivalent to `go(-1)`
- `goForward()` - (function) Equivalent to `go(1)`
- `block(prompt)` - (function) Prevents navigation (see [the history docs](https://github.com/ReactTraining/history#blocking-transitions))

有与 `history` 属性是不稳定的，随页面变化而变动，所以在获取页面的 `location` 信息时，通常不用 `history.location` ,而是直接用 `location` 属性



#### 2.3 match

`mathc` 属性通常记录了一个 `Route` 组件匹配 url 的情况，包含以下 **属性：**

- `params` - (object) Key/value pairs parsed from the URL corresponding to the dynamic segments of the path
- `isExact` - (boolean) `true` if the entire URL was matched (no trailing characters)
- `path` - (string) The path pattern used to match. Useful for building nested `<Route>`s
- `url` - (string) The matched portion of the URL. Useful for building nested `<Link>`s

若 `Route` 使用 `children` 属性添加UI部分，则不论path 是否匹配url，都会渲染UI的部分，当path不匹配时，传递给UI组件的 `match` 的值会是 `null`

### 3. hook 方法







## 三、react-router-dom 

### 1. 组件

#### 1.1 \<BrowserRouter>

对 `<Router>` 组件的封装，基于浏览器的 `history` 实现的路由，无需手动传递 `history` 属性

**属性：**

- `basename` : 类似于Spring controller 加在类上的RequestMapping 注解

- `getUserConfirmation` : 

  ```js
  getUserConfirmation={(message, callback) => {
      // this is the default behavior
      const allowTransition = window.confirm(message);
      callback(allowTransition);
  }}
  ```

- `forceRefresh` : bool
- `keyLength` : number，限定 `location.key` 的长度，默认是 6



#### 1.2 \<HashRouter>

类似于 `BrowserRouter`，只是它不支持 `location.key` 和 `location.state`

**属性：**

- `hashType` : **slash** | **noslash** | **hashbang**



#### 1.3 \<NavLink>

`Link` 的升级版，可以在 `to` 指定的path与url匹配时渲染指定的样式

**属性：**

- `activeClassName`
- `activeStyle`
- `isActive` : func, 在每次url有变化时执行，可以自定义该组件path匹配的规则：`(match, location) => {}`
- `location` 

## 四、history 管理

