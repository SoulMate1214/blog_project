INSERT INTO blog_project.sys_article (id, name, message, browse_count, like_count, classify_id, sort, status, remark, is_enable, create_time, modify_time, create_user, modify_user) VALUES (1, '系列文章之JDK8新特性(一)', '# JDK8新特性
**JDK8已经出了好久好久了，我现在才来写特性，惭愧惭愧，本来准备去研究JDK13的，想想还是一步一步来吧，废话不多说，让我们看看都有哪些特性吧？**

### 一.接口篇：
#### 1.static与default接口函数：
大家都知道关于接口“interface”在java中是极其重要的一位，接口的函数/方法默认都是abstract的，也就是抽象的，在jdk8中，新增了两个接口的函数类型，那就是static和default，这两个是干嘛的呢？又有什么区别呢？

- **static**

也被称为静态接口函数，它是可以直接在接口里面写实现的，对比静态/类方法（类中的static函数）我们就能明白，它是可以直接用接口调用的，不需要new一个实现类的对象去调用，因为它本身也不可在实现类里面被@Override重写。如下：

    public interface HeroService {
        static void war(List<Hero> heroList) {
            Optional.ofNullable(heroList).orElse(new ArrayList<>()).forEach(item -> {
                System.out.print(item.getName()+" ");
            });
            System.out.println("和您参与激烈的战斗");
        }
    }

具体函数内容先别管，我们看到，war函数是用static声明的，这就是静态接口函数，调用如下：

	HeroService.war(heroList);

你看，不同于我们平时的调用方式需要new一个实现类的实例去调用（有没有感觉和spring的容器注入的调用方式很像啊，那个也是直接用接口就可以调用实现类里的函数了），这里的原因我也在上面说明了，static是不能在接口实现类里面实现的，你要是硬要在接口实现类写这个同名的函数，那只会被当作另外的和这个接口无关的函数处理。普通调用如下：

	HeroService heroServiceImpl = new HeroServiceImpl();

- **default**

也被称为默认接口函数，和static接口差不多，也是初始时候直接在接口里面能写函数体，但是它不同于static，是可以在实现类里面@Override，也可以不写，随你开心。但是依据这个东西的初衷的话是不建议@Override的，要@Override的话直接用默认的abstract不就好了吗，static和default的初衷就是定义那些不变的接口，定义那些写死的接口，所以没必要去改它，就在interface里面实现就好啦，没必要弄到class里面去实现。如下：

    public interface HeroService {

        default String kill(Hero hero) {
            return "恭喜您，击杀了敌方英雄:" + hero.getName();
        }

        default String assists(Hero killHero, Hero dieHero) {
            return "您帮助队友:" + killHero.getName() + "击杀了敌方英雄:" + dieHero.getName() + ",真是好队友";
        }

        default String die(Hero hero) {
            return "非常不幸，您被敌方英雄:" + hero.getName() + "击杀,再接再厉";
        }
    }

你也可以实现类重写，如下：

    public class HeroServiceImpl implements HeroService {
        @Override
        public String kill(Hero hero) {
            return null;
        }

        @Override
        public String assists(Hero killHero, Hero dieHero) {
            return null;
        }

        @Override
        public String die(Hero hero) {
            return null;
        }
    }

调用的话也和static有区别，它就不能再用接口直接调用咯，和平常一样需要声明实现类的实例去调用，你会发现，咦？我明明没有在实现类里面重写，为啥可以调用呢？这就是default和static的真正作用咯，相当于你写了个公共的接口，不管哪个实现类都会有这些接口

    HeroService heroServiceImpl = new HeroServiceImpl();
    heroServiceImpl.kill(Galen)

##### 关于代码中的Hero类是我自己创建的，你们可以改了。

#### 2.函数式接口：
何为函数式接口？其实它是一种规范，就是说你的接口里面只能有且只有一个abstract函数，也就是普通的函数，当然这里我说的是只能有一个普通函数，你也可以有很多static的函数，有很多default的函数，还可以有个特殊的就是：可以有所有的Object类里面的public的函数,所以，一个函数式接口可以包括四个东西：

- ##### 唯一的一个普通函数（abstract）
- ##### n个static函数
- ##### n个default函数
- ##### 所有的Object类里面的public的函数

如下：

    @FunctionalInterface
    public interface FunctionalService {
        /**
        * 只能有唯一的一个abstract函数
        *
        * @author Soul
        * @date 2020/1/29 16:44
        */
        void create();

        /**
        * 可以有多个default函数
        *
        * @author Soul
        * @date 2020/1/29 16:44
        */
        default void delete() {
        }

        /**
        * 可以有多个static函数
        *
        * @author Soul
        * @date 2020/1/29 16:46
        */
        static void update() {
        }

        /**
        * 可以有所有的Object类里面的public的函数
        * 他们不算是自己写的abstract函数
        *
        * @author Soul
        * @date 2020/1/29 16:47
        */
        boolean equals(Object object);

        String toString();

        int hashCode();
    }

你会发现我接口上面有一个注解@FunctionalInterface，这是干嘛的呢？这其实是JDK8的一个函数式接口检测注解，如果你写上这个注解，你的接口就一定得是函数式接口，不是的话会报错哦。如果不写这个注解但是你的接口又符合函数式接口规范呢，那这个接口同样是一个函数式接口，只是没有严格的去通过注解检测而已，但是为了方便起见建议每写一个函数式接口都加上这个注解，因为要是你一不小心多些了几个接口让它不成为函数式接口咋办。为啥得有函数式接口这个规范呢？有啥用啊？它其实多配合与匿名函数和lambda表达式使用，下面我们具体看，让你彻底理解它的作用。

在这里，我们回忆一下有关多线程开发的知识，要开多线程的话，有四种方法：

- ##### 继承Thread类
- ##### 实现Runnable接口
- ##### 实现Callable接口
- ##### 线程池

在这里，我们回忆一下前三种就行了，线程池自己有兴趣可以去看看。那我们为什么提到它们呢，因为**Runnable接口**和**Callable接口**就是函数式接口，他们其实一直都是函数式接口，但是在jdk8之前是没加@FunctionalInterface标识的，jdk8后就加了@FunctionalInterface作为标识表明它是函数式接口。如下：

    package java.lang;

    @FunctionalInterface
    public interface Runnable {
        void run();
    }

以及

    package java.util.concurrent;

    @FunctionalInterface
    public interface Callable<V> {
        V call() throws Exception;
    }

看见那个@FunctionalInterface没，它标志着这两个接口一定是函数式接口。

- **继承Thread类**

这个大家都知道，多线程开发就是基于这个线程类的，它的操作呢也很简单，只需要new一个Thread，然后start它即可，你也可以重写它的run方法去执行你的线程逻辑，这个代码应该很清楚的，为了方便看，我把实体类，Thread继承类，主函数写在了一起。

    public class PeopleThread extends Thread {
        private String name;
        private int age;

        public PeopleThread(String name, int age) {
            this.name = name;
            this.age = age;
        }

        @Override
        public void run() {
            System.out.println("我是" + name + ",我今年" + age + "岁");
        }

        public static void main(String[] args) {
            PeopleThread peopleThread = new PeopleThread("张三", 18);
            PeopleThread peopleThread1 = new PeopleThread("李四", 20);
            PeopleThread peopleThread2 = new PeopleThread("王五", 25);
            peopleThread.start();
            peopleThread1.start();
            peopleThread2.start();
            System.out.println("张三的线程名称是：" + peopleThread.getName() + ",线程Id为" + peopleThread.getId());
            System.out.println("李四的线程名称是：" + peopleThread1.getName() + ",线程Id为" + peopleThread1.getId());
            System.out.println("王五的线程名称是：" + peopleThread2.getName() + ",线程Id为" + peopleThread2.getId());
        }
    }

- **实现Runnable接口**

这个就比上面的复杂一点点了，因为它实现了Runnable里面的run函数之后还得使用Thread封装过才能实现多线程，其实看源码你会发现Thread类的run函数就是实现于Runnable接口的run函数，在上面的代码你重写run函数和这里的重写run函数其实都是重写一个地方，都是Runnable接口的run函数：

    public class PeopleRunnable implements Runnable {
        private String name;
        private int age;

        public PeopleRunnable(String name, int age) {
            this.name = name;
            this.age = age;
        }

        @Override
        public void run() {
            System.out.println("我是" + name + ",我今年" + age + "岁");
        }

        public static void main(String[] args) {
            PeopleRunnable peopleRunnable = new PeopleRunnable("张三", 18);
            PeopleRunnable peopleRunnable1 = new PeopleRunnable("李四", 20);
            PeopleRunnable peopleRunnable2 = new PeopleRunnable("王五", 25);

            Thread thread = new Thread(peopleRunnable);
            Thread thread1 = new Thread(peopleRunnable1);
            Thread thread2 = new Thread(peopleRunnable2);
            thread.start();
            thread1.start();
            thread2.start();
            System.out.println("张三的线程名称是：" + thread.getName() + ",线程Id为" + thread.getId());
            System.out.println("李四的线程名称是：" + thread1.getName() + ",线程Id为" + thread1.getId());
            System.out.println("王五的线程名称是：" + thread2.getName() + ",线程Id为" + thread2.getId());
        }
    }

你点开Runnable接口的run函数你会发现有很多很多类实现类它，不止是Thread。随便点一个看一看，你会看到基本都是匿名函数，直接new这个接口去实现run函数，如：(这是随便选的Win32ShellFolderManager2类里面的代码)

           Runnable comRun = new Runnable() {
                public void run() {
                    try {
                        Win32ShellFolderManager2.initializeCom();
                        task.run();
                    } finally {
                        Win32ShellFolderManager2.uninitializeCom();
                    }

                }
            };

这就是函数式接口用作匿名函数使用的例子，也许你会说，匿名函数也可以同时实现多个接口的，不一定得是函数式接口啊。那你得想我要是需求只需要实现一个函数，那么匿名函数里面多的函数岂不是无用了？删也不能删，匿名函数如同实现类一样，里面少实现接口里的函数就会报错。

- **实现Callable接口**

如果上面的例子不明显感觉出函数式接口的作用，那么我们继续来看函数式接口在lambda表达式上的应用，这里我们以Callable接口为例，
Callable接口是Runnable的一个增强版，它不同于Runnable的run函数返回值是void，它拥有的是call函数，可以返回一个泛型，同时它也可以做异常处理，通过异常的处理我们可以获取返回值。如下：
（普通形式，里面包含了实体，下面两种形式都直接用了，没有再写）

    public class PeopleCallable implements Callable<String> {
        private String name;
        private int age;

        public PeopleCallable(String name, int age) {
            this.name = name;
            this.age = age;
        }

        @Override
        public String toString() {
            return "PeopleCallable{" +
                    "name=''" + name + ''\\'''' +
                    ", age=" + age +
                    ''}'';
        }

        @Override
        public String call() throws Exception {
            try {
                return "我是" + name + ",我今年" + age + "岁";
            } catch (Exception e) {
                throw new Exception("参数异常");
            }
        }

        public static void main(String[] args) throws Exception {
            PeopleCallable peopleCallable = new PeopleCallable("张三", 18);
            FutureTask<String> futureTask = new FutureTask<>(peopleCallable);
            Thread thread = new Thread(futureTask, "Thread1");
            thread.start();
            try {
                System.out.println(futureTask.get());
            } catch (Exception e) {
                throw new Exception("未能获取到返回值");
            }
        }
    }

（匿名函数形式，实体类直接使用普通形式里面的实体，没有再写）

    public class PeopleCallableAnonymous {
        public static void main(String[] args) {
            FutureTask<String> futureTask = new FutureTask<>(new Callable<String>() {
                @Override
                public String call() throws Exception {
                    try {
                        Set<PeopleCallable> peopleCallableSet = new HashSet<>();
                        peopleCallableSet.add(new PeopleCallable("张三", 18));
                        peopleCallableSet.add(new PeopleCallable("李四", 20));
                        peopleCallableSet.add(new PeopleCallable("王五", 25));
                        Optional.of(peopleCallableSet).orElse(new HashSet<>()).forEach(System.out::println);
                        return peopleCallableSet.toString();
                    } catch (Exception e) {
                        throw new Exception("set集合异常");
                    }
                }
            });
            Thread thread = new Thread(futureTask, "FirstTread");
            thread.start();
            try {
                System.out.println(futureTask.get());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

（lambda形式的，实体类直接使用普通形式里面的实体，没有再写）

    public class PeopleCallableLambda {
        public static void main(String[] args) {
            FutureTask<String> futureTask = new FutureTask<>((Callable<String>) () -> {
                try {
                    Set<PeopleCallable> peopleCallableSet = new HashSet<>();
                    peopleCallableSet.add(new PeopleCallable("张三", 18));
                    peopleCallableSet.add(new PeopleCallable("李四", 20));
                    peopleCallableSet.add(new PeopleCallable("王五", 25));
                    Optional.of(peopleCallableSet).orElse(new HashSet<>()).forEach(System.out::println);
                    return peopleCallableSet.toString();
                } catch (Exception e) {
                    throw new Exception("set集合异常");
                }
            });
            Thread thread = new Thread(futureTask, "FirstTread");
            thread.start();
            try {
                System.out.println(futureTask.get());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

发现没有，普通形式的话我们先重写call函数再使用；匿名函数形式我们是直接再匿名函数里面实现的call函数，（若有多个，也可以实现多个）；而lambda形式的完全看不到call函数的声影，Lambda表达式是如何在java的类型系统中表示的呢？每一个lambda表达式都对应一个类型，通常是接口类型。而“函数式接口”是指仅仅只包含一个抽象方法的接口，每一个该类型的lambda表达式都会被匹配到这个抽象方法。也就是Lambda它唯一实现一个接口的抽象函数。所以说函数式接口是和lambda表达式完美配合的。现在理解函数式接口的用途了吧！

------------

### 每日一类之Date类
**Date**在java上有两个**java.util.Date**和**java.sql.Date**，前者是代码中使用的日期工具类，后者是连接数据库时向数据库传日期时使用的，这里我们主要说的是前者，后者使用是一样的。它的使用很简单，直接实例化就行了，当然它也提供了许多不同参数的构造方法

    import java.util.Date;
    public class TestDate {
        public static void main(String[] args) {
            // 当前时间
            Date d1 = new Date();
            System.out.println("当前时间:");
            System.out.println(d1);
            System.out.println();
            // 从1970年1月1日 早上8点0分0秒 开始经历的毫秒数
            Date d2 = new Date(5000);
            System.out.println("从1970年1月1日 早上8点0分0秒 开始经历了5秒的时间");
            System.out.println(d2);
        }
    }

**getTime**()方法：得到一个long型的整数，这个整数代表从1970.1.1 08:00:00:000 开始每经历一毫秒，增加1

    import java.util.Date;
    public class TestDate {
        public static void main(String[] args) {
            //注意：是java.util.Date;
            //而非 java.sql.Date，此类是给数据库访问的时候使用的
            Date now= new Date();
            //打印当前时间
            System.out.println("当前时间:"+now.toString());
            //getTime() 得到一个long型的整数
            //这个整数代表 1970.1.1 08:00:00:000，每经历一毫秒，增加1
            System.out.println("当前时间getTime()返回的值是："+now.getTime());
            Date zero = new Date(0);
            System.out.println("用0作为构造方法，得到的日期是:"+zero);
        }
    }

**currentTimeMillis**()方法：获取当前日期的毫秒数

    import java.util.Date;
    public class TestDate {
        public static void main(String[] args) {
            Date now= new Date();
            //当前日期的毫秒数
            System.out.println("Date.getTime() \\t\\t\\t返回值: "+now.getTime());
            //通过System.currentTimeMillis()获取当前日期的毫秒数
            System.out.println("System.currentTimeMillis() \\t返回值: "+System.currentTimeMillis());
        }
    }
![5b10e2581cb26.jpg](http://118.25.221.201:1111/articleImage/8326f956576f4ad9afa7fa4f1dd5fc80.jpg)', 6, 0, 1, null, 'http://118.25.221.201:1111/articleImage/8326f956576f4ad9afa7fa4f1dd5fc80.jpg', null, 1, '2020-02-08', '2020-02-08', 'admin', 'admin');
INSERT INTO springboot_project.sys_article (id, name, message, browse_count, like_count, classify_id, sort, status, remark, is_enable, create_time, modify_time, create_user, modify_user) VALUES (2, '系列文章之JDK8新特性(二)', '# JDK8新特性
### 二.Lambda篇：
#### 1.Lambda表达式：
Lambda表达式是JDK8中最重要的一个了，在JDK8之后你会看到一堆Lambda表达式的代码，要是不会那就看不懂别人的代码了。更别说自己写了。前面我们也说过了，Lambda可以很好的兼容函数式接口，它可以取代大部分的匿名内部类，写出更优雅的 Java 代码，尤其在集合的遍历和其他集合操作中，可以极大地优化代码结构。

- #### 1.1 演变

Lambda表达式可以看成是匿名类一点点演变过来，我们现在有一个函数式接口（ps：注意抽象类是无法使用Lambda的哦，若是其中有抽象函数，只能写匿名函数实例化）

    @FunctionalInterface
    public interface Demo<T> {
        T delete(int a, int b);
    }

我们要使用这个接口里面的方法有几种形式：

- **实现类实现方法之后实例化实现类**：
- **匿名函数实例化**
- **Lambda形式**

如：

    // 实现类
    public class DemoImpl implements Demo<Integer> {
        @Override
        public Integer delete(int a, int b) {
            return a - b;
        }
    }
    
    // 实现类形式调用
    Demo<Integer> demo = new DemoImpl();
    System.out.println(demo.delete(10, 20));

再来看看匿名函数形式的调用：

    // 匿名函数调用
    Demo<Integer> demo1 = new Demo() {
        @Override
        public Integer delete(int a, int b) {
            return a - b;
        }
    };
    System.out.println(demo1.delete(20, 10));

上面的匿名函数我们可以去去它的壳，只保留方法参数和方法体，参数和方法体之间加上符号 ->，你会问，我都没有指定方法名呀？因为你只有一个方法，它是知道你要实现哪一个的。

    // 第一遍去壳
    Demo<Integer> demo1 = (int a, int b) -> {
        return a - b;
    };

继续把return和{}去掉，(方法只有一条语句，才可以省略方法体大括号)

    // 第二遍去壳
    Demo<Integer> demo1 = (int a, int b) -> a - b;

把 参数类型和圆括号去掉(只有一个参数的时候，才可以去掉圆括号)

    // 第三遍去壳，最终的Lambda表达式诞生
    Demo<Integer> demo1 = (a, b) -> a - b;
    System.out.println(demo1.delete(20, 10));

你可以比较看看代码量少了多少，匿名函数6行，这里只需要1行。而且lambda表达式是可以作为参数传递的，它的类型就是接口类型，比如有一个方法需要用到Demo这个接口的实例

    // 有方法需要接口对象作为参数
    public Integer add(int a, int b, int c, Demo<Integer> demo1) {
        return a + demo1.delete(b, c);
    }

    // 可以写完Lambda实现之后直接传参
    Demo<Integer> demo1 = (a, b) -> a - b);
    add(10,20,30,demo1);

    // 也可以直接写Lambda表达式作为参数，这一点匿名函数也是可以的，这是一种把方法作为参数进行传递的编程思想
    add(10,20,30,(a, b) -> a - b);

其实Java在背后，悄悄的把这些Lambda表达式都还原成匿名类方式。

- #### 1.2 场景

Lambda表达式除了用于简化匿名函数之外，它还有一大作用是用于集合类上面，集合类对Lambda表达式做了兼容，我们就来看看有哪些应用场景吧。

- **列表迭代（遍历）**

列表迭代是集合的操作之一，但我们遍历一个集合对象的时候，可以循环，可以增强循环，可以迭代器。那么Lambda更加简化这个操作：

    // 集合遍历
    List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);
    for (int element : numbers) {
        System.out.println(element);
    }

    // Lambda形式
    numbers.forEach(element -> System.out.println(element));

为什么可以这么写？你看了.forEach的参数你就知道了，它是个函数式接口（Consumer消费性接口），所以可以Lambda做参数直接使用

    default void forEach(Consumer<? super T> action) {
        Objects.requireNonNull(action);
        for (T t : this) {
            action.accept(t);
        }
    }

当然还可以这么写：（这种就是jdk8另外一个特性，叫方法引用，下文我们会讲）

    numbers.forEach(System.out::println);

- **事件监听**

事件监听实在图形编程里面的，这里也是可以用Lambda的，因为它也是函数式接口作为参数

    // 普通形式（匿名函数）
    button.addActionListener(new ActionListener(){
        @Override
        public void actionPerformed(ActionEvent e) {
            //handle the event
        }
    });

    //Lambda形式
    button.addActionListener(e -> {
        //handle the event
    });

ActionListener本身就是一个函数式接口。

    public interface ActionListener extends EventListener {
        /**
        * Invoked when an action occurs.
        */
        public void actionPerformed(ActionEvent e);
    }

- **四个功能型接口实现**

Lambda表达式必须先定义接口，创建相关方法之后才能调用,这样做十分不便，其实java8已经内置了许多接口, 例如下面四个功能型接口.所有标注@FunctionalInterface注解的接口都是函数式接口，前面我们已经提过Consumer了，下面我们详细看一看这几个接口。

 - **Consumer** 消费型接口：有入参，无返回值。

适用场景：因为没有出参，常⽤用于打印、发送短信等消费动作

    @FunctionalInterface
    public interface Consumer<T> {
        void accept(T t);
        ...
    }

 - **Supplier** 供给型接口：无入参，有返回值。

适用场景：泛型一定和方法的返回值类型是同一种类型，并且不需要传入参数,例如 无参的工厂方法

    @FunctionalInterface
    public interface Supplier<T> {
        T get();
    }

 - **Function** 函数型接口：有入参，有返回值。

适用场景：传入参数经过函数的计算返回另一个值

    @FunctionalInterface
    public interface Function<T, R> {
        R apply(T t);
        ...
    }

 - **Predicate** 断言型接口：有入参，有返回值，返回值类型确定是boolean。(断言是啥，自己Google咯)

适用场景：接收一个参数，用于判断是否满一定的条件，过滤数据

    @FunctionalInterface
    public interface Predicate<T> {
        boolean test(T t);
        ...
    }

我们再看看实现吧，加深理解：

    public class LambdaDemo {
        public void consumer(double money, Consumer<Double> c) {
            c.accept(money);
        }

        public void supplier(Supplier<Double> s) {
            System.out.println(s.get());
        }

        public void function(Integer age, Function<Integer, String> f) {
            System.out.println(f.apply(age));
        }

        public void predicate(double money, Predicate<Double> p) {
            System.out.println(p.test(money));
        }

        public static void main(String[] args) {
            LambdaDemo lambdaDemo = new LambdaDemo();
            // 消费型接口
            lambdaDemo.consumer(10, (x) -> System.out.println(x));
            // 供给型接口
            lambdaDemo.supplier(() -> 10D);
            // 函数型接口
            lambdaDemo.function(18, x -> x.toString());
            // 断言型接口
            lambdaDemo.predicate(10D, (x) -> x > 5D);
        }
    }

- **Stream流中的Lambda**

Stream流也是JDK8的一个新特性，它是为了方便操作集合而生的。它可以配合Lambda进行一系列操作，这里我们列举一两个例子：reduce 操作，就是通过二元运算对所有元素进行聚合，最终得到一个结果。例如使用加法对列表进行聚合，就是将列表中所有元素累加，得到总和

    List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);
    int sum = numbers.stream().reduce((x, y) -> x + y).get();
    System.out.println(sum);

使用 Stream 对象的 map 方法将原来的列表经由 Lambda 表达式映射为另一个列表，并通过 collect 方法转换回 List 类型：

    List<Integer> numbers1 = Arrays.asList(1, 2, 3, 4, 5);
    List<Integer> mapped = numbers1.stream().map(x -> x * 2).collect(Collectors.toList());
    mapped.forEach(System.out::println);

Stream接口中的函数几乎都有四大基本函数式接口为参数，所以几乎都可以使用Lambda，不一一实践。反正原理都一样。

- **线程**

线程也是一样的道理，开线程的其中两个方法，实现Runnable，Callable接口，而这两个接口就是函数式接口。我上一篇文章说过，这里不再详细说明。

- **Lambda 表达式中的闭包问题（题外话）**

这个问题我们在匿名内部类中也会存在，如果我们把注释放开会报错，告诉我 num 值是 final 不能被改变。这里我们虽然没有标识 num 类型为 final，但是在编译期间虚拟机会帮我们加上 final 修饰关键字

    import java.util.function.Consumer;
    public class Main {
        public static void main(String[] args) {
            int num = 10;
            Consumer<String> consumer = ele -> {
                System.out.println(num);
            };
            //num = num + 2;
            consumer.accept("hello");
        }
    }

#### 2.方法引用：
方法引用是联系Lambda表达式一起使用，它相当于Lambda表达式的方法体里面如果用了一些特定的函数，那么可以再简化，分别有四种类型的方法引用，但是在解释之前我们先做一些准备工作：

- 构造器引用
- 静态方法引用
- 对象方法引用
- 容器中对象方法引用

1.创建一个类，里面包含构造器，静态方法，普通方法三种即可

    public class People {
        People(){
            System.out.println("我是构造方法");
        }

        void print1(){
            System.out.println("我是普通方法");
        }

        static void print2(){
            System.out.println("我是静态方法");
        }
    }

2.创建一个函数式接口

    @FunctionalInterface
    public interface PeopleInterface {
        void test();
    }

3.创建一个Main函数

    public class Main {
        void constructorReference(PeopleInterface peopleInterface) {
            peopleInterface.test();
        }

        void staticReference(PeopleInterface peopleInterface) {
            peopleInterface.test();
        }

        void objectMethodReference(PeopleInterface peopleInterface) {
            peopleInterface.test();
        }

        void containerObjectMethodReference(ArrayList<People> peopleArrayList, PeopleInterface2 peopleInterface2) {
            for (People people : peopleArrayList) {
                peopleInterface2.test(people);
            }
        }

        // main函数
        public static void main(String[] args) {
            Main main = new Main();
            ...
        }
    }

接下来的操作都在main函数里执行：

**构造器引用**：

    // 匿名函数调用构造器
    main.constructorReference(new PeopleInterface() {
        @Override
        public void test() {
            new People();
        }
    });
    // Lambda调用构造器
    main.constructorReference(() -> new People());
    // 构造器引用
    main.constructorReference(People::new);


可以清楚的看出当我们想要使用People类的构造器时有三种形式，而构造器引用形式就是直接帮你调用了，你无需写其他操作。其实::也是暗中帮你一步一步的实现匿名函数的。这也就更加让我们深入了解了函数式编程的思想，“**从起点到终点的道路只有一条，既然只有一条，那我们就把能省略的操作都省略，封装成“->”或是“::”它们的功能就是打通这条路，它不需要知道一些多余的信息，因为要实现的方法只有一个/要实现的功能只有一个，你只需要给出必要的参数和实现内容，其他的全由符号搞定**”

**静态方法引用**：

    // 匿名函数调用静态函数
    main.staticReference(new PeopleInterface() {
        @Override
        public void test() {
            People.print2();
        }
    });
    // Lambda调用静态函数
    main.staticReference(() -> People.print2());
    // 静态函数引用
    main.staticReference(People::print2);

静态函数/方法也称类函数/方法，所以引用的时候直接用类名引用

**对象方法引用**：

    // 匿名函数调用普通函数
    main.objectMethodReference(new PeopleInterface() {
        @Override
        public void test() {
            new People().print1();
        }
    });
    // Lambda调用普通函数
    main.objectMethodReference(() -> new People().print1());
    // 普通函数的引用
    People people = new People();
    main.objectMethodReference(people::print1);

**容器中对象方法引用**
这个东西稍微复杂一点，它的意思时当对象一集合或者对象数组形式存放，我们也可以直接使用类名引用。为了不影响之前的函数式接口，我们重建一个函数式接口

    // 新的函数式接口
    public interface PeopleInterface2 {
        void test(People people);
    }


    ArrayList<People> peopleArrayList = new ArrayList<>();
    for (int i = 0; i < 5; i++) {
        peopleArrayList.add(new People());
    }
    // 匿名函数调用容器里面的普通函数
    main.containerObjectMethodReference(peopleArrayList, new PeopleInterface2() {
        @Override
        public void test(People people) {
            people.print1();
        }
    });
    // Lambda调用容器里面的普通函数
    main.containerObjectMethodReference(peopleArrayList, (people1) -> people1.print1());
    // 容器里面的普通函数引用
    main.containerObjectMethodReference(peopleArrayList, People::print1);

这个很简单的，我就不多解释了，体会代码吧~
Lambda表达式就告一段落了，接下来的最后一篇将会很短，因为最最主要的特性我们已经学了，别的特性都很简单，我将简单介绍即可。

------------

### 每日一类之Optional
这个类也是JDK8特性之一，但有的文章并没有拿出来单独讲，作为一个新增的容器/工具类，我们也只是学会怎么用即可。Optional 类主要解决的问题是臭名昭著的空指针异常（NullPointerException），本质上，这是一个包含有可选值的包装类，这意味着 Optional 类既可以含有对象也可以为空。Optional 也是 Java 实现函数式编程的强劲一步。

**以前**：我们是不是讲过stream流的reduce聚合方法，你点进去看源码，你会发现，咦？返回值是Optional类型的哎。在以前我们为了确保逻辑正确不报错，会这么写（好多判空啊，什么鬼代码）：

    if (user != null) {
        Address address = user.getAddress();
        if (address != null) {
            Country country = address.getCountry();
            if (country != null) {
                String isocode = country.getIsocode();
                if (isocode != null) {
                    isocode = isocode.toUpperCase();
                }
            }
        }
    }

**Optional则可以这样**：要用哪些方法随你咯

    // 创建一个空的 Optional
    Optional<User> emptyOpt = Optional.empty();
    // 创建一定包含值的 Optional
    Optional<User> opt = Optional.of(user);
    // 创建可能是 null 也可能是非 null的 Optional
    Optional<User> opt = Optional.ofNullable(user);
    // 判断是否为空
    isPresent() 
    // 该方法除了执行检查，还接受一个Consumer(消费者) 参数，如果对象不是空的，就对执行传入的 Lambda 表达式
    ifPresent() 
    // 如果有值则返回该值，否则返回传递给它的参数值
    // 如果为非空，返回 Optional 描述的指定值，否则返回空的 Optional
    ofNullable()
    orElse() 
    // 这个方法会在有值的时候返回值，如果没有值，它会执行作为参数传入的 Supplier(供应者) 函数式接口，并将返回其执行结果
    orElseGet() 
    // 它会在对象为空的时候抛出异常，而不是返回备选的值
    orElseThrow()
    // 取值
    get() 
![re3213w31ar3.jpg](http://118.25.221.201:1111/articleImage/fd42f7d3b69246b1a9d10fdb8b617cc1.jpg)', 2, 0, 1, null, 'http://118.25.221.201:1111/articleImage/fd42f7d3b69246b1a9d10fdb8b617cc1.jpg', null, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');
INSERT INTO springboot_project.sys_article (id, name, message, browse_count, like_count, classify_id, sort, status, remark, is_enable, create_time, modify_time, create_user, modify_user) VALUES (3, '系列文章之JDK8新特性(三)', '# JDK8新特性
### 三.杂篇：
#### 1.base64：
由于某些系统中只能使用ASCII字符。Base64就是用来将非ASCII字符的数据转换成ASCII字符的一种方法。 Base64其实不是安全领域下的加密解密算法，而是一种编码，也就是说，它是可以被翻译回原来的样子。它并不是一种加密过程。所以base64只能算是一个编码算法，对数据内容进行编码来适合传输。虽然base64编码过后原文也变成不能看到的字符格式，但是这种方式很初级，很简单。

Base64就是 一种基于64个可打印字符来表示二进制数据的方法， 基于64个字符A-Z,a-z，0-9，+，/的编码方式， 是一种能将任意二进制数据用64种字元组合成字符串的方法：

    import sun.misc.BASE64Decoder;
    import sun.misc.BASE64Encoder;

    import java.util.Base64;

    public class Main {
        public static void main(String[] args) throws Exception {
            /**
            * jdk8以前的写法
            * 编码和解码的效率⽐较差，公开信息说以后的版本会取消这个⽅法
            */
            BASE64Encoder encoder = new BASE64Encoder();
            BASE64Decoder decoder = new BASE64Decoder();
            byte[] textByte = "敷衍三连，哦，牛批，666".getBytes("UTF-8");
            //编码
            String encodedText = encoder.encode(textByte);
            System.out.println(encodedText);//5Zyj6a2U5a+85biI
            //解码
            System.out.println(new String(decoder.decodeBuffer(encodedText), "UTF-8"));//圣魔导师

            /**
            * jdk8的写法
            * 编解码销量远⼤于 sun.misc 和 Apache Commons Codec，可以自己动手压测一下速度
            */
            Base64.Decoder decoder2 = Base64.getDecoder();
            Base64.Encoder encoder2 = Base64.getEncoder();
            byte[] textByte2 = "敷衍三连，哦，牛批，666".getBytes("UTF-8");
            //编码
            String encodedText2 = encoder2.encodeToString(textByte2);
            System.out.println(encodedText);//5Zyj6a2U5a+85biI
            //解码
            System.out.println(new String(decoder2.decode(encodedText2), "UTF-8"));//圣魔导师
        }
    }

#### 2.最新的Date/Time：
SimpleDateFormat,Calendar等类的 API设计⽐较差，⽇期/时间对象⽐较，加减麻烦,Date 还是⾮线程安全的，Java 8通过发布新的Date-Time API (JSR 310)来进一步加强对日期与时间的处理。以下为两个比较重要的 API：

    1.Local(本地) − 简化了日期时间的处理，没有时区的问题。
    2.Zoned(时区) − 通过制定的时区处理日期时间。

新的java.time包涵盖了所有处理日期，时间，日期/时间，时区，时刻（instants），过程（during）与时钟（clock）的操作

#### 3.支持并行（parallel）数组：
Java 8增加了大量的新方法来对数组进行并行处理。可以说，最重要的是parallelSort()方法，因为它可以在多核机器上极大提高数组排序的速度：

    long[] arrayOfLong = new long [ 20000 ];
    //1.给数组随机赋值
    Arrays.parallelSetAll( arrayOfLong, index -> ThreadLocalRandom.current().nextInt( 1000000 ) );
    //2.打印出前10个元素
    Arrays.stream( arrayOfLong ).limit( 10 ).forEach(i -> System.out.print( i + " " ) );
    System.out.println();
    //3.数组排序
    Arrays.parallelSort( arrayOfLong );
    //4.打印排序后的前10个元素
    Arrays.stream( arrayOfLong ).limit( 10 ).forEach(i -> System.out.print( i + " " ) );
    System.out.println();

#### 4.Stream流操作：
通过将集合转换为这么⼀种叫做 “流”的元素队列，能够对集合中的每个元素进行任意操作。总共分为4个步骤：
 - 数据元素便是原始集合：如List、Set、Map等
 - 生成流：可以是串行流stream() 或者并行流 parallelStream()
 - 中间操作：可以是 排序，聚合，过滤，转换等
 - 终端操作：统一收集返回一个流

 代码来~~~:

    package cn.xy.importantKnowledge.stream;

    import java.util.*;
    import java.util.stream.Collectors;
    import java.util.stream.Stream;

    public class Main {
        public static void main(String[] args) {
            List<String> list = Arrays.asList("张麻子", "李蛋", "王二狗", "Angell");
            List<Student> users = Arrays.asList(
                    new Student("张三", 23),
                    new Student("赵四", 24),
                    new Student("二狗", 23),
                    new Student("田七", 22),
                    new Student("皮特", 20),
                    new Student("Tony", 20),
                    new Student("二柱子", 25));
            /**
            * map：对集合的每个对象做处理
            */
            List<String> collect = list.stream().map(obj -> "哈哈" + obj).collect(Collectors.toList());
            list.forEach(obj -> System.out.println(obj));
            System.out.println("----------------");
            collect.forEach(obj -> System.out.println(obj));

            /**
            * filter：boolean判断，用于条件过滤
            */
            System.out.println("----------------");
            Set<String> set = list.stream().filter(obj -> obj.length() > 2).collect(Collectors.toSet());
            set.forEach(obj -> System.out.println(obj));

            /**
            * sorted：对流进行自然排序
            */
            System.out.println("----------------");
            Set<String> sorteds = list.stream().sorted().collect(Collectors.toSet());
            sorteds.forEach(obj -> System.out.println(obj));
            // 自定义排序规则
            // 根据长度排序(正序)
            System.out.println("----------------");
            List<String> resultList = list.stream().sorted(Comparator.comparing(obj -> obj.length())).collect(Collectors.toList());
            resultList.forEach(obj -> System.out.println(obj));
            System.out.println("----------------");
            // 根据长度排序(倒序)
            List<String> resultList2 = list.stream().sorted(Comparator.comparing(obj -> obj.length(), Comparator.reverseOrder())).collect(Collectors.toList());
            resultList2.forEach(obj -> System.out.println(obj));
            System.out.println("----------------");
            // 手动指定排序规则(根据年龄大小排序)
            List<Student> collect2 = users.stream().sorted(
                    Comparator.comparing(Student::getAge, (x, y) -> {
                        if (x > y) {
                            return 1;
                        } else {
                            return -1;
                        }
                    })
            ).collect(Collectors.toList());
            collect2.forEach(obj -> System.out.println(obj.getAge() + " : " + obj.getProvince()));

            /**
            * limit：截取包含指定数量的元素
            */
            System.out.println("----------------");
            List<String> collect3 = list.stream().limit(2).collect(Collectors.toList());
            collect3.forEach(obj -> System.out.println(obj));

            /**
            * allMatch：匹配所有元素，只有全部符合才返回true
            */
            System.out.println("----------------");
            boolean flag = list.stream().allMatch(obj -> obj.length() > 2);
            System.out.println(flag);
            System.out.println("----------------");

            /**
            * anyMatch：匹配所有元素，至少一个元素满足就为true
            */
            boolean flag2 = list.stream().anyMatch(obj -> obj.length() > 2);
            System.out.println(flag2);
            System.out.println("----------------");
            
            /**
            * max和min：最大值和最小值
            */
            Optional<Student> max = users.stream().max(Comparator.comparingInt(Student::getAge));
            System.out.println(max.get().getAge() + " : " + max.get().getProvince());
            System.out.println("----------------");
            Optional<Student> min = users.stream().min((s1, s2) -> Integer.compare(s1.getAge(), s2.getAge()));
            System.out.println(min.get().getAge() + " : " + min.get().getProvince());

            /**
            * reduce：对Stream中的元素进行计算后返回一个唯一的值
            */
            // 计算所有值的累加
            int value = Stream.of(1, 2, 3, 4, 5).reduce((item1, item2) -> item1 + item2).get();
            // 100作为初始值，然后累加所有值
            int value2 = Stream.of(1, 2, 3, 4, 5).reduce(100, (sum, item) -> sum + item);
            // 找出最大值
            int value3 = Stream.of(1, 4, 5, 2, 3).reduce((x, y) -> x > y ? x : y).get();

            System.out.println(value);
            System.out.println(value2);
            System.out.println(value3);
        }
    }


    class Student {
        private String province;
        private int age;

        public String getProvince() {
            return province;
        }

        public void setProvince(String province) {
            this.province = province;
        }

        public int getAge() {
            return age;
        }

        public void setAge(int age) {
            this.age = age;
        }

        public Student(String province, int age) {
            this.age = age;
            this.province = province;
        }
    }

#### 5.注解相关:

**可以进行重复注解**
自从Java 5引入了注解机制，这一特性就变得非常流行并且广为使用。然而，使用注解的一个限制是相同的注解在同一位置只能声明一次，不能声明多次。Java 8打破了这条规则，引入了重复注解机制，这样相同的注解可以在同一地方声明多次。重复注解机制本身必须用@Repeatable注解。事实上，这并不是语言层面上的改变，更多的是编译器的技巧，底层的原理保持不变。

    // 自定义一个包装类Hints注解用来放置一组具体的Hint注解
    @interface MyHints {
        Hint[] value();
    }

    @Repeatable(MyHints.class)
    @interface Hint {
        String value();
    }

    // 旧方法
    @MyHints({@Hint("hint1"), @Hint("hint2")})
    class Person {}

    // 新方法
    @Hint("hint1")
    @Hint("hint2")
    class Person {}

**扩展注解的支持**
Java 8扩展了注解的上下文。现在几乎可以为任何东西添加注解：局部变量、泛型类、父类与接口的实现，就连方法的异常也能添加注解。而且新增了两个Target的值：

- ElementType.TYPE_PARAMETER 表示该注解能写在类型变量的声明语句中。
- ElementType.TYPE_USE 表示该注解能写在使用类型的任何语句中（eg：声明语句、泛型和强制转换语句中的类型）。

------------

### 每日一类之Stream数据处理方法
今天的每日一类没啥文字描述的，直接上代码

    package cn.xy.importantKnowledge.collector;

    import java.util.*;
    import java.util.concurrent.CopyOnWriteArrayList;
    import java.util.stream.Collectors;
    import java.util.stream.Stream;

    public class Main {
        /**
        * 数据结构收集collectors
        *
        * @author Soul
        * @date 2020/2/17 23:09
        */
        private void collectors() {
            List<String> data = Arrays.asList("张三", "王五", "李四");
            List<String> list = data.stream().collect(Collectors.toList());
            Set<String> set = data.stream().collect(Collectors.toSet());
            LinkedList<String> linkedList = data.stream().collect(Collectors.toCollection(LinkedList::new));
            System.out.println(list);
            System.out.println(set);
            System.out.println(linkedList);
            Collectors.toSet();
            Collectors.toCollection(LinkedList::new);
            Collectors.toCollection(CopyOnWriteArrayList::new);
            Collectors.toCollection(TreeSet::new);
        }

        /**
        * 拼接器joining
        *
        * @author Soul
        * @date 2020/2/17 23:09
        */
        private void joining() {
            List<String> list = Arrays.asList("springBoot", "springCloud", "netty");
            String result1 = list.stream().collect(Collectors.joining());
            String result2 = list.stream().collect(Collectors.joining("——"));
            String result3 = list.stream().collect(Collectors.joining("—", "【", ""));
            String result4 = Stream.of("hello", "world").collect(Collectors.joining("—", "【", "】"));

            System.out.println(result1);
            System.out.println(result2);
            System.out.println(result3);
            System.out.println(result4);
        }

        /**
        * 分组器partitioning
        *
        * @author Soul
        * @date 2020/2/17 23:11
        */
        private void partitioning() {
            List<String> list = Arrays.asList("sdfsdf", "xxxx", "bbb", "bbb");
            Map<Boolean, List<String>> collect = list.stream().collect(Collectors.partitioningBy(obj -> obj.length() > 3));
            System.out.println(collect);
        }

        /**
        * 统计器counting
        *
        * @author Soul
        * @date 2020/2/17 23:11
        */
        private void counting() {
            List<Student> students = Arrays.asList(new Student("⼴东", 23),
                    new Student("⼴东", 24),
                    new Student("⼴东", 23),
                    new Student("北京", 22),
                    new Student("北京", 20),
                    new Student("北京", 20),
                    new Student("海南", 25));
            // 通过名称分组
            Map<String, List<Student>> listMap = students.stream().collect(Collectors.groupingBy(obj -> obj.getProvince()));
            listMap.forEach((key, value) -> {
                System.out.println("========");
                System.out.println(key);
                value.forEach(obj -> {
                    System.out.println(obj.getAge());
                });
            });
            System.out.println("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~");
            // 根据名称分组，并统计每个分组的个数
            Map<String, Long> map = students.stream().collect(Collectors.groupingBy(Student::getProvince, Collectors.counting()));
            map.forEach((key, value) -> {
                System.out.println(key + "省人数有" + value);
            });
        }

        /**
        * 统计器summarizing
        *
        * @author Soul
        * @date 2020/2/17 23:13
        */
        private void summarizing() {
            List<Student> students = Arrays.asList(new Student("⼴东", 23),
                    new Student("⼴东", 24),
                    new Student("⼴东", 23),
                    new Student("北京", 22),
                    new Student("北京", 20),
                    new Student("北京", 20),
                    new Student("海南", 25));
            // summarizingInt；  summarizingLong；    summarizingDouble
            IntSummaryStatistics summaryStatistics = students.stream().collect(Collectors.summarizingInt(Student::getAge));
            System.out.println("平均值：" + summaryStatistics.getAverage());
            System.out.println("人数：" + summaryStatistics.getCount());
            System.out.println("最大值：" + summaryStatistics.getMax());
            System.out.println("最小值：" + summaryStatistics.getMin());
            System.out.println("总和：" + summaryStatistics.getSum());
        }

        /**
        * 计算器reduce
        *
        * @author Soul
        * @date 2020/2/17 23:14
        */
        private void reduce() {
            // 计算所有值的累加
            int value = Stream.of(1, 2, 3, 4, 5).reduce((item1, item2) -> item1 + item2).get();
            // 100作为初始值，然后累加所有值
            int value2 = Stream.of(1, 2, 3, 4, 5).reduce(100, (sum, item) -> sum + item);
            // 找出最大值
            int value3 = Stream.of(1, 4, 5, 2, 3).reduce((x, y) -> x > y ? x : y).get();

            System.out.println(value);
            System.out.println(value2);
            System.out.println(value3);
        }

        public static void main(String[] args) throws Exception {
            Main main = new Main();
            main.collectors();
            main.counting();
            main.joining();
            main.partitioning();
            main.reduce();
            main.summarizing();
        }
    }

    class Student {
        private String province;
        private int age;
        public String getProvince() {
            return province;
        }
        public void setProvince(String province) {
            this.province = province;
        }
        public int getAge() {
            return age;
        }
        public void setAge(int age) {
            this.age = age;
        }
        public Student(String province, int age) {
            this.age = age;
            this.province = province;
        }
    }

![timg.jpg](http://118.25.221.201:1111/articleImage/64d6548540b846bd911fa8c69ead3bf4.jpg)', 2, 0, 1, null, 'http://118.25.221.201:1111/articleImage/64d6548540b846bd911fa8c69ead3bf4.jpg', null, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');
INSERT INTO springboot_project.sys_article (id, name, message, browse_count, like_count, classify_id, sort, status, remark, is_enable, create_time, modify_time, create_user, modify_user) VALUES (4, '集合类综合讲解', '# 集合
**集合类在java中有着不言而喻的地位，在我看来，学完java基础之后的java中级中就有它的一席之地**

### 一.综述:
**1.以“345”口诀来看的话，常见的有：**

- List的实现类有ArrayList，LinkedList，Vector(3个)；
- Set的实现类有HashSet，TreeSet，EnumSet，LinkedHashSet(4个)；
- Map的实现类有HashMap，TreeMap，EnumMap，HashTable，LinkedHashMap(5个)；

**2.上面的只是常见的，不常见的有：**

- List还有不常见的Stack，AttributeList等；
- Set还有不常见的HashAttributeSet；(ps：EntrySet和KeySet会被误以为是Set实现类，这两个其实不是Set实现类，而是Map实现类里面的两个内部类，是为了Map部分数据的组织，方便迭代查找操作；重点的是和他们同名的两个函数entrySet()，keySet())；
- Map还有不常见的WeakHashMap，IdentityHashMap，ConcurrentHashMap等；
- 当然，这些不常见的大多都是继承于上面常见的实现类，Map那几个不是，它们属于独立的集合实现类。

**3.三大集合实现关系：**

- Set和List并不是顶级接口，他们之上还有一个Collection接口，Collection接口之上还有个Iterable接口，这里就可以看出了Set和List 是继承同样的接口以迭代器模式形成的（迭代器模式建议去看看设计模式，设计模式对于高级的软件开发人员是必不可少的）
- Map接口自身就是顶级接口，他没用任何设计模式，就为Map的那几个实现类提供接口
- 值得注意的是Set大多数实现类是继承于Map的实现类的，如EntrySet，KeySet，HashSet，TreeSet等。所以总结说来Set和List的接口规范相同，但Set与Map的底层实现基本相同
[图片位]

**4.联系于数据结构：**

学过数据结构我们都知道，逻辑结构有线性表和非线性表之分。线性表对应的物理结构又有顺序表（数组），链表，栈，队列，串；线性表对应的物理结构又有树，图，集合；还有顺序表（数组）+链表形成的特殊的结构——散列/哈希表。这其实与集合这部分知识点是相对应的：
List：

- ArrayList——顺序表（数组）
- Vector——顺序表（线程安全数组）
- LinkedList——双向链表

Set：

- EnumSet——顺序表（枚举类型的数组）
- TreeSet——红黑树（基于TreeMap）
- HashSet——哈希表（基于HashMap）
- LinkedHashSet——哈希表+双向链表（基于HashSet）

Map：

- EnumMap——顺序表（K-V形式）（枚举类型的数组）
- TreeMap——红黑树（K-V形式）
- HashTable——哈希表（K-V形式，线程安全）（jdk1.8之后转为哈希表+红黑树）
- HashMap——哈希表（K-V形式）（jdk1.8之后转为哈希表+红黑树）
- LinkedHashMap——哈希表+双向链表（K-V形式）（jdk1.8之后转为哈希表+红黑树+双向链表）

### 二.List
List我们主要讲3个：

- **ArrayList**

这个是最简单的一种集合类型，它的底层实现就是数组，没有别的。我这边贴出源码并注释出来，大家看看它的属性有哪些：

    // ArrayList的基本属性
    // 序列化版本Id
    private static final long serialVersionUID = 8683452581122892189L;
    // 默认容量
    private static final int DEFAULT_CAPACITY = 10;
    // 空元素数据
    private static final Object[] EMPTY_ELEMENTDATA = new Object[0];
    // 空元素数据的默认容量
    private static final Object[] DEFAULTCAPACITY_EMPTY_ELEMENTDATA = new Object[0];
    // 元素数据（ps：transient关键字作用是让这个属性不进行序列化）
    transient Object[] elementData;
    // 尺寸
    private int size;
    // 最大尺寸
    private static final int MAX_ARRAY_SIZE = 2147483639;
不难看出底层是一个数组实现的顺序表了吧。

- **LinkedList**

这是以双向链表形式存储的集合形式，同样的给你们看源码：（注意，它不仅实现双向链表Deque，还实现了队列Queue哦）

    // LinkedList的基本属性
    // 尺寸
    transient int size;
    // 首元结点
    transient LinkedList.Node<E> first;
    // 尾结点
    transient LinkedList.Node<E> last;
    // 序列化版本Id
    private static final long serialVersionUID = 876323262645176354L;
我们再看看结点定义：

    // LinkedList的结点信息
    // 泛型结点，任何类型都可以
    private static class Node<E> {
        // 当前类型
        E item;
        // 下一结点
        LinkedList.Node<E> next;
        // 上一结点
        LinkedList.Node<E> prev;

        // 构造函数(Constructor)
        Node(LinkedList.Node<E> prev, E element, LinkedList.Node<E> next) {
            this.item = element;
            this.next = next;
            this.prev = prev;
        }
    }

- **Vector**

Vector和ArrayList一样，同样是数组实现的顺序表，但是它的方法基本都带有synchronized（同步锁）关键字，这表明它是线程安全的，不会发生死锁等情况。但相对的，安全的同时，效率是极低的。所以除非是真的要做线程安全，不然的话不建议使用，老规矩，贴源码：

    // Vector的基本属性
    // 元素数据
    protected Object[] elementData;
    // 元素计数
    protected int elementCount;
    // 容量增加
    protected int capacityIncrement;
    // 序列化版本Id
    private static final long serialVersionUID = -2767605614048989439L;
    // 最大尺寸
    private static final int MAX_ARRAY_SIZE = 2147483639;
我们再看看它的几个方法：

    // Vector的部分线程安全方法
    public synchronized int capacity() {
        return this.elementData.length;
    }

    public synchronized int size() {
        return this.elementCount;
    }

    public synchronized boolean isEmpty() {
        return this.elementCount == 0;
    }
都是有synchronized修饰的，证明它是进行了线程的同步互斥操作的（管程）。

### 三.Set和Map对比学习
Set我们主要讲4个，Map讲5个，并且我们采用对比学习的形式，因为Set和Map有很大的瓜葛

- **HashTable与HashMap**

两者的底层实现都是以哈希表+红黑树（jdk8之前只以哈希表实现），看源码：

    // HashMap的基本属性
    // 序列化版本Id
    private static final long serialVersionUID = 362498820763181265L;
    // 默认初始容量
    static final int DEFAULT_INITIAL_CAPACITY = 16;
    // 最大容量
    static final int MAXIMUM_CAPACITY = 1073741824;
    // 默认负载因子
    static final float DEFAULT_LOAD_FACTOR = 0.75F;
    /**
     * 这里说明一下，之后的三个属性就是jdk8之后加入的，与红黑树转化有关。
     *
     * 树化阈值：为bin使用tree还是list一个bin数目阈值。
     * 在至少达到这个数目节点的情况下增加元素，bins将会转化成tree。
     * 该值必须大于2，至少应该是8，与移除树的假设相适应
     */
    static final int TREEIFY_THRESHOLD = 8;
    // 还原阈值：在调整大小操作时反树化（切分）一个bin的bin数目阈值，在移除时检测最大是6
    static final int UNTREEIFY_THRESHOLD = 6;
    // 树形化时bins的最小哈希表容量：为避免在调整大小和树形化阈值之间产生矛盾，这个值至少是4
    static final int MIN_TREEIFY_CAPACITY = 64;
    // 哈希表结点
    transient HashMap.Node<K, V>[] table;
    /**
     * 提供给entrySet()函数使用的属性。(ps：entrySet()函数是快速遍历Map的K-V的函数)
     *
     * 这里说明一下，还有一个keySet属性是提供给keySet()函数使用的属性，但这个属性位于抽象类AbstractMap中。
     * 
     * ps:keySet()同样是快速遍历Map的K-V的函数，但是推荐entrySet()，
     * keySet其实是遍历了2次，一次是转为Iterator对象，另一次是从hashMap中取出key对应value。
     */
    transient Set<Entry<K, V>> entrySet;
    // 尺寸
    transient int size;
    // 模数
    transient int modCount;
    // 阈
    int threshold;
    // 负载系数
    final float loadFactor;
------------
    // HashMap的结点信息
    static class Node<K, V> implements Entry<K, V> {
        // 哈希值，根据冲突算法计算
        final int hash;
        // 键
        final K key;
        // 值
        V value;
        // 下个结点
        HashMap.Node<K, V> next;

        // 构造函数(Constructor)
        Node(int hash, K key, V value, HashMap.Node<K, V> next) {
            this.hash = hash;
            this.key = key;
            this.value = value;
            this.next = next;
        }
    ...}
根据源码我们也看出来它的底层是哈希表与红黑树实现的，HashTable的底层和HashMao的大同小异，我就不全部说明：

    // hashTable结点属性
    private transient Hashtable.Entry<?, ?>[] table;

    // hashTable结点信息
    private static class Entry<K, V> implements java.util.Map.Entry<K, V> {
        // 哈希值，根据冲突算法计算
        final int hash;
        // 键
        final K key;
        // 值
        V value;
        // 下个结点
        Hashtable.Entry<K, V> next;

        // 构造函数(Constructor)
        protected Entry(int hash, K key, V value, Hashtable.Entry<K, V> next) {
            this.hash = hash;
            this.key = key;
            this.value = value;
            this.next = next;
        }
    ...}
那么他俩什么区别呢？最大的区别就像是Vector和ArrayList一样的，一个有线程安全但效率慢(HashTable)，一个无线程安全但是效率快(HashMap)，这里不再赘述，看看源码就知道。（同样的，建议使用HashMap，除非真的做线程安全时候才用HashTable。而且HashMap自身也可以实现线程安全，调用Collections.synchronizedMap()获取一个线程安全的集合即可）。还有一个区别是HashMap可以存放null而Hashtable不能存放null

    // HashTable的部分线程安全方法
    public synchronized boolean isEmpty() {
        return this.count == 0;
    }

    public synchronized Enumeration<K> keys() {
        return this.getEnumeration(0);
    }

    public synchronized Enumeration<V> elements() {
        return this.getEnumeration(1);
    }

- **HashMap与HashSet**

我们前面也提过，HashSet是基于HashMap的，所以他们的大多功能是一致的，我们随便看两个HashSet的构造函数就可以看出它都 new 了一个 HashMap。(HashSet同样是非线程安全的)

    // HashSet的构造函数，都有HashMap的身影
    public HashSet(int initialCapacity, float loadFactor) {
        this.map = new HashMap(initialCapacity, loadFactor);
    }

    public HashSet(int initialCapacity) {
        this.map = new HashMap(initialCapacity);
    }
所以显而易见，HashSet的底层是和HashMap一致的。那么他们有什么区别呢？我们看一看：
**Set：**

- 所得元素的只有key没有value，value就是key
- 不允许出现键值重复
- 所有的元素都会被自动排序 
- 不能通过迭代器来改变set的值，因为set的值就是键

**Map：**

- 所有元素都是key-value存在
- 不允许键重复，但是值可重复
- 所有元素是通过键进行自动排序的
- map的键是不能修改的，但是其键对应的值是可以修改的

综上所述，它们其实就一个区别，就是Set只有key，Map是key-value都有。但是因为key的唯一性和不可改的特性，产生了几个不同点。

- **TreeMap与TreeSet**

讲述标题之前，先来看看HashMap和TreeMap的区别吧。在Jdk8之前HashMap和TreeMap是完全不同的结构，一个哈希表结构，一个红黑树结构。但在JDK8之后HashMap也引入了红黑树，这就使TreeMap的使用率更少了，但是习惯成自然，还是有很多人使用TreeMap而不去使用HashMap转化树形。TreeMap大多属性和HashMap作用一样，我们只看一下它比较显著的属性:

    // TreeMap部分属性
    // 红黑树的红色结点
    private static final boolean RED = false;
    // 红黑树的黑色结点
    private static final boolean BLACK = true;

    // TreeMap结点信息(标准的树形结构)
    static final class Entry<K, V> implements java.util.Map.Entry<K, V> {
        // 键
        K key;
        // 值
        V value;
        // 左孩子
        TreeMap.Entry<K, V> left;
        // 右孩子
        TreeMap.Entry<K, V> right;
        // 父结点
        TreeMap.Entry<K, V> parent;
        // 默认是黑色结点，也就是根结点
        boolean color = true;

        // 构造函数(Constructor)
        Entry(K key, V value, TreeMap.Entry<K, V> parent) {
            this.key = key;
            this.value = value;
            this.parent = parent;
        }
    ...}
通过源码我们也可以看出它是标准的红黑树结构。值得注意的是HashMap和TreeMap都是非线程安全的。那么HashMap和TreeMap的区别是啥？很好理解，我们只需要知道哈希表和红黑树的区别，优缺点即可：

- 红黑树是有序的；哈希表是无序的（这里的无序不是说HashMap，HashSet没有自排序，无序是指和插入时顺序不一致称为无序。HashMap，HashSet会根据键自排序而打乱插入顺序，所以称为无序，而红黑树，List等就是有序的。）
- 红黑树占用的内存更小（仅需要为其存在的节点分配内存）；哈希表事先就应该分配足够的内存存储散列表（即使有些槽可能遭弃用）
- 红黑树查找和删除的时间复杂度都是O(logn)；哈希表查找和删除的时间复杂度都是O(1)
- 红黑树适用于按自然顺序或自定义顺序遍历键；哈希表适用于在Map中插入、删除和定位元素

接下来回归标题，TreeMap和TreeSet什么区别呢？TreeSet其实是基于TreeMap的，所以TreeMap的功能，TreeSet基本都有，我们也来看看TreeSet的构造函数吧：

    // TreeSet的构造函数，都有TreeMap的身影
    public TreeSet() {
        this((NavigableMap)(new TreeMap()));
    }

    public TreeSet(Comparator<? super E> comparator) {
        this((NavigableMap)(new TreeMap(comparator)));
    }
然而区别呢，上面也讲过了，Set和Map的区别，不再赘述，往上看一看吧。

- **LinkedHashMap与LinkedHashSet**

这两个东西分别是HashMap和HashSet的子类，本来可不作为大类来详细叙述的，但是用的比较多，就介绍一下吧。它们很简单了，多了个Linked，从字面我们就可以看出，是多了一个双向链表，其他的区别和上面一样。那么，多个双向链表干嘛呢？其实是为了保持遍历顺序和插入顺序一致的问题，什么意思呢？当你使用put像Map中添加一条数据时，双向链表便会记录你put的顺序，使得遍历的时候是和你插入的顺序是一致的，这可是有很多大用处的哦。作用说完了，看看源码吧：

    // LinkedHashMap在HashMap基础上添加了含有头尾结点的双向链表
    transient LinkedHashMap.Entry<K, V> head;
    transient LinkedHashMap.Entry<K, V> tail;
------------
    // LinkedHashSet继承了HashSet
    public class LinkedHashSet<E> extends HashSet<E> implements Set<E>, Cloneable, Serializable {
        ...
    }
    // HashSet里面有一个构造函数，new了一个LinkedHashMap
    HashSet(int initialCapacity, float loadFactor, boolean dummy) {
        this.map = new LinkedHashMap(initialCapacity, loadFactor);
    }
可以看出LinkedHashSet还是基于LinkedHashMap的。

- **EnumMap与EnumSet**

这两个东西其实说起来不是特别常见，因为枚举本身就用的不多，做项目的时候是一群人做，与其慢慢读你的枚举变量，不如用finnal写成常量就好了。当然，枚举之所以存在是有它的意义的，通过EnumMap与EnumSet我们省去了枚举类中很多繁琐的操作：

    // EnumMap这样就可以把枚举对象加入Map进行一次性传递
    enumMap.put(EnumTest01.DELETE, "dsdsd");
    enumMap.put(EnumTest01.UPDATE, "qqqqqq");
    
    // EnumSet和EnumMap大同小异，只是它没有value，key既是value
    enumSet.add(EnumTest01.DELETE);
    enumSet.add(EnumTest01.UPDATE);
为什么要用这个EnumMap呢？因为它的性能高！为什么性能高？因为它的底层是用数组来维护的！我们可以看一下它的源码实现：

    // EnumMap用数组作为底层，并非哈希表，没有哈希结点
    private transient K[] keyUniverse;
    private transient Object[] vals;

    // EnumMap的put函数
    public V put(K key, V value) {
        this.typeCheck(key);
        int index = key.ordinal();
        Object oldValue = this.vals[index];
        this.vals[index] = this.maskNull(value);
        if (oldValue == null) {
            ++this.size;
        }

        return this.unmaskNull(oldValue);
    }
我们都知道，数组作为查询什么的是很快的，它不擅长于增加和删除。这正好符合我们需要遍历枚举对象的需求，所以有了EnumMap。而EnumSet实际上不是一个实现类，是一个抽象类，它有两个继承类：JumboEnumSet和RegularEnumSet。在使用的时候，需要制定枚举类型。它的特点也是速度非常快，为什么速度很快呢？因为每次add的时候，每个枚举值只占一个长整型的一位。我们翻看源码来看看它的实现：

    // JumboEnumSet以长整型数组存放枚举值，它适用于枚举类的常量数量多于64个的时候
    class JumboEnumSet<E extends Enum<E>> extends EnumSet<E> {
        private static final long serialVersionUID = 334349849919042784L;
        private long[] elements;
        private int size = 0;
        ...
    }

    /**
     * RegularEnumSet以长整型变量计算枚举值的临时存放，
     * 它没有数组存储，所以只适用于枚举类的常量数量少于64个的时候，也是我们常用的
     */
    class RegularEnumSet<E extends Enum<E>> extends EnumSet<E> {
        private static final long serialVersionUID = 3411599620347842686L;
        private long elements = 0L;
        ...
    }

### 四.不常见集合类简述

- **List**

Stack：Stack(栈)，大家对栈都很熟悉了，先进后出，后进先出，它还可以代替递归什么的，java中的栈是继承于Vector的，那么底层就不用我说都知道了吧，是一个线程安全的数组。

AttributeList： AttributeList继承了ArrayList，不过是在包javax.management包中，看名字，难道叫“属性”List,它的作用是表示MBean的属性值的列表。请参阅MBeanServer和MBeanServerConnection的getAttribute和setAttribute方法。

- **Set**

HashAttributeSet：HashAttributeSet是AttributeSet的一个实现类，AttributeSet是打印属性集的指定接口。和AttributeList类似，HashAttributeSet也是表示属性值的，但不是列表形式，而是哈希表形式，它是基于HashMap实现的

- **Map**

WeakHashMap：它不是继承于HashMap，而是实现的Map接口，属于和Map同级别的存在。WeakHashMap的键是“弱键”。在 WeakHashMap 中，当某个键不再正常使用时，会被从WeakHashMap中被自动移除。更精确地说，对于一个给定的键，其映射的存在并不阻止垃圾回收器对该键的丢弃，这就使该键成为可终止的，被终止，然后被回收。某个键被终止时，它对应的键值对也就从映射中有效地移除了。

IdentityHashMap：它不是继承于HashMap，而是实现的Map接口，属于和Map同级别的存在。使用HashMap操作的时候，key内容是不能重复的，如果现在希望key内容可以重复（指的是两个对象的地址不一样key1==key2 ）则要使用IdentityHashMap类，所以它的作用是为了增加重复的键。

ConcurrentHashMap：ConcurrentHashMap实现于ConcurrentMap，而ConcurrentMap也是继承于Map接口，所以也可以说ConcurrentHashMap和HashMap是同级别的。这个类很强，完全可以代替HashTable，为什么这么说呢？它底层采用分段的数组+链表实现，线程安全。通过把整个Map分为N个Segment，可以提供相同的线程安全，但是效率提升N倍，默认提升16倍，过程是根据key.hashCode()算出放到哪个Segment中。Hashtable的synchronized是针对整张Hash表的，即每次锁住整张表让线程独占，ConcurrentHashMap允许多个修改操作并发进行，其关键在于使用了锁分离技术。

------------

### 每日一类之Map，Set拓展
**1.SortedMap**和**SortedSet**：这两个不是实现类，而是接口。见名识意，Map和Set的实现类之所以自排序就是因为有一个构造函数的参数调用这两个接口进行实现

**2.entrySet()**和**keySet()**：这两个方法是每个Map实现类里面都有的，是为了遍历k-v和输出的方便设计的。keySet()是k的集合，Set里面的类型即key的类型；entrySet()是k-v对的集合，Set里面的类型是Map.Entry。keySet()的速度比entrySet()慢了很多。使用entrySet()必须将map对象转换为Map.Entry；keySet()则不需要
![572d63306d7e1.jpg](http://118.25.221.201:1111/articleImage/ef333757a39342b89eb9814aa65eeb30.jpg)', 1, 0, 1, null, 'http://118.25.221.201:1111/articleImage/ef333757a39342b89eb9814aa65eeb30.jpg', null, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');