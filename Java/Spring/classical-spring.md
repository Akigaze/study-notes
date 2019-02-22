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

#### Example: Hello World
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

#### Example
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
### <beans\>
### <bean\>
1. class: 全类名，Spring会通过反射的方式创建bean，因此该类需要有一个 **无参构造方法**
2. id: bean的唯一标示，相当于对象名，在配置文件中是唯一的


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
