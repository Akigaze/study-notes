# AOP
AOP: Aspect-Oriented Programming, 面向切面编程

## Proxy for log manage no AOP
```java
import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Proxy;

public interface Calculator{
    ...
}

public class PositiveIntegerCalculatorProxy {
    private Calculator target;

    public PositiveIntegerCalculatorProxy(Calculator calculator) {
        this.target = calculator;
    }

    public Calculator getProxy(){
        //创建代理对象所需的ClassLoader
        ClassLoader loader = this.target.getClass().getClassLoader();
        //所代理的类实现的接口数组
        Class[] interfaces = new Class[]{Calculator.class};
        //调用代理对象方法时的真实操作
        InvocationHandler handler = (proxy, method, args) -> {
            String startLog = String.format("Execute %s with %s", method.getName(), Arrays.toString(args));
            System.out.println(startLog);
            //真正业务对象的操作
            Object result = method.invoke(this.target, args);
            String endLog = String.format("Execute result is %s", result.toString());
            System.out.println(endLog);
            return result;
        };
        //使用反射方式创建代理对象
        Object proxy = Proxy.newProxyInstance(loader, interfaces, handler);
        return (Calculator) proxy;
    }

    public static void main(String[] args) {
        Calculator calculator = new PositiveIntegerCalculatorProxy(new PositiveIntegerCalculator()).getProxy();
    }
}
```



## AOP use AspectJ

Spring使用 `AspectJ` 作为切面的处理工具，使用时需要如下依赖：

* om.springsource.org.aopalliance

- com.springsource.org.aspectj.weaver
- spring-aop
- spring-aspects

### 基本使用

1. 针对每 **一个切面** 需要设置 **一个切面处理类**，使用 `@Aspect` 注解标示
2. 切面类也需要配置成bean
3. 在xml配置文件中引入aop的名称空间，添加 `<aop:aspectj-autoproxy/>` 标签，标示自动为切面bean生成代理对象
4. AspectJ有4中通知注解
   1. `@Before`
   2. `@After`
   3. `@AfterRunning`
   4. `@AfterThrowing`
   5. `@Around`
5. 切面的处理由切面类的方法执行，需要将对应的通知注解添加到处理方法上

### @Before 前置通知

1. 在指定方法执行前执行的方法
2. 参数值使用 `execution(...)` 描述触发的时机，指定方法的声明，可以是实现类也可以是接口，但泛型例外
3. `*` 指代任何修饰符、包名或类名，根据使用的位置不同有不同的含义
4. `..` 指代任意参数
5. 切面的处理方法可以获得一个 `JoinPoint` 类型的参数，以获取切面的相关信息，在方法声明时可以选择性添加该参数

```java
@Before("execution(public Integer framework.helloworld.entity.IntegerCalculator.*(..))")
//aspect method can get JoinPoint parameter
public void logBefore(JoinPoint point){
    String name = point.getSignature().getName();
    List<Object> args = Arrays.asList(point.getArgs());
    String log = String.format("execute %s with %s", name, args.toString());
    System.out.println(log);
}
```

### @After 后置通知

1. 与 `@Before` 相似
2. 在方法执行结束后执行，不论方法是否发生异常
3. 但是不能访问到方法的返回值

```java
@After("execution(public * framework.helloworld.entity.IntegerCalculator.*(..))")
public void logAfter(JoinPoint point){
    String name = point.getSignature().getName();
    String log = String.format("%s execute end", name);
    System.out.println(log);
}
```

### @AfterRunning 返回通知

1. 在方法正常结束后执行
2. 通过 `returning` 参数可以访问到方法返回值
3. 若方法没有返回值 `returning` 的值将会是 **null**
4. 可以在通知处理函数的第二个参数获取到方法的返回值，形参名称要跟注解`returning`指定的一致
5. 返回值参数的类型可以自由指定，但如果真实的返回值无法转换成指定的类型，则不执行通知处理函数

```java
@AfterReturning(value = "execution(public * framework.helloworld.entity.IntegerCalculator.*(..))", returning = "result")
public void logReturn(JoinPoint point, Integer result){
    String name = point.getSignature().getName();
    String log = String.format("%s return %s", name, result);
    System.out.println(log);
}
```

### @AfterThrowing 异常通知

1. 只有在方法抛出异常时才执行
2. 通过 `throwing` 参数可以访问到异常对象
3. 可以在通知处理函数的第二个参数获取到异常，形参名称要跟注解`throwing`指定的一致
4. 异常的类型可以自由指定，但如果真实的异常类型无法转换成指定的类型，则不执行通知处理函数

```java
@AfterThrowing(value = "execution(public * framework.helloworld.entity.IntegerCalculator.*(..))", throwing = "e")
public void logException(JoinPoint point, Exception e){
String name = point.getSignature().getName();
String log = String.format("%s occurs %s", name, e.toString());
System.out.println(log);
}
```

```java
@Aspect
@Component
public class LogAspect {
    @Before("execution(public * framework.helloworld.entity.Calculator.*(..))")
    //aspect method can get JoinPoint parameter
    public void logBefore(JoinPoint point){
        String name = point.getSignature().getName();
        List<Object> args = Arrays.asList(point.getArgs());
        String log = String.format("execute %s with %s", name, args.toString());
        System.out.println(log);
    }
    
    @After("execution(public * framework.helloworld.entity.Calculator.*(..))")
    public void logAfter(JoinPoint point){
        String name = point.getSignature().getName();
        String log = String.format("%s execute end", name);
        System.out.println(log);
    }
    
    @AfterReturning(value = "execution(public * framework.helloworld.entity.IntegerCalculator.*(..))", returning = "result")
    public void logReturn(JoinPoint point, Integer result){
        String name = point.getSignature().getName();
        String log = String.format("%s return %s", name, result);
        System.out.println(log);
    }
    
    @AfterThrowing(value = "execution(public * framework.helloworld.entity.IntegerCalculator.*(..))", throwing = "e")
    public void logException(JoinPoint point, Exception e){
        String name = point.getSignature().getName();
        String log = String.format("%s occurs %s", name, e.toString());
        System.out.println(log);
    }

    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("aop-aspectj.xml");

        //no interface, could not create proxy instance
//        DoubleCalculator doubleCalculator = (DoubleCalculator)context.getBean("doubleCalculator");
//        System.out.println(doubleCalculator.add(1.1, 9.0));

        //NoSuchBeanDefinitionException: No qualifying bean of type 'framework.helloworld.entity.IntegerCalculator' available
//        Calculator calculator = context.getBean(IntegerCalculator.class);

        //ClassCastException: com.sun.proxy.$Proxy10 cannot be cast to framework.helloworld.entity.IntegerCalculator
//        Calculator calculator = (IntegerCalculator) context.getBean("calculator");

        Calculator calculator1 = context.getBean(Calculator.class);
        calculator1.add(1, 2);
        calculator1.divide(10, 0);
        calculator1.square(10);

        Calculator calculator2 = (Calculator) context.getBean("calculator");
        calculator2.add(3, 4);
        calculator1.square(0);
    }
}

```

### @Around 环绕通知

1. 环绕通知相当于动态代理中的 `InvocationHandler ` 对象，可以控制代理方法执行的整个过程
2. 注解的使用与 `@Before` 相似
3. 通知的方法会获得一个 `ProceedingJoinPoint` 类型的参数，可以获得目标方法的信息
4.  `ProceedingJoinPoint` 对象的  `proceed()` 方法执行真正的方法
5. 环绕通知的方法的返回值，会成为代理对象方法的返回值

```java
@Around("execution(public * framework.helloworld.entity.IntegerCalculator.*(..))")
public Object logAround(ProceedingJoinPoint proceedingJoinPoint) throws Exception {
	Object result = null;
	String name = proceedingJoinPoint.getSignature().getName();
	//前置通知
	System.out.println(String.format("%s execute", name));
	try {
		//执行真正的业务方法
		result = proceedingJoinPoint.proceed();
		//返回通知
		System.out.println(String.format("%s return %s", name, result));
	} catch (Throwable throwable) {
		//异常通知
		System.out.println(String.format("%s occur exception: %s", name, 			throwable.toString()));
	}
	//后置通知
	System.out.println(String.format("%s end", name));
	//代理对象的执行相应方法的返回值
	return result;
}
```











