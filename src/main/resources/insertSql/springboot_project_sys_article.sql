INSERT INTO springboot_project.sys_article (id, name, message, browse_count, like_count, classify_id, sort, status, remark, is_enable, create_time, modify_time, create_user, modify_user) VALUES (1, '系列文章之JDK8新特性(一)', '# JDK8新特性
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
![5b10e2581cb26.jpg](http://118.25.221.201:1111/articleImage/8326f956576f4ad9afa7fa4f1dd5fc80.jpg)', 4, 0, 1, null, 'http://118.25.221.201:1111/articleImage/8326f956576f4ad9afa7fa4f1dd5fc80.jpg', null, 1, '2020-02-08', '2020-02-08', 'admin', 'admin');