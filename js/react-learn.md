## react module
* react
* react-dom

## 对象和方法
### react
* ReactDOM
    1. render(component, DOMOnject): 将`component`插入到`DOMOnject`中
* React
    1. createElement(
          type,
          [props],
          [...children]
        )

## JSX语法
* 所有JSX编写的HTNL都是虚拟DOM的对象，且每个虚拟DOM的对象向都必须有一个根标签
* 在JSX中的JS代码必须放置在`{}`中，`{}`中若还有JSX代码，则其中的JS代码还需要继续加`{}`

## 创建组件
1. 工厂函数
    * 返回值的JSX标签
    * 方法名大写开头
    * 以`<方法名></方法名>`的形式应用
    * 函数有一个`props`参数
2. 组件类
    * 继承`React.component`
    * 重写`render`方法，返回JSX标签
3. ES5创建组件
    * 使用`React.createClass`

## React.Component
### 组件的三大属性 `props`, `refs`, `state`
### props
* 只读属性

### refs
* 用于引用真实的DOM对象
* 在需要绑定真实DOM的组件标签上添加`ref`属性，并指定一个名称
* 使用`this.refs.refName`可以获取指定`refName`绑定的真实DOM对象

### state
* 组件的内部数据状态，`state`的修改会触发组件的重新渲染
* 一般在`constructor`中对`state`进行初始化`this.state={...}`
* 只能使用`this,setState`方法对组件的`state`进行修改，方法的参数是一个对象
### 默认Props
```javascript
ClassName.defaultProps={
    ...
}
```

### Prop检验
限定组件可传入的prop的数据类型以及必要性
```javascript
import PropTypes from 'prop-types';

ClassName.propTypes = {
    optionalArray: PropTypes.array,
    optionalBool: PropTypes.bool,
    optionalNumber: PropTypes.number,
    optionalObject: PropTypes.object,
    optionalString: PropTypes.string,
    optionalMessage: PropTypes.instanceOf(Message),
    optionalEnum: PropTypes.oneOf(['News', 'Photos']),
    requiredFunc: PropTypes.func.isRequired,
    requiredAny: PropTypes.any.isRequired
}
```

### 事件机制
* 事件名称：驼峰命名法，`on`开头
* 事件参数：`event.target`表示触发事件的DOM对象

### 状态改变
react控件的状态和各种值是单向改变的，即无法通过在界面修改UI来修改虚拟DOM(除非`setState`)，如：
```javascript
class Controller extends React.Component{
  render(){
    let {msg} = this.state
    return (
      <div>
        <input type="text" value={msg}/>
        <input type="text" value="Hello"/>
      </div>
    )
  }
}
这里的两个输入框的值，是无法通过在页面进行输入来操作的，因此在输入框中输入但是页面是不会变化的，因为没有引起虚拟DOM的改变，因而页面不会自动渲染
```
