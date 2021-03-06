package variable

def clouser = { String name, int age -> println "Hello ${name}! Age is ${age}"}
clouser.call('groovy', 20)
def name = 'hunk'
clouser(name,2)

// 隐式参数
clouser = { println "Hello ${it}"}
def r1 = clouser(name)
//println r1

clouser = { String n1 ->
    return "Hello ${n1}"
}
def result = clouser('l123456')
//println result

// 用来求指定number的阶乘
int fab(int number){
    int result = 1
    1.upto(number, {num -> result *= num})
    return result
}

int fab2(int number){
    int result = 1
    number.downto(1){
        num ->result *= num
    }
    return result
}

int cal(int number){
    int result =0
    number.times {
        num -> result+=num
    }
    return result
}

int x = fab(5)
//println x
int y = fab2(5)
//println y
int z = cal(101)
//println z

// 字符串与闭包的结合使用
String str = 'the 2 and 3 is 5'
// each的遍历
println  str.each {
//    String temp -> print temp.multiply(2)
}

// find来查找符合条件打的第一个
def num = str.find {
    String s -> s.isNumber()
}
//println num

def list = str.findAll {
    String s -> s.isNumber()
}
//println list.toListString()

def any = str.any {
    String s -> s.isNumber()
}
//println any

def every = str.every {
    String s -> s.isNumber()
}
//println every

def list2 = str.collect { it.toUpperCase()}
//println list2

/**
 * 闭包的三个重要变量：this， owner，delegate
 */
def scriptClouser ={
    println "scriptClouse this:" + this // 代表闭包定义处的类
    println "scriptClouse owner:" + owner // 代表闭包定义处的类或者对象
    println "scriptClouse delegate:" + delegate // 代表任意对象，默认与owner一致
}
//scriptClouser.call()

// 定义一个内部类
class Person{
    def static classClouser = {
        println "classClouser this:" + this // 代表闭包定义处的类
        println "classClouser owner:" + owner // 代表闭包定义处的类或者对象
        println "classClouser delegate:" + delegate // 代表任意对象，默认与owner一致
    }

    def  static say(){
        def  classClouser = {
            println "methodClouse this:" + this // 代表闭包定义处的类
            println "methodClouse owner:" + owner // 代表闭包定义处的类或者对象
            println "methodClouse delegate:" + delegate // 代表任意对象，默认与owner一致
        }
        classClouser.call()
    }
}
//Person.classClouser.call()
//Person.say()

// 定义一个内部类
class Person2{
    def  classClouser = {
        println "classClouser this:" + this // 代表闭包定义处的类
        println "classClouser owner:" + owner // 代表闭包定义处的类或者对象
        println "classClouser delegate:" + delegate // 代表任意对象，默认与owner一致
    }

    def   say(){
        def  classClouser = {
            println "methodClouse this:" + this // 代表闭包定义处的类
            println "methodClouse owner:" + owner // 代表闭包定义处的类或者对象
            println "methodClouse delegate:" + delegate // 代表任意对象，默认与owner一致
        }
        classClouser.call()
    }
}
Person2 p = new Person2()
//p.classClouser.call()
//p.say()

// 闭包中定义闭包
def netsClouser = {
    def innerClouser = {
        println "innerClouser this:" + this // 代表闭包定义处的类
        println "innerClouser owner:" + owner // 代表闭包定义处的类或者对象
        println "innerClouser delegate:" + delegate // 代表任意对象，默认与owner一致
    }
    innerClouser.delegate = p // 修改默认的delegate
    innerClouser.call()
}
//netsClouser.call()

// 闭包中委托类
class Student {
    String name
    def  pretty = { "My name is ${name}" }

    String toString(){
        pretty.call()
    }
}

class Teacher {
    String name
}

def stu = new Student(name: 'hunker')
def tea = new Teacher(name: 'Qndroid')
stu.pretty.delegate = tea
stu.pretty.resolveStrategy = Closure.DELEGATE_FIRST
println stu.toString()
