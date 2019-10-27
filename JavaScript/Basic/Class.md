# ES6 Class

## Link
- [阮一峰 - Class 的基本语法](http://es6.ruanyifeng.com/#docs/class)
- [阮一峰 - Class 的继承](http://es6.ruanyifeng.com/#docs/class-extends)

类的所有方法都定义在类的prototype属性上面

类的内部所有定义的方法，都是不可枚举的（non-enumerable）。

类的constructor方法默认返回实例对象（即this），也可以使用return指定返回另外一个对象。

类必须使用new调用，否则会报错。这是它跟普通构造函数的一个主要区别，后者不用new也可以执行。

在“类”的内部可以使用get和set关键字，对某个属性设置存值函数和取值函数，拦截该属性的存取行为。

定义“类”的方法的时候，前面不需要加上function这个关键字，直接把函数定义放进去了就可以了(`name(params){}`)

类的属性或方法名，可以采用表达式 `[variable]`。

与定义函数一样(声明式，表达式)，类也可以使用表达式的形式定义(`let name = class {...}`)。

采用 Class 表达式，可以写出立即执行的 Class(`let obj = new class{...}()`)。

类不存在变量提升（hoist），所以必须先定义，再使用

类的name属性总是返回紧跟在class关键字后面的类名

一个方法前，加上static关键字，就表示该方法不会被实例继承，而是直接通过类来调用，这就称为“静态方法”。

如果静态方法包含this关键字，这个this指的是类，而不是实例。

父类的静态方法，可以被子类继承。静态方法也是可以从super对象上调用的。

实例属性除了定义在constructor()方法里面的this上面，也可以定义在类的最顶层，先定义类的方法一样，使用`name = value` 的形式

对于类中定义的一个属性或方法，如果是使用 `=` 赋值，则会被定义为实例属性，若是 `name(){..}` 形式，则被定义为原型对象属性

在ES6中，类的静态属性只能在类定义之后定义，使用 `ClassName.property = value` 的方式，而无法再类内部声明；有提案建议使用 `statice property` 的形式在类内部定义静态属性

ES6 不提供私有方法和私有属性，一般通过约定下划线开头的变量为类的私有属性或方法；有提案建议使用 `#` 开头作为私有属性和方法

`new.target` 变量只能在函数中使用，当函数被当成构造方法调用时，它会执行这个函数本身，如果是作为普通函数调用，会返回 `undefined`

Class 可以通过 `extends` 关键字实现继承，子类会继承父类的所有属性和方法，包括静态属性和静态方法

子类必须在constructor方法中显示调用 `super` 方法，通过父类的构造方法继承属性和方法，初始化对象属性，这与java的继承是相似的

在子类的构造函数中，只有调用super之后，才可以使用this关键字

如果子类没有定义constructor方法，这个方法会被默认添加

Class 的继承是先初始化父类对象，再将父类对象作为原型对象创建子类对象

子类的原型对象指向一个父类的对象，即 `Object.getPrototypeOf(SubClass) === ParentClass`

`super` 在子类构造方法中当做父类构造方法使用时，返回的是子类的对象，实际调用类似于 `Parent.prototype.constructor.call(this)`

super作为对象时，在普通方法中，指向父类的原型对象；在静态方法中，指向父类。
