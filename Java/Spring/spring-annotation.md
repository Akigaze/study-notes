## component scanning(组件扫描)
Spring自动扫描 **classpath** 下具有特定注解的类组件，并进行实例化，加入IOC容器中.

### context:component-scan
在Spring的 `.xml` 配置文件中，导入 `context` 名称空间，使用 `<context:component-scan>` 标签设置包扫描，使用时还需要导入 `spring-aop` 包的依赖。
- `base-package`: 指定扫描的包，Spring会扫描指定包中的类和 **子包** 中的所有类。
- `resource-pattern`: 指定要真正要扫描的包中的资源，相对于 `base-package` 指定的包的相对路径，要使用 **路径** 的写法，并且是指定 `.class` 文件。

#### Example
```xml
<context:component-scan base-package="com.annotations"
     resource-pattern="repositorys/imlps/*.class"/>
```

- `use-default-filters`: Spring的组件扫描有默认的注解扫描规则，只识别 `Component`，`Repository`，`Service`，`Controller` 这四个注解，默认情况的值是 `true`，设置成 `false` 之后可以使用 `<context:include-filter>` 和 `<exclude-filter>` 设置要扫描的注解

### context:include-filter
`<context:component-scan>` 的子组件，指定扫描组件所要识别的 **注解** 或 **类**，但不排斥Spring扫描其他注解。
- `type`: 扫描的类型，包括 `annotation` 注解和 `assignable` 类等
- `expression`: 根据 `type` 指定的类型，设置需要扫描的注解或类的 **全类名**

`<context:include-filter>` 要放置在 `<context:exclude-filter>` 之前

### context:exclude-filter
与 `<context:include-filter>` 相似，但是是指定Spring排除扫描的注解或类

## Annotation for component scanning
- @Component
- @Repository
- @Service
- @Controller

这几个注解属于 `org.springframework.stereotype` 包，添加在类上，用于Spring进行包扫描时识别标示的类。

## Bean Naming Strategy
- 非限定类名：类名首字母小写，默认Bean的命名策略
- value：注解(`Component`，`Repository`，`Service`，`Controller`)中的 `value` 属性可以设置Bean的名称

## Bean Injection
`<context:component-scan>` 标签会注册一个 `AutowiredAnnotationBeanPostProcessor` 对象，为对象注入属性，它会识别 `@Autowired`，`@Resource` 和 `@Inject` 注解的属性，从IOC容器中为其注入适当的bean对象
### @Autowired
**Autowired 是通过反射的方式注入属性的**

- 用于 **属性**，有参数的 **构造方法** 和 **普通方法**
- 默认情况下所有添加 `@Autowired` 注解的属性或变量都必须有值注入
- 注入bean时，按照类型兼容，**bean名称** 与 **属性名称** 相同优先的原则注入属性

属性：
1. `required`: 是否是必须注入bean，默认为 `true`，设置为 `false` 时，若没有合适的bean，则可以不注入: `@Autowired(required = false)`

### @Qualifier
为属性指定允许注入的bean的名称：`@Qualifier(value = "bookCrudRepository")`

## Genericitys Injection(泛型注入)
从Spring4.0之后，开始支持泛型的依赖注入。

在bean的属性注入时，Spring会选择泛型类型相同的bean作为属性进行注入

#### Example
```java
//父类
public abstract class BaseService<T> {
    @Autowired
    protected BaseRepository<T> repository;
    protected abstract void find();
}

public abstract class BaseRepository<T> {
    @Autowired
    protected T element;
    protected abstract void findOne();
}

//子类
@Service
public class UserService extends BaseService<User> {
    @Override
    public void find() {
        System.out.println("Service find...");
        this.repository.findOne();
    }
}

@Repository
public class UserRepository extends BaseRepository<User> {
    @Override
    public void findOne() {
            System.out.println("Repository find...");
            System.out.println(element);
    }
}

public static void main(String[] args) {
    ApplicationContext context = new ClassPathXmlApplicationContext("bean-genericity.xml");
    UserService service = (UserService) context.getBean("userService");
    service.find();
}
```
````
