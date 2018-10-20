## 封装  
从现实的事物抽取出相同的属性和行为，封装成一个类，而用户不必了解类内部的具体结构，只需通过类对外开发的接口访问和使用类即可。
```java
public class Person {
  private int id;
  private String name;
  private int age;
  public Person(int id, String name, int age) {
    this.id = id;
    this.name = name;
    this.age = age;
  }
  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }
}
```
通过Person的构造方法，将数据封装为一个整体，只通过`getName`和`setName`这些对外开放的方法访问类的属性。

---
## 继承  
继承是一个类对另一个类的扩展，子类可以继承父类的方法和属性，同时，子类可以有自己新的属性和新的方法，又可以重写父类的方法，实现自己独特的行为。
```java
public class Teacher extends Person{
  private Klass klass;

  public Teacher(int id, String name, int age, Klass klass) {
    super(id, name, age);
    this.klass=klass;
  }

  @Override
  public String introduce() {
    return String.format("%s I am a Teacher. %s",super.introduce(),classIntroduce());
  }

  public String introduceWith(Student stu){
    if (klass.equals(stu.getKlass())){
      return String.format("%s I am a Teacher. I teach %s.",super.introduce(),stu.getName());
    }else {
      return String.format("%s I am a Teacher. I don't teach %s.",super.introduce(),stu.getName());
    }
  }
}
```
Teacher类继承了Person类，所以他拥有了Person的`id`，`name`，`age`属性和`introduce`方法，同时，Teacher类有了自己的新属性`klass`和新的方法`introduceWith`；Teacher类重写了Person类的`introduce`方法，有了自己的自我介绍。在自类中，`super`关键字指代父类的对象，可以用该关键字调用已经被重写的父类方法。

---
## 多态
一类事物(父类)可能有多种形态(子类)，这些形态都属于统一类事物，都具有共同的行为，即父类可以引用子类的对象，但是不同形态之间同一行为的具体表现却是不同的。

```java
public class Person {
  private int id;
  private String name;
  private int age;
  public String introduce(){
    return String.format("My name is %s. I am %d years old.",this.name,this.age);
  }
}
```
```java
public class Teacher extends Person{
  private Klass klass;
  @Override
  public String introduce() {
    return String.format("%s I am a Teacher. %s",super.introduce(),classIntroduce());
  }
}
```
```java
public class Student extends Person {
  private int klass;
  @Override
  public String introduce() {
    return String.format("%s I am a Student. I am at Class %d.",super.basicIntroduce(),klass);
  }
}
```
Teacher类和Student类都是Person类的子类，都具有自我介绍(`introduce`)的行为,但是这两个类的`introduce`的方式却不同。
```java
Person mike=new Student(1,"Mike",18);
Person smith=new Teacher(2,"Smith",38);
mike.introduce();
smith.introduce();

```
对于Teacher类的对象smith和Student类的对象mike，他们都是Person，是Person类的对象。但是在做自我介绍这个行为上

--------
## 单一职责
依据需求，根据需要实现的Task，每个类、每个方法只实现一个功能，而一个方法的功能除了体现在具体的实现代码上，还体现在方法的命名上。
```java
public class Klass {
  public boolean isIn(Student stu){
    return this.equals(stu.getKlass());
  }
  public void assignLeader(Student stu){
    if (isIn(stu)){
      this.leader=stu;
    }else {
      System.out.print("It is not one of us.\n");
    }
  }
}
```
klass类的`assignLeader`方法用于设置一个学生为班长，在设置班长时，需要判断学生是否属于这个班，而如何判断一个学生是否属于某个班这个并不属于`assignLeader`的主要功能，所以另外实现`isIn`方法，用于判断一个学生是否属于这个班。

---
## 里氏代换
所有引用基类（父类）的地方必须能透明地使用其子类的对象。这是一种多态体现，在需要依赖父类的地方，使用其子类也同样能使程序正常运作，即父类可以完成的工作，子类也可以完成。
```java
public class Klass{
  ...
  public void registerAssignLeaderListener(AssignLeaderListener listener){
    this.assignLeaderListenerList.add(listener);
  }
  public void registerAppendMemberListener(AppendMemberListener listener){
    this.appendMemberListenerList.add(listener);
  }
  ...
}
```
```java
public class Teacher extends Person
  implements AssignLeaderListener, AppendMemberListener {

  public Teacher(int id, String name, int age, LinkedList<Klass> classes) {
    super(id, name, age);
    this.classes = classes;
    this.classes.forEach(c ->{
      c.registerAssignLeaderListener(this);
      c.registerAppendMemberListener(this);
    });
  }
}
```
Klass类的`registerAssignLeaderListener`和`registerAppendMemberListener`需要依赖`AssignLeaderListener`和`AppendMemberListener`类型的参数，而Teacher类实现了这两个接口后，这两个方法同样可以接受`Teacher`类型的参数，完成功能。

---
## 接口隔离  
一个类对另一个类的依赖应该建立在最小的接口上，即建立单一接口，不要建立庞大臃肿的接口，尽量细化接口，接口中的方法尽量少。也就是说，我们要为各个类建立专用的接口，而不要试图去建立一个很庞大的接口供所有依赖它的类去调用。
```java
public interface AssignLeaderListener {
  public void notifyAssignLeader(Student stu, Klass clz);
}
```
```java
public interface AppendMemberListener {
  public void notifyAppendMember(Student stu, Klass clz);
}
```
对于监听“选举班长”和“新同学加入”两种行为，通过构建两个接口，每个接口中只有一个方法，用于发送相应的通知。
```java
public class Klass{
  private List<AssignLeaderListener> assignLeaderListenerList=new ArrayList<>();
  private List<AppendMemberListener> appendMemberListenerList=new ArrayList<>();
  public void registerAssignLeaderListener(AssignLeaderListener listener){
      this.assignLeaderListenerList.add(listener);
  }
  public void registerAppendMemberListener(AppendMemberListener listener){
      this.appendMemberListenerList.add(listener);
    }
  ...
}
```
在Klass类不直接与Teacher类进行交互，而是与Teacher类实现的两个接口`AssignLeaderListener`和`AppendMemberListener`进行，因此在Klass类中只能依赖Teacher实现的`notifyAppendMember`和`notifyAssignLeader`

---
## 开闭原则
对扩展开放，对修改关闭。通过子类的继承和重写，实现对父类功能的扩展，而不是在父类中修改原有的方法。
```java
public class Person{
  protected String basicIntroduce(){
    return String.format("My name is %s. I am %d years old.",this.name,this.age);
  }
  public String introduce(){
    return basicIntroduce();
  }
}
```
```java
public class Teacher extends Person{
  @Override
  public String introduce() {
      return String.format("%s I am a Teacher. %s",super.introduce(),classIntroduce());
  }
}
```
Person类通过将`introduce`方法设置为公开，使Teacher类能继承重写`introduce`，达到扩展方法功能的效果，而不用修改原有Person的方法。

------------

## 依赖倒置
两个类之间避免直接的依赖（调用），对类之间的依赖进行抽象，提取为接口，类与类之间通过接口进行依赖，以此减少类之间的耦合度。
```java
public class Klass{

  private List<AppendMemberListener> appendMemberListenerList=new ArrayList<>();

  public void appendMember(Student stu){
    stu.setKlass(this);
    this.appendMemberListenerList.forEach(l -> l.notifyAppendMember(stu,this));

    }
  }
```
```java
public class Teacher extends Person implements AppendMemberListener {

  @Override
  public void notifyAppendMember(Student stu, Klass clz) {
      System.out.printf("I am %s. I know %s has joined %s.\n",this.getName(),stu.getName(),clz.getDisplayName());
  }
}
```
在Klass类中，只拥有“监听新增班级成员”这个接口的引用，而不是直接对Teacher进行引用，以此减少Teacher在Klass类中的存在感，Klass所具有的只是Teacher类的部分功能，即`AppendMemberListener`接口的功能。

----
## 迪米特法则
一个对象应该对其他对象保持最少的了解。若类与类之间的关系越密切，耦合度越大，当一个类发生改变时，对另一个类的影响也越大。一个类应避免对另一个有过于深入的访问，仅仅只是使用其公开的接口为止。
```java
public class Klass{
  public boolean isIn(Student stu){
    return this.equals(stu.getKlass());
  }
}
```
`isIn`方法并没有采用`stu.getKlass.equals(this)`的方式做判断，减少对Student类的成员变量的有过于深入的访问。
