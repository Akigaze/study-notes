## JdbcTemplate

> ```java
> org.springframework.jdbc.core.JdbcTemplate
> ```

要使用JdbcTemplate，需要引入 `spring-jdbc` 依赖包

### 配置

#### 1. 配置JdbcTemplate bean

```xml
<!-- 配置JDBCTemplate bean -->
<bean id="jdbc-template-1" class="org.springframework.jdbc.core.JdbcTemplate">
	<property name="dataSource" ref="c3p0-data-source"/>
</bean>
```

要实现JdbcTemplate的功能，需要一个 `DataSource` 的成员变量连接数据库资源

#### 2. 配置 c3p0 DataSource

```xml
<!-- 导入资源文件 -->
<context:property-placeholder location="classpath:db-config.properties"/>
<!-- 配置c3p0数据源 -->
<bean id="c3p0-data-source" class="com.mchange.v2.c3p0.ComboPooledDataSource">
    <property name="user" value="${jdbc.user}"/>
    <property name="password" value="${jdbc.password}"/>
    <property name="jdbcUrl" value="${jdbc.jdbcUrl}"/>
    <property name="driverClass" value="${jdbc.driverClass}"/>
    <property name="initialPoolSize" value="${jdbc.initialPoolSize}"/>
    <property name="maxPoolSize" value="${jdbc.maxPoolSize}"/>
</bean>
```

在 `.properties` 文件中设置JDBC连接的相关参数：

```properties
jdbc.user = akigaze
jdbc.password = akigaze
# 此处使用的mysql和jdbc的版本为8.0以上
jdbc.driverClass = com.mysql.cj.jdbc.Driver
jdbc.jdbcUrl = jdbc:mysql://localhost:3306/jdbc-template?useUnicode=true&characterEncoding=UTF-8&serverTimezone=UTC
jdbc.initialPoolSize = 5
jdbc.maxPoolSize = 10
```

### JdbcTemplate 常用方法

#### 1. int update(String sql, Object... args)

`update` 方法有很多重载，支持 `update`  `insert`  `delete` 操作，只执行一次SQL

- sql：要执行的SQL语句，使用 `?` 作为占位符
- args：SQL语句中站位符的值

```java
String updateLisiDepartmentId = "update employee set name = ? where id = ?";
jdbcTemplate1.update(updateLisiDepartmentId, "akigaze", 1);
```

#### 2. int[] batchUpdate(String sql, List<Object[]> batchArgs)

批量update的操作，根据batchArgs列表的长度执行相应次数的SQL

- batchArgs：每一次执行SQL语句所需要的参数为一个Object数组

```java
String insertEmployee = "insert into employee(name, gender, department_id) values(?, ?, ?)";
List<Object[]> args = new ArrayList<>();
args.add(new Object[]{"huang", "man", 1});
args.add(new Object[]{"akigaze", "man", 2});
args.add(new Object[]{"quinn", "woman", 3});
jdbcTemplate1.batchUpdate(insertEmployee, args);
```

#### 3. T queryForObject(String sql, RowMapper\<T> rowMapper, Object... args)

执行一个select语句，将查询结果封装成对象返回

- rowMapper：指定返回对象的类型，`BeanPropertyRowMapper` 是它的一个实现类，其中查询结果的字段名必须和返回类型的字段名一致

```java
String getEmployeeIdIs1 = "select id, name, gender sex from employee where id = ?";
RowMapper<Employee> rowMapping = new BeanPropertyRowMapper<>(Employee.class);
Employee employee = jdbcTemplate1.queryForObject(getEmployeeIdIs1, rowMapping, 1);
```

#### 4. T queryForObject(String sql, Class\<T> requiredType)

只查询一个属性值或一个聚合查询的值

- requiredType：返回值的类型，一般是基本数据类型的包装类或String

```java
String rowCount = "select count(*) from employee";
Integer count = jdbcTemplate1.queryForObject(rowCount, Integer.class);
```

#### 5. List\<T> query(String sql, RowMapper\<T> rowMapper, Object... args)

执行一次select语句，返回对条记录，用法与 `queryForObject(String sql, RowMapper\<T> rowMapper, Object... args)` 相同，只是返回值是一个列表

```java
String getEmployeesIdMoreThan = "select id, name, gender sex from employee where id > ?";
RowMapper<Employee> rowMapping = new BeanPropertyRowMapper<>(Employee.class);
List<Employee> employees = jdbcTemplate1.query(getEmployeesIdMoreThan, rowMapping, 3);
```



## NamedParameterJdbcTemplate

> ```java
> org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate
> ```

`NamedParameterJdbcTemplate` 是对jdbcTemplate的另一种实现，提供了相比 `JdbcTemplate` 更便捷的方法

它允许在SQL语句中使用具体有意义的字符串作为占位符，具体形式为 `:name`

### 配置

与 `JdbcTemplate` 相似，但是因为没有无参构造方法，所以必须使用 `<constructor-arg>` 为其传递一个 DataSouce的引用

```xml
<!-- 配置具名参数的JDBCTemplate bean NamedParameterJdbcTemplate -->
<bean id="named-param-jdbc-template" class="org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate">
    <constructor-arg ref="c3p0-data-source"/>
</bean>
```

### NamedParameterJdbcTemplate常用方法

#### 1. int update(String sql, Map<String, ?> paramMap)

- paramMap：使用Map为SQL语句中的具名占位符设置值，Map中 key 的值要与 占位符的字符串相同

```java
String insertNewEmploy = "insert into employee (name, gender) values (:name, :sex)";
Map<String, String> argMap = new HashMap<>();
argMap.put("name", "花花");
argMap.put("sex", "女");
jdbcTemplate.update(insertNewEmploy, argMap);
```

#### 2. int update(String sql, SqlParameterSource paramSource)

使用面向对象的方式为具名占位符设置值，将对象的属性与表的字段做映射

- paramSource：解析一个实体对象，为SQL语句的占位符赋值，`BeanPropertySqlParameterSource` 是它的一个实现类

```java
String insertNewEmploy = "insert into employee (name, gender) values (:name, :sex)";
Employee employee = new Employee();
employee.setName("wang hua hua");
employee.setSex("gent men");
SqlParameterSource paramSource = new BeanPropertySqlParameterSource(employee);
jdbcTemplate.update(insertNewEmploy, paramSource);
```

