# Jasmine for Node JS
## install and use Jasmine
1. Add Jasmine to your package.json  
    **use local install**
> npm install --save-dev jasmine

    **use global install**
> npm install -g jasmine

2. Use `jasmine` command
    * `jasmine`: use global install
    * `node node_modules/jasmine/bin/jasmine`: use locally install, we should find the jasmine file

3. Initialize Jasmine in your project
    > node node_modules/jasmine/bin/jasmine `init`  

    > jasmine `init`

4. Set jasmine as your test script in your package.json
```json
"scripts": { "test": "jasmine" }
```

5. Run your tests
    > npm test

    > jasmine

    > node node_modules/jasmine/bin/jasmine.js

    // run specific test file
    > jasmine spec/appSpec.js

6. Generate `example` spec and source files by Jasmine
> jasmine examples

## Jasmine project structure
![jasmine测试项目结构.png](pic\jasmine测试项目结构.png)
* `spec` folder: `spec`在Jasmine中是`测试用例`的意思，`spec`文件夹用于存放测试文件和测试配置文件的目录，其中重要的文件就是`support/jasmine.json`
* `support` folder: `spec`的子目录，存放`jasmine.json`文件，之所以要有这一级目录，是因为Jasmine的源文件中指明了要在项目的`spec/support`目录下找`jasmine.json`文件
* `jasmine.json`: 项目中jasmine的配置文件，在**Configuration**中介绍
## Configuration
```javascript
{
    // Spec directory path relative to the current working dir when jasmine is executed.
    "spec_dir": "spec",

    // Array of filepaths (and globs) relative to spec_dir to include
    "spec_files": [
    "**/*[sS]pec.js"
    ],

    // Array of filepaths (and globs) relative to spec_dir to include before jasmine specs
    "helpers": [
    "helpers/**/*.js"
    ],

    // Stop execution of a spec after the first expectation failure in it
    stopSpecOnExpectationFailure: false,

    // Run specs in semi-random order
    random: false
}
```
* 使用一颗星`*`表示匹配任意字符；使用两颗星`**`则可以匹配任意目录
* 完成Jasmine的配置后，在编写测试文件时，无需引入jasmine的模块

## API
```javascript
describe("A suite is just a function", () => {
  let a
  it("and so is a spec", () => {
    a = true
    expect(a).toBe(true)
  })
})
```
### describe (description, specDefinitions)
Create a group of specs (often called a suite).  
Calls to describe can be nested within other calls to compose your suite as a tree.  
**Parameters:**  

|Name|Type|Description|  
|:---|:---|:---|  
|description|String|Textual description of the group|  
|specDefinitions|function|Function for Jasmine to invoke that will define inner suites and specs|

### it (description, testFunction, timeout)
Define a single spec. A spec should contain one or more expectations that test the state of the code.  
A spec whose expectations all succeed will be passing and a spec with any failures will fail.  
**Parameters:**

|Name|Type|Attributes|Description|  
|:---|:---|:---|:---|  
|description|String| |Textual description of what this spec is checking|
|testFunction|implementationCallback|optional|Function that contains the code of your test. If not provided the test will be pending.|  
|timeout|Int|optional|Custom timeout for an async spec.|

### expect (actual) → {matchers}
Create an expectation for a spec.  
**Parameters:**

|Name|Type|Description|Return|
|:---|:---|:---|:---|  
|actual|Object|Actual computed value to test expectations against.|matchers|

#### `matchers` API
* toBe(expected)
* toBeFalsy() && toBeTruthy()
* toBeGreaterThan(expected) && toBeGreaterThanOrEqual(expected)
* toBeLessThan(expected) && toBeLessThanOrEqual(expected)
* toBeNaN() && toBeNull() && toBeUndefined()
* toContain(expected)
* toEqual(expected)
* toHaveBeenCalled() && toHaveBeenCalledWith(...args)
* toHaveBeenCalledBefore(expected)
* toHaveBeenCalledTimes(expected)
* toThrow(expected) && toThrowError(expected, message)

#### expectAsync(actual) → {async-matchers}

### beforeAll (function, timeout)
### beforeEach (function, timeout)
### afterEach (function, timeout)
### afterAll (function, timeout)
thoes will be executed for each inner describe spec too.  
excute order: `beforeAll`->`beforeEach`->`afterEach`->`afterAll`  

### this
对于每一个 `beforeEach`-`it`-`afterEach` 的组合，共享一个`this`，即不同的`it`之间的`this`是不同的

### fail (errorMsg)
Explicitly mark a spec as failed.  
**Parameters:**

|Name|Type|Attributes|Description|
|:---|:---|:---|:---|  
|errorMsg|String/Error|optional|Reason for the failure.|

### xdescribe (description, specDefinitions)
A temporarily disabled describe.  
Specs within an xdescribe will be marked pending and not executed.  
`beforeAll`,`beforeEach`,`afterEach`,`afterAll` all will not work  
**Parameters:**

|Name|Type|Description|
|:---|:---|:---|  
|description|String|Textual description of the group|
|specDefinitions|function|Function for Jasmine to invoke that will define inner suites and specs|

### xit (description, testFunction)
A temporarily disabled it  
The spec will report as pending and will not be executed.
`beforeAll`,`beforeEach`,`afterEach`,`afterAll` all will not work  
**Parameters:**

|Name|Type|Attributes|Description|
|:---|:---|:---|:---|
|description|String||Textual description of what this spec is checking.|
|testFunction|implementationCallback|optional|Function that contains the code of your test. Will not be executed.|

### pending (reasonMsg)
Mark a spec as pending, expectation results will be ignored.   
`beforeAll`,`beforeEach`,`afterEach`,`afterAll` are woring, but expectations are not working
**Parameters:**

|Name|Type|Attributes|Description|
|:---|:---|:---|:---|
|message|String|optional|Reason the spec is pending.|

### spyOn (obj, methodName) → {Spy}
Install a spy onto an existing object.  
**Parameters:**

|Name|Type|Description|Return|
|:---|:---|:---|:---|  
|obj|Object|The object upon which to install the Spy.|
|methodName|String|The name of the method to replace with a Spy.|Spy|

### Class: Spy
**namespace**：call, and
#### `call` API:
* any()
* saveArgumentsByValue()
* first()
* all()
* allArgs()
* argsFor(index)
* count()
* mostRecent()
* reset()

#### `and` API
* returnValue(value)
* returnValues(…values)
* throwError(something)
* identity()
* exec()
