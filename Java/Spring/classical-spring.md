# Spring Basic
## What is Spring?
1. 开源
2. 简化企业级应用
3. IOC和AOP的容器框架

## Description of Spring
1. 轻量级，非入侵
2. 依赖注入(DI: Dependency Injection)
3. 面向切面编程(AOP: Aspect Oriented Programming)
4. 容器，管理对象的生命周期
5. 框架
6. 一站式

## Related Jar Packages
- commons-logging
- spring-beans
- spring-context
- spring-core
- spring-expression

##### Example: Hello World
##### 1 实体类
```java
package com.hello;

@Getter
@Setter
public class HelloSpring {
    private String name;

    public void sayHello(){
        System.out.println("Hello " + this.name);
    }
}
```

##### 2 Spring的配置文件
在项目的类路径(classpath)下创建Spring的 `xml` 配置文件，名称任意，习惯名为 `applicationContext.xml`
```xml
// src/applicationContext.xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
    <bean id="spring" class="com.hello.HelloSpring">
        <property name="name" value="Spring"/>
    </bean>
</beans>
```

##### 3 启用IOC容器
指定Spring的配置文件，创建一个 `ApplicationContext` 的容器引用对象，使用对象的 `getBean` 方法直接获取bean对象
```java
package com.hello;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class HelloMain {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
        HelloSpring spring = (HelloSpring) context.getBean("spring");
        spring.sayHello();
    }
}
```

## IOC & DI
### IOC(Inversion of Control)
1. 控制反转
2. 容器主动将资源推送给有需要的组件
3. 组件只需选择接受资源的方式

### DI(Dependency Injection)
1. 依赖注入，IOC的另一种表述方式
2. 组件以特定的方式接受容器推送的资源

##### Example
```java
class Card{
    ...
}

class Phone{
    Card sim;
    public void setSim(Card sim){
        this.sim = sim;
    }
}
```

![](./pic/use ioc1.png)

## config bean by XML
- <beans\>
- <bean\>
- <property\>
- <constructor-arg\>
- <value\>
- <ref\>
- <null\>
- <list\>
- <set\>
- <map\>
- <entry\>
- <props\>
- <prop\>

## IOC container
1. BeanFactory: Spring 底层的IOC容器，主要面向框架内部
2. ApplicationContext: 面向使用Spring的开发人员的IOC容器

### ApplicationContext
- interface ApplicationContext
- interface ConfigurableApplicationContext
- class ClassPathXmlApplicationContext
- class FileSystemXmlApplicationContext
- WebApplicationContext

默认情况下，`ApplicationContext` 容器在初始化的时候，会自动实例化容器中的bean对象，并通过 `setter` 或 `constructor` 的方式为bean注入属性。

### ClassPathXmlApplicationContext
指定xml配置文件：
1. xml在src目录下，则直接写 `文件名.扩展名`
2. xml在src目录的其他包下，则指定文件目录要以 `/`(斜杠) 或 `\\`(双反斜杠) 开头，如 `/com/beans/autowire/bean-autowire-config.xml`

### get bean
通过 `BeanFactory` 接口的 `getBean` 方法，获取bean，`ApplicationContext` 就继承了 `BeanFactory` 接口。

### Dependency Injection
1. setter: 属性注入
2. constructor: 构造器注入
3. 工厂方法注入(很少用)

#### setter injection
在 `xml` 配置文件中使用 `<property>` 标签注入属性，指定的属性必须有相应的 `setter` 方法。

#### constructor injection
在 `xml` 配置文件中使用 `<constructor-arg>` 标签通过相应的构造方法注入属性。
##### Example
1. 实体类 Car
```java
package com.beans.injection;
public class Car {
    private String brand;
    private double price;
    private int maxSpeed;
    public Car(String brand, double price) {
        this.brand = brand;
        this.price = price;
    }
    public Car(String brand, int maxSpeed) {
        this.brand = brand;
        this.maxSpeed = maxSpeed;
    }
}
```

2. src/applicationContext.xml
```xml
<bean id="bmw" class="com.beans.injection.Car">
    <constructor-arg value="BMW" index="0"/>
    <constructor-arg value="200000" index="1" type="double"/>
</bean>
<bean id="bench" class="com.beans.injection.Car">
    <constructor-arg value="Bench" index="0"/>
    <constructor-arg value="200" index="1" type="int"/>
</bean>
```

#### bean reference
1. 通过 `ref` 属性或 `<ref>` 标签对bean进行引用
2. 创建内部bean

##### bean reference by ref
在 `<property>` 和 `<constructor-arg>` 标签中，可以通过 `ref` 属性(或 `<ref>` 标签)引用其他的bean，只需指明bean的id即可。
##### Example
1. 实体类 Person
```java
package com.beans.injection;
@Getter
@Setter
public class Person {
    private String name;
    private int age;
    private Car car;
}
package com.beans.injection;
public class Car {
    ...
}
```

2. src/applicationContext.xml
```xml
<bean id="bmw" class="com.beans.injection.Car">...</bean>
<bean id="Jam" class="com.beans.injection.Person">
    <property name="name" value="Jam"/>
    <property name="age" value="30"/>
    <!--<property name="car" ref="bmw"/>-->
    <property name="car">
        <ref bean="bmw"/>
    </property>
</bean>
```

##### bean reference by inner bean
在 `<property>` 和 `<constructor-arg>` 标签中，通过创建 `<bean>` 作为属性的值。

这种方式创建的bean是内部bean，所以其他的bean无法访问，因此内部bean不需要id属性。

##### Example
```xml
<bean id="Sam" class="com.beans.injection.Person">
    <constructor-arg value="Sam"/>
    <constructor-arg value="40"/>
    <constructor-arg>
        <bean class="com.beans.injection.Car">
            <constructor-arg value="Bench"/>
            <constructor-arg value="200" type="int"/>
        </bean>
    </constructor-arg>
</bean>
```

##### cascade property
如果属性是对象，还可以通过 `<property>` 标签为属性的属性赋值，使用 `name` 指定引用的对象和属性(`name="property.property"`)，此时该属性的引用不能为null。

##### Example
```xml
<bean id="Jam" class="com.beans.injection.Person">
    <property name="name" value="Jam"/>
    <property name="age" value="30"/>
    <property name="car">
        <ref bean="bmw"/>
    </property>
    <property name="car.maxSpeed" value="300"/>
</bean>
```

#### create collection bean
定义在 `<constructor-arg>` 或 `<property>` 中作为参数的集合bean：
- 使用 `<list>` 标签创建 `java.util.List` 或 数组类型的bean对象
- 使用 `<set>` 标签创建 `java.util.Set` 类型的bean对象，用法与 `<list>` 相似
- 使用 `<map>` 标签和 `<entry>` 子标签创建 `java.util.Map` 类型的bean对象
- 使用 `<props>` 标签和 `<prop>` 子标签创建 `java.util.Properties` 类型的bean对象。
-  `<list>`，`<set>`，`<map>` 和 `<props>` 只能创建局部的bean对象，因此无法再 `<beans>` 内直接使用。

独立的集合bean对象，可被其他bean共享：  
使用 `util` 名称空间的标签在 `<beans>` 标签内直接创建list，set，map，properties等bean对象，这些对象可以被全局引用。

### Autowire
- 设置bean自动装配属性
- `<bean>` 的 `autowire` 属性进行设置
- 使用类的 `setter` 为属性赋值
- 若属性没有 `setter` 或没有可装配的bean，也不会有异常，只是不进行属性装配而已

属性取值：
1. byName：bean的id与自动装配的类的 setter 属性名相同
2. byType：bean的类型与自动装配的类的 setter 参数类型相同
3. constructor

异常：
- `org.springframework.beans.factory.NoUniqueBeanDefinitionException`：使用 `byType` 自动装配时，若同一类型的bean有多个，Spring无法决定使用哪一个进行装配

#### Example
```xml
<bean id="address" class="com.beans.autowire.Address"
      p:city="Guangzhou" p:street="Wushan" p:number="1024"/>
<bean id="boss" class="com.beans.autowire.Entrepreneur"
      p:name="Ma Yunyun" p:age="55" p:asset="10000000"/>
<bean id="qi-lin-nan" class="com.beans.autowire.Shop"
      p:name="Qi Lin Nan Shop" p:open="true" autowire="byName"/>
<bean id="wu-shan" class="com.beans.autowire.Shop"
      p:name="Wu Shan Shop" p:open="false" autowire="byType"/>
```


# Link
### Offical
1. Home page  
https://spring.io/  
2. Spring projects and frameworks  
https://spring.io/projects  
3. Spring Initializr  
https://start.spring.io/  
4. Spring Github  
https://github.com/spring-projects

### How2J Spring
http://how2j.cn/k/spring/spring-ioc-di/87.html

### Bilibili
1. 尚硅谷首套_Spring4 视频教程  
https://www.bilibili.com/video/av21335209
