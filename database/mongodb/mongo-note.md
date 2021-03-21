### 安装
1. 官网下载地址，偶数为稳定版  
![Official of MongoDB](https://www.mongodb.com/try/download/community)

2. 配置环境变量（bin）

### 启动数据库服务
> mongod --dbpath C:\data\db --port 12707

### 连接数据库
> mongo


### docker for mongo
https://hub.docker.com/_/mongo/

> docker pull mongo:latest

> docker run -d -p 27017:27017 -v /home/akigaze/tools/docker/mongodb/data:/data/db -v /home/akigaze/tools/docker/mongodb/conf:/etc/mongo --name mongo-ubuntu mongo:latest --auth

> docker exec -it mongo-ubuntu bash

### 使用
> 进入某个数据库  
mongo <db-name>

> 切换或创建数据库
use <db-name>

> 创建数据库用户
db.createUser({user: 'root', pwd: 'root', roles: [{role: 'root', db: 'admin'}]})
> 授权当前数据库, 相当于使用指定用户登录
db.auth('<user>', '<pwd>')

> 显示所有数据库
show dbs

> 显示当前数据库
db

### CRUD
https://docs.mongodb.com/manual/crud/  

#### insert
https://docs.mongodb.com/manual/tutorial/insert-documents/


1. db.<collection-name>.insertOne(json)
2. db.<collection-name>.insertMany([json1, json2])
3. 1&2的综合 db.<collection-name>.insert(json)

> example
$ db.students.insertOne({'name': 'king', 'age': 15, 'gender': 'male'})
{
        "acknowledged" : true,
        "insertedId" : ObjectId("6056b30d646cb99a821ea9b0")
}

$ db.students.insertMany([
    {'name': 'queue', 'age': 14, 'gender': 'female'}, 
    {'name': 'jackson', 'age': '12', 'gender': 'male'}
  ])
{
        "acknowledged" : true,
        "insertedIds" : [
                ObjectId("6056b38b646cb99a821ea9b1"),
                ObjectId("6056b38b646cb99a821ea9b2")
        ]
}

mongo 服务器会自动为cocument创建唯一id(`_id`)，使用 `ObjectId()` 函数生成，也可以插入document时手动指定 `_id`

#### query
1. 使用 `find(criteria)` 函数，criteria 是一个json对象，用于指定过滤字段的条件
2. `findOne(criteria)` 只返回符合条件的第一个document
3. mongo的查询结果返回的是json对象或数组，支持js中对数组和对象的操作
4. find(criteria).count() 获取结果数量

##### 查询全部
> $ db.students.find()
{ "_id" : ObjectId("6056b30d646cb99a821ea9b0"), "name" : "king", "age" : 15, "gender" : "male" }
{ "_id" : ObjectId("6056b38b646cb99a821ea9b1"), "name" : "queue", "age" : 14, "gender" : "female" }
{ "_id" : ObjectId("6056b38b646cb99a821ea9b2"), "name" : "jackson", "age" : "12", "gender" : "male" }

##### 查询特定字段
find(criteria, filedSet)
fieldSet: {<field>: 1, <field>: 0, ...}

##### equal条件查询
> 查询条件 { <field1>: <value1>, ... }  
$ db.students.find({gender: 'male', age: 12})

##### 单目条件查询, 如 in
> { <field1>: { <operator1>: <value1> }, ... }

##### 双目条件查询，如 or
> { $or: [ { <field1>: <value1>, ... }, { <field1>: <value1>, ... } ]

##### array 查询
1. array 相同
> { <array-field>: [<value>, ...] } 
2. array 包含某个元素
> { <array-field>: <value> } 
3. array 包含某几个元素
> { <array-field>: { $all: [<value>, ...] } }

##### 内嵌文档查询
内嵌文档：字段的值是一个json的，则这个json称为内嵌文档
运行通过 `.` 获取内嵌文档的字段，但此时整个字段就会是一个表达式，因此需要加引号
> { '<field>.<内嵌文档字段>': <value> } 


#### update
1. updateOne(criteria, update)
2. updateMany(criteria, update)
3. replaceOne(criteria, newObject)
4. update: {<update operator>: { <field1>: <value1>, ... }}

update 操作符：
1. $set：修改或新增字段
2. $unset：删除字段
3. $push: 向数组添加元素
4. $addToSet: 向数组添加元素，若元素已存在，则不添加

#### delete
1. deleteOne(criteria)
2. deleteMany(criteria)
3. remove(criteria, justOne=false)

criteria 不允许为空，若为 {} 表示删除全部，但是性能较差，因为是逐个删除的

####
1. limit(<number>) 限制数量
2. skip(<number>) 跳过前那条数据
当skip和limit同时使用时，mongo会自动调整执行顺序，保证先执行skip，再执行limit
3. sort({<field>: 1, <field>: -1}) 排序条件，1为正序，-1为倒序


### collection operation
删除集合
> db.<collection-name>.drop()

### database operation
删除数据库
> db.dropDatabase()


### 概念
database > collection > document  
database 和 collection不需要手动创建，mongo服务器会在需要时自动创建，但此时并没有真正创建数据库或集合，只有当存储有数据是才会真正去创建


### springboot and mongDB
1. import library
```groovy
  implementation 'org.springframework.boot:spring-boot-starter-data-mongodb'
```

2. create entity
```java
@Document("books")
public class Book {
  @Id
  private String id;
  ....
}
```

3. implement MongoRepository
```java
public interface BookRepository extends MongoRepository<Book, String>
```

4. springboot config for mongoDB server
```yml
spring:
  data:
    mongodb:
      host: 192.168.31.81
      port: 27017
      authentication-database: test
      username: test-user
      password: Password1
#      uri: mongodb://test-user:Password1@192.168.31.81:27017/test?authSource=test&readPreference=primary&ssl=false
```


>
1.数据库用户角色：read、readWrite;
2.数据库管理角色：dbAdmin、dbOwner、userAdmin；
3.集群管理角色：clusterAdmin、clusterManager、clusterMonitor、hostManager；
4.备份恢复角色：backup、restore
5.所有数据库角色：readAnyDatabase、readWriteAnyDatabase、userAdminAnyDatabase、dbAdminAnyDatabase
6.超级用户角色：root
