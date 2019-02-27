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
