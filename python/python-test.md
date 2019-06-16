# Test

## 1. unittest

python 内置了 `unittest` 模块提供了基本的单元测试的功能

- 所有单元测试要写在类里面，作为类的方法
- 测试类要继承 `unittest.TestCase` 类
- 每个测试方法的命名要以 **test_** 开头，这样才能被识别为一个测试

#### 断言

 `unittest.TestCase` 类提供了许多断言的方法，调用时要是用 `self.` 的形式

- `assertEqual(actual, expect)`
- `assertRaises(ErrorType)` : 断言会发生某种异常，通常用 `with` 语句进行管理，要执行的语句放置在语句块中

#### 执行测试

- 在编写测试类的脚本中，调用 `unittest.main()` 方法，可以执行该脚本中的测试

- 使用命令行，使用 `-m unittest` 参数，指明要执行的脚本：

  > python -m unittest script_file

#### setUp() 与 tearDown()

在测试类中添加 `setUp`  和 `tearDown` 方法，会在每个测试用例执行前或结束后执行

- `setUp` : 每个测试执行前执行
- `tearDown` : 每个测试执行结束后执行

