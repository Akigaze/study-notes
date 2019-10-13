console.log("1.1 全局变量调用");

console.log('在全局变量中，`this` 指向 `window` 对象，而 `var` 定义的变量都会被绑定到 `window` 对象上');
let owner1 = {
    foo: function() { console.log(this.bar1) },
    bar1: "I am foo Owner."
}
var bar1 = "I am Global."

let foo1 = owner1.foo
let fuzzy1 = function() { console.log(this.bar1);}

fuzzy1()  //I am Global.
foo1()  //I am Global.

console.log('`let` 或者 `const` 定义的变量都不会被自动绑定到任何对象上，因此即使是在全局环境中，`let` 或者 `const` 定义的变量也不是 `window` 变量的属性');
let owner2 = {
    foo: function() { console.log(this.bar2) },
    bar2: "I am foo Owner."
}
let bar2 = "I am Global."

let foo2 = owner2.foo
let fuzzy2 = function() { console.log(this.bar2) }

fuzzy2()  //undefine
foo2()  //undefine

console.log('在不使用 `this` 的情况下，js解释器会在上下文环境中找到最近的一个定义的同名变量');
let owner3 = {
    foo: function() {let bar3 = "..."; console.log(bar3) },
    bar3: "I am foo Owner."
}
let bar3 = "I am Global."

let foo3 = owner3.foo
let fuzzy3 = function() { console.log(bar3) }

fuzzy3()  //I am Global.
foo3()  //...

console.log('\n');
console.log("1.2 对象方法调用");
let apple = {
    color: "red",
    mature: function(){ console.log(`The apples are ripe and ${this.color}`) }
}

color = "green"
apple.mature()


console.log("在对象方法调用中，也可以通过 `this` 新增或修改对象的属性");
let worker = {
    age: 20,
    report: function(){
        this.age = 30
        this.name = 'Xiao Ming'
        console.log(`I am ${this.name}, ${this.age} years old.`);
    }
}

worker.report()
console.log(worker.age);
console.log(worker.name);
worker.report.apply()

console.log('\n');
console.log("1.3 函数做为构造方法调用");

let dog = function(){
    console.log(this.type);
    this.type = 'Corgi'
    console.log(this.type);
}

var type = 'papillon'
let corgi = new dog()
console.log(corgi.type);
console.log(type);

console.log("\n");
console.log("1.4 使用函数的 `apply` 方法调用");
let book = {
    totalPages: 100,
    message: function(){console.log(`I have total ${this.totalPages} pages.`)}
}
var totalPages = 200
book.message.apply()
book.message.apply(book)
