### 注解
1. 元数据
2. 注解处理器进行解释
3. 使用 `@注解名称(参数=值)`
4. JDK5开始
5. 编译后也会生成class文件

### Java内置注解
1. `@Override`
2. `@SuppressWarnings`
3. `@Deprecated`

### 注解的使用
1. 类声明前
2. 方法声明前
3. 属性声明前
4. 一个元素上可添加多个注解，且这些注解的平行的关系
5. 设置注解的参数：  
`@SuppressWarnings(value={"unchecked", "unused"})`

### 元注解
用于创建注解的工具，也是注解，被存放在 `java.lang.annotation` 包中

#### 1. @Target：
指定注解的作用域，表明定义的注解可以作用的范围

作用域的类型被定义在 `ElementType` 这个枚举类中：

1. **ANNOTATION_TYPE**
2. **CONSTRUCTOR**
3. **FIELD**
4. **LOCAL_VARIABLE**
5. **METHOD**
6. **PACKAGE**
7. **PARAMETER**
8. **TYPE：作用在类、接口或枚举上**

#### 2. @Retention
表明注解信息的保留策略，即注解的信息会保留到程序开发哪些阶段，有 **源文件**，**class文件** 和 **运行时** 三个阶段

可选的策略级别被定义在 `RetentionPolicy` 枚举类中：
1. **SOURCE**
2. **CLASS**
3. **RUNTIME**

#### 3. @Documented
表明是否将注解信息加入javadoc文档中，如果不使用该注解则不会在javadoc中生成注解信息

#### 4. @Inherited
表明定义的注解在使用时是否可以被子类继承

## 定义注解
1. 使用 `@interface` 关键字定义注解
2. 定义参数时，要在参数名称后加 **括号** ，类似于抽象方法的定义
3. 在参数定义后面使用 `default` 关键字指定参数的默认值
4. 没有指定默认值的参数在使用注解时必须传参

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
//@interface 声明一个注解
public @interface Entity{
    //有默认值，使用注解时可以不传参
    public int type() default -1;
    //没有默认值，使用注解时必须传参
    public String name();
}
```

### 参数类型
1. 基本数据类型
2. String
3. Class
4. enum
5. Annotation
6. 不可以是包装类型(Integer...)

### 参数赋值要求
1. 必须的确定的值，即不能是变量？
2. 只能在注解定义时给定默认值或使用时赋值
3. 参数必须赋值

**\* 参数赋值的快捷方式：**  
当注解定义了一个名为 **`value`** 的参数，并且在使用时只有该参数时，在使用赋值时，无需指定参数名称，直接在括号中添加参数的值

```java
@Target(ElementType.FIELD)
@Retention(RetentionPolicy.RUNTION)
public @interface ID{
    public int value();
    public String description() default 0;
}
public class User{
    @ID(1)
    private Integer id;
}
```
