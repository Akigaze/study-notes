

# 多进程

python 提供了 `multiprocessing` 模块实现跨平台的多进程操作，而配合 `os` 模块也可以获取当系统中进程的信息

## `multiprocessing` 模块

 `multiprocessing` 模块提供了基本的 `Process` 类用于创建进程，`Pool` 类使用进程池的方式管理进程，`Queue`，`Pipes` 类用于进程之间的数据通信

### 1. Process 进程类

一个 `Process` 的对象就是一个进程，可以在创建进程的进程中，通过 `Process` 对象操纵创建的进程，相当于子进程

#### 创建 Process 对象

`Process(group=None, target=None, name=None, args=(), kwargs={})` 

- `target` 参数是一个函数，会在进程启动时执行
- `args` 是一个参数的tuple，在进程启动时，这些参数会被传入 `target` 指定的方法中，作为方法的参数

####  Process 对象方法

- `.start()` : 启动进程，此时多个进程将会 **异步** 执行
- `.join()` : 父进程等待子进程 (调用该方法的进程) 的执行，直到子进程结束，可以实现进程的 **同步**



### 2. Pool 进程池

Pool用于统一创建管理进程

#### 创建进程池

`Pool(processes=None, initializer=None, initargs=(), maxtasksperchild=None, context=None)`

- `processes` 参数表示最大进程的数量，默认状态是CPU的核数

#### 线程池对象方法

- `.apply_async(func, args=(), kwds={}, callback=None, error_callback=None)` : 异步的方法创建进程，当达到最大进程数时，创建的进程无法继续添加到进程池中，只有当某一个进程结束被销毁时，才会进行添加进程
  - `func` 当进程被添加到进程池中时会被调用，将 `args` 参数中的元素作为参数
- `.close()` : 关闭进程池，禁止添加进程的操作
- `.join()` : 与 `Process` 对象的 `join` 相同，让当前进程等待进程池中的所有进程执行结束



### 3. Queue 子进程通信队列

`multiprocessing` 模块提供了 `Queue` 这一数据结构，实现不同进程之间的通信，不同的进程可以向队列中写入数据，或者读取数据

#### 创建 Queue

直接调用无参构造方法创建队列

#### 队列的方法

- `put` 添加数据
- `get` 读取数据



## `subprocess` 模块

`subprocess` 模块提供了控制自进程输入和输出的一系列方法



# 多线程

python 提供了 `threading`  模块和 `_thread` 模块用于线程的操作， `_thread`  是一个相对底层的实现，而 `threading`  是对 `_thread` 的封装，相对高级，一般用 `threading`

## threading 模块

#### 模块方法

- `current_thread()` 获取当前线程的 `Thread` 对象 
- `local()` 获取一个 `ThreadLocal` 对象



### 1. Thread 类

`Thread` 类用于创建线程和对线程进行操作

#### 创建线程

`Thread(group=None, target=None, name=None, args=(), kwargs=None, *, daemon=None)` 

- `target` 参数与 `Process` 类的target参数相似，都是一个在线程启动是会执行的方法，参数为 `args` 参数中的元素
- `name` 为线程的名称，不指定的情况下会自动分配名称 `Thread-1`，`Thread-2` 的形式

#### 线程的属性

- `name` 线程的名称，主线的名称默认为 **MainThread**

#### 线程的方法

- `.start()` 启动线程
- `.join()` 等待调用的线程知道线程销毁为止



### 2. Lock 资源锁

`threading` 模块中的 `Lock` 类提供了多线程下资源加锁的方法，一个锁只能有一个线程持有，没有获得锁的线程无法继续执行锁之后的代码，或者范围锁之后所使用到的资源，知道锁被释放为止，线程才会继续争夺锁

一般锁住的资源会放到 `try...finally...` 中，在`try` 之前获取锁，在 `finally` 代码块中释放锁 

#### 创建锁对象

直接使用无参构造方法

#### 锁的方法

- `.acquire()` 获取锁
- `.locked()`
- `.release()` 释放锁



### 3. ThreadLocal 线程局部资源

`threading` 模块中的 `ThreadLocal` 类，可以只使用一个对象，为每个线程单独管理他们的局部资源

#### 创建对象

使用 `threading.local()` 方法获取一个 `ThreadLocal` 对象

#### 添加局部变量

`ThreadLocal` 对象使用 **对象.属性** 的方式，为线程添加局部变量，每个线程所要用到的局部变量，可以动态设置为 `ThreadLocal` 对象的属性， `ThreadLocal` 对象会自动为不同的线程管理他们各自的局部变量，即使多个线程有同名的局部变量，也不会混淆 