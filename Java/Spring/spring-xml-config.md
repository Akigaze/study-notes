# XML Tag of Spring Config
## <beans\>

## <bean\>
1. class: 全类名，Spring会通过反射的方式创建bean，因此该类需要有一个 **无参构造方法**
2. id: bean的唯一标示，相当于对象名，在配置文件中是唯一的

## <property\>
1. name: 类的属性名
2. value: 属性值

## <constructor-arg\>
1. value: 传入构造方法的值
2. index: 参数的位置，从0开始
3. type: 参数类型，使用全类名

对构造方法中的每一个参数，需要单独写一个 `<constructor-arg>` 标签。

## <value\>
替代其他标签中的 `value` 属性，作为替他标签的子标签使用；通常只有基本数据类型及其包装类型和字符串等字面值才能使用；value的值作为标签的内容；如果value字面值有特殊字符，可以使用 `<![CDATA[...]]>` 进行转义。

#### Example
```xml
<!-- value = "<BMW^>" -->
<constructor-arg index="0">
    <value><![CDATA[<BMW^>]]></value>
</constructor-arg>
```

## <ref\>
1. bean: 指定引用的bean的id

与 `<value>` 标签相似， 用于替代标签的 `ref` 属性作为子标签，但引用的id并不作为标签的内容，而是写在 `bean` 属性。

## <null\>
专指 `null` 值，作为 `<property>`、 `<constructor-arg>` 或 `<value>` 等标签的内容，表示注入一个null值。

## <list\>
相当于 `java.util.List`，用于创建集合bean，内部可以使用 `<bean>`，`<ref>` 或者 `<value>` 添加元素。
#### Example
```xml
<list>
    <ref bean="bmw"/>
    <ref bean="bench"/>
    <bean class="com.beans.injection.Car">
        <constructor-arg value="Honda" index="0"/>
        <constructor-arg value="250" type="int"/>
    </bean>
</list>
```

## <set\>
与 `<list>` 标签相似，相当于 `java.util.Set`。

## <map\>
用于创建 `java.util.Map` 类型的bean对象，要使用 `<entry>` 子标签配置元素。

## <entry\>
配置一个键值对，一般作为 `<map>` 标签的子标签

1. key: 指定key的值，一般是key为字符串等字面量时使用
2. value: 指定字符串等字面量类型的值为value
3. key-ref: 引用某一个bean的id作为key
4. value-ref: 引用某一个bean的id作为value

#### Example
```xml
<map>
    <entry key="hong" value-ref="Jam"/>
    <entry key="huang" value-ref="Sam"/>
    <entry key="blue">
        <bean class="com.beans.injection.Person">
            <property name="name" value="Kid"/>
            <property name="age" value="18"/>
            <property name="car">
                <null/>
            </property>
        </bean>
    </entry>
</map>
```

## <props\>
创建 `java.util.Properties` 类型的bean，使用 `<prop>` 子标签添加每一个属性的key和值。

## <prop\>
`<props>` 的子标签，用于指定key和值，key是标签的一个属性，值是标签的内容，两个都是字面量。

## Example
```xml
<props>
    <prop key="user">root</prop>
    <prop key="pwd">pwd123</prop>
    <prop key="jdbcurl">jdbc:mysql://hwang</prop>
    <prop key="driver">com.mysql.jdbc.Driver</prop>
</props>
```

# namespace of  Spring XML Config
## util namespace
需要在 `<beans>` 标签中加入以下名称空间的url
> xmlns:util="http://www.springframework.org/schema/util"  
xsi:schemaLocation="http://www.springframework.org/schema/util http://www.springframework.org/schema/util/spring-util.xsd"

使用时，以 `<util:tag>` 的形式，引入该名称空间的标签。
### tags
1. `<util:list>`: 相当于 `<list>` 标签
2. `<util:set>`: 相当于 `<set>` 标签
3. `<util:map>`: 相当于 `<map>` 标签
4. `<util:properties>`: 相当于 `<props>` 标签
5. `<util:property-path>`
6. `<util:constant>`

#### Example
```xml
<util:list id="cars" >
    <ref bean="bench"/>
    <ref bean="bmw"/>
    <bean id="toyota" class="com.beans.injection.Car">
        <constructor-arg value="Toyota" index="0"/>
        <constructor-arg value="180" type="int"/>
    </bean>
</util:list>
```

## p namespace
需要在 `<beans>` 标签中加入以下名称空间的url
> xmlns:p="http://www.springframework.org/schema/p"

### feature
- 简化bean的属性配置
- 不写标签的情况下，直接在 `<bean>` 标签中通过标签属性的方式为bean的属性赋值
- 不是一个标签的名称空间，所以无需在 `xsi:schemaLocation` 添加它的名称空间url和xsd
- 要求类的属性要有相应的 setter，并且最好有无参构造方法

### p property
-  自动读取bean的属性，为 `<bean>` 标签生成属性
- `p:property` 的形式指代bean对象的属性，可以赋予字面量的值
- `p:property-ref` 的形式，可以引用其他bean的id作为属性的值

#### Example
```xml
<bean id="ma-yun" class="com.beans.injection.Millionaire"
    p:name="Ma Yun" p:age="50" p:asset="100000000" p:cars-ref="cars">
</bean>
```
