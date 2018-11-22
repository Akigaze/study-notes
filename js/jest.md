# Jest
## 官网描述
### 零配置测试平台
Jest 被 Facebook 用来测试包括 React 应用在内的所有 JavaScript 代码。Jest 的一个理念是提供一套完整集成的 “零配置” 测试体验。我们发现，当向开发人员提供了现成可用的工具后，他们会愿意写更多的测试，这也使得他们的代码库更加稳定和健康。
### 高速和沙盒
Jest 跨工人以最大化性能并行化的测试运行。控制台消息都是缓冲并输出测试结果。沙盒测试文件和自动全局状态将为每个测试重置，因此测试代码间不会冲突。
### 内置代码覆盖率报告
Easily create code coverage reports using `--coverage`. No additional setup or libraries needed! Jest can collect code coverage information from entire projects, including untested files.
### 无需配置
在你使用 `create-react-ap`p 或 `react-native init` 创建你的 React 或 React Native 项目时，Jest 都已经被配置好并可以使用了。在 `__tests__`文件夹下放置你的测试用例，或者使用 `.spec.js` 或 `.test.js` 后缀给它们命名。不管你选哪一种方式，Jest 都能找到并且运行它们。
### 功能强大的模拟库
Powerful mocking library for functions and modules. Mock React Native components using jest-react-native.
### 与Typescript一同使用
Jest可以使用于任何Javascript编译器，与Babel Typescript通过 ts-jest无缝集成。

## Jest安装与使用
### 相关依赖
- babel-jest
- react-addons-test-utils
- regenerator-runtime
- jest

### 安装
> npm install --save-d jest

### 执行
运行测试文件
> jest

配置npm的Jest测试命令
```json
{
    "scripts" : {
        "test" : "jest"
    }
}
```

Jest默认会自动遍历项目文件，找到后缀名为`.spec.js`或`.test.js`的文件执行其中的测试

同时，Jest真的是零配置的，对于react的测试也无需任何额外配置，因为Jest本身就自带了`jsdom`，可以模拟node环境下的DOM；若使用Enzyme进行react测试，则需要在测试文件的头部配置Enzyme的react适配器：
```JavaScript
import {configure} from "enzyme";
import Adapter from "enzyme-adapter-react-16";
configure({adapter: new Adapter()});
```

使用jest命令执行测试时，Jest是不能直接识别jasmine的断言API(`toHaveClass`...)的，但可以识别spec的`it`

## Jest的配置
> jest --init

生成jest的配置文件 `jest.config.js`，如果不需要单独的配置文件，可以在`package.js`中添加一个"jest"对象的属性，在其中进行Jest的配置

`jest.config.js`文件中有大量的注释，是关于jest配置项的一些说明

使用`jest --init`生成配置文件是，会有一个测试环境的选择，包括`node`和`jsdom`两个选项，若选择`node`，则文件会添加一个`testEnvironment: "node"`的属性，但是不管选哪一个，都能正常使用Enzyme进行react组件的测试

### configure options
- automock [boolean]
- bail [boolean]
- browser [boolean]
- cacheDirectory [string]
- clearMocks [boolean]
- collectCoverage [boolean]
- collectCoverageFrom [array]
- coverageDirectory [string]
- coveragePathIgnorePatterns [array]
- coverageReporters [array]
- coverageThreshold [object]
- errorOnDeprecated [boolean]
- forceCoverageMatch [array]
- globals [object]
- globalSetup [string]
- globalTeardown [string]
- moduleDirectories [array]
- moduleFileExtensions [array]
- moduleNameMapper [object]
- modulePathIgnorePatterns [array]
- modulePaths [array]
- notify [boolean]
- notifyMode [string]
- preset [string]
- prettierPath [string]
- projects [array]
- reporters [array]
- resetMocks [boolean]
- resetModules [boolean]
- resolver [string]
- restoreMocks [boolean]
- rootDir [string]
- roots [array]
- runner [string]
- setupFiles [array]
- setupTestFrameworkScriptFile [string]
- snapshotSerializers [array]
- testEnvironment [string]
- testEnvironmentOptions [Object]
- testMatch [array]
- testPathIgnorePatterns [array]
- testRegex [string]
- testResultsProcessor [string]
- testRunner [string]
- testURL [string]
- timers [string]
- transform [object]
- transformIgnorePatterns [array]
- unmockedModulePathPatterns [array]
- verbose [boolean]
- watchPathIgnorePatterns [array]
- watchPlugins [array]

### moduleNameMapper
对于项目文件中引用的一些css，png，svg等资源文件，在jest的测试中是没有必要真正加载的，因此可以建立一个映射关系，将相应文件的引用映射成自定义的js对象，类似于资源的mock
```JavaScript
{
    moduleNameMapper: {
        //将jpg,png等图像文件映射成fileMock.js文件所export的模块
        "\\.(jpg|jpeg|png|gif|eot|otf|webp|svg|ttf|woff|woff2|mp4|webm|wav|mp3|m4a|aac|oga)$":"<rootDir>/spec/mock/fileMock.js",
        //将css文件映射成styleMock.js文件所export的模块
        "\\.(css|less)$": "<rootDir>/spec/mock/styleMock.js"
    }
}
```

example of styleMock.js
```JavaScript
module.exports = {};
```

example of fileMock.js
```JavaScript
module.exports = 'test-file-stub';
```

### coverageDirectory
生成jest.config.js文件是，若选择生成测试覆盖率文件夹，则会在项目根目录下生成`coverage`文件夹存放测试覆盖率的结果报告，同时添加`coverageDirectory: "coverage"`的配置项

可以在jest命令后使用`--coverage`参数，直接在命令行输出本次测试的覆盖率

### setupFiles []
setup files 的列表，存放每一个setup file的相对路径, setup file会在每个测试文件之前执行

## Jest API
### basic
- afterAll(fn, timeout)
- afterEach(fn, timeout)
- beforeAll(fn, timeout)
- beforeEach(fn, timeout)
- describe(name, fn)
- describe.each(table)(name, fn, timeout)
- describe.only(name, fn)  
在同一作用域下，不执行其他没有`.only`标示的`describe`和`test`，若没有`.only`标示的`describe`中包含有`.only`标示的其他`describe`或`test`，则这些内部的测试也会执行
- describe.only.each(table)(name, fn)
- describe.skip(name, fn)
- describe.skip.each(table)(name, fn)
- test(name, fn, timeout)
- test.each(table)(name, fn, timeout)
- test.only(name, fn, timeout)  
在同一作用域下，不执行其他没有`.only`标示的`describe`和`test`，若没有`.only`标示的`describe`中包含有`.only`标示的其他`describe`或`test`，则这些内部的测试也会执行
- test.only.each(table)(name, fn)
- test.skip(name, fn)
- test.skip.each(table)(name, fn)

#### before与after的执行顺序
```JavaScript
beforeAll(() => console.log('1 - beforeAll'));
afterAll(() => console.log('1 - afterAll'));
beforeEach(() => console.log('1 - beforeEach'));
afterEach(() => console.log('1 - afterEach'));
test('', () => console.log('1 - test'));
describe('Scoped / Nested block', () => {
  beforeAll(() => console.log('2 - beforeAll'));
  afterAll(() => console.log('2 - afterAll'));
  beforeEach(() => console.log('2 - beforeEach'));
  afterEach(() => console.log('2 - afterEach'));
  test('', () => console.log('2 - test'));
});

// 1 - beforeAll
// 1 - beforeEach
// 1 - test
// 1 - afterEach
// 2 - beforeAll
// 1 - beforeEach
// 2 - beforeEach
// 2 - test
// 2 - afterEach
// 1 - afterEach
// 2 - afterAll
// 1 - afterAll
```

#### describe与test的顺序
> Jest executes all describe handlers in a test file before it executes any of the actual tests. This is another reason to do setup and teardown in before* and after* handlers rather in the describe blocks. Once the describe blocks are complete, by default Jest runs all the tests serially in the order they were encountered in the collection phase, waiting for each to finish and be tidied up before moving on.

Jest会先按顺序执行所有`describe`中的所有其他代码，在按顺序执行`test`中的测试，所以推荐将测试的准备写在`before*`和`after*`中，保证代码正确的执行顺序

### Expect断言
- expect(value)
- expect.extend(matchers)
- expect.anything()
- expect.any(constructor)
- expect.arrayContaining(array)
- expect.assertions(number)
- expect.hasAssertions()
- expect.not.arrayContaining(array)
- expect.not.objectContaining(object)
- expect.not.stringContaining(string)
- expect.not.stringMatching(string | regexp)
- expect.objectContaining(object)
- expect.stringContaining(string)
- expect.stringMatching(string | regexp)
- expect.addSnapshotSerializer(serializer)
- .not
- .resolves
- .rejects
- .toBe(value)
- .toHaveBeenCalled()
- .toHaveBeenCalledTimes(number)
- .toHaveBeenCalledWith(arg1, arg2, ...)
- .toHaveBeenLastCalledWith(arg1, arg2, ...)
- .toHaveBeenNthCalledWith(nthCall, arg1, arg2, ....)
- .toHaveReturned()
- .toHaveReturnedTimes(number)
- .toHaveReturnedWith(value)
- .toHaveLastReturnedWith(value)
- .toHaveNthReturnedWith(nthCall, value)
- .toBeCloseTo(number, numDigits)
- .toBeDefined()
- .toBeFalsy()
- .toBeGreaterThan(number)
- .toBeGreaterThanOrEqual(number)
- .toBeLessThan(number)
- .toBeLessThanOrEqual(number)
- .toBeInstanceOf(Class)
- .toBeNull()
- .toBeTruthy()
- .toBeUndefined()
- .toContain(item)
- .toContainEqual(item)
- .toEqual(value)
- .toHaveLength(number)
- .toMatch(regexpOrString)
- .toMatchObject(object)
- .toHaveProperty(keyPath, value)
- .toMatchSnapshot(propertyMatchers, snapshotName)
- .toMatchInlineSnapshot(propertyMatchers, inlineSnapshot)
- .toStrictEqual(value)
- .toThrow(error)
- .toThrowErrorMatchingSnapshot()
- .toThrowErrorMatchingInlineSnapshot()

### mock
- mockFn.getMockName()
- mockFn.mock.calls  
检验`mockFn`这个mock对象被调用的情况，其结果是一个二维数组，第一维表示第几次被调用，第二维表示调用时参数的顺序，`length`属性返回被调用的次数  
```JavaScript
const mockCallback = jest.fn(x => 42 + x);
forEach([0, 1], mockCallback);
// The mock function is called twice
expect(mockCallback.mock.calls.length).toBe(2);
// The first argument of the first call to the function was 0
expect(mockCallback.mock.calls[0][0]).toBe(0);
// The first argument of the second call to the function was 1
expect(mockCallback.mock.calls[1][0]).toBe(1);
```
- mockFn.mock.results  
检验mock方法执行的结果，是一个一维数组，每个元素的`value`属性代表返回值
```JavaScript
const mockCallback = jest.fn(x => 42 + x);
forEach([0, 1], mockCallback);
// The return value of the first call to the function was 42
expect(mockCallback.mock.results[0].value).toBe(42);
// The return value of the second call to the function was 43
expect(mockCallback.mock.results[1].value).toBe(43);
```
- mockFn.mock.instances
- mockFn.mockClear()
- mockFn.mockReset()
- mockFn.mockRestore()
- mockFn.mockImplementation(fn)
- mockFn.mockImplementationOnce(fn)
- mockFn.mockName(value)
- mockFn.mockReturnThis()
- mockFn.mockReturnValue(value)  
设置mock方法每次执行的返回值
- mockFn.mockReturnValueOnce(value)  
相当于mokito的`thenReturn`；该方法的返回值是mock对象本身，因而可以继续调用设置第下一次调用时的返回值  
```JavaScript
const myMock = jest.fn();
console.log(myMock());
// > undefined
myMock.mockReturnValueOnce(10)
      .mockReturnValueOnce('x')
      .mockReturnValue(true);
console.log(myMock(), myMock(), myMock(), myMock());
// > 10, 'x', true, true
```
- mockFn.mockResolvedValue(value)
- mockFn.mockResolvedValueOnce(value)
- mockFn.mockRejectedValue(value)
- mockFn.mockRejectedValueOnce(value)

### jest Object
- jest.clearAllTimers()
- jest.disableAutomock()
- jest.enableAutomock()
- jest.fn(implementation)
返回一个jest的方法mock对象，参数为自定义的实现  
- jest.isMockFunction(fn)
- jest.genMockFromModule(moduleName)
- jest.mock(moduleName, factory, options)
- jest.unmock(moduleName)
- jest.doMock(moduleName, factory, options)
- jest.dontMock(moduleName)
- jest.clearAllMocks()
- jest.resetAllMocks()
- jest.restoreAllMocks()
- jest.resetModules()
- jest.retryTimes()
- jest.runAllTicks()
- jest.runAllTimers()
- jest.runAllImmediates()
- jest.advanceTimersByTime(msToRun)
- jest.runOnlyPendingTimers()
- jest.requireActual(moduleName)
- jest.requireMock(moduleName)
- jest.setMock(moduleName, moduleExports)
- jest.setTimeout(timeout)
- jest.useFakeTimers()
- jest.useRealTimers()
- jest.spyOn(object, methodName)
- jest.spyOn(object, methodName, accessType?)


#Link
### 官网
中文官网  
https://jestjs.io/zh-Hans/  
英文官网  
https://jestjs.io/en/  
Jest命令参数  
https://jestjs.io/docs/zh-Hans/cli
### 开源中国
如何使用 Jest 测试 React 组件   
https://www.oschina.net/translate/test-react-components-jest
