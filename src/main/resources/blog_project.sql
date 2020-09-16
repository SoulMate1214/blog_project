/*
 Navicat Premium Data Transfer

 Source Server         : subway
 Source Server Type    : MySQL
 Source Server Version : 80021
 Source Host           : localhost:3306
 Source Schema         : blog_project

 Target Server Type    : MySQL
 Target Server Version : 80021
 File Encoding         : 65001

 Date: 16/09/2020 09:28:09
*/
DROP DATABASE IF EXISTS blog_project;
CREATE DATABASE IF NOT EXISTS blog_project DEFAULT CHARACTER SET utf8;
USE blog_project;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sys_article
-- ----------------------------
DROP TABLE IF EXISTS `sys_article`;
CREATE TABLE `sys_article`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章名',
  `message` varchar(20000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文章内容',
  `browse_count` int(0) NULL DEFAULT 0 COMMENT '浏览量，默认0',
  `like_count` int(0) NULL DEFAULT 0 COMMENT '点赞数',
  `classify_id` int(0) NULL DEFAULT NULL COMMENT '文章分类编号',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '封面',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否启用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建日期',
  `modify_time` date NULL DEFAULT NULL COMMENT '修改日期',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `article_classify_fk`(`classify_id`) USING BTREE,
  CONSTRAINT `article_classify_fk` FOREIGN KEY (`classify_id`) REFERENCES `sys_classify` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_article
-- ----------------------------
INSERT INTO `sys_article` VALUES (1, '系列文章之JDK8新特性(一)', '# JDK8新特性\r\n**JDK8已经出了好久好久了，我现在才来写特性，惭愧惭愧，本来准备去研究JDK13的，想想还是一步一步来吧，废话不多说，让我们看看都有哪些特性吧？**\r\n\r\n### 一.接口篇：\r\n#### 1.static与default接口函数：\r\n大家都知道关于接口“interface”在java中是极其重要的一位，接口的函数/方法默认都是abstract的，也就是抽象的，在jdk8中，新增了两个接口的函数类型，那就是static和default，这两个是干嘛的呢？又有什么区别呢？\r\n\r\n- **static**\r\n\r\n也被称为静态接口函数，它是可以直接在接口里面写实现的，对比静态/类方法（类中的static函数）我们就能明白，它是可以直接用接口调用的，不需要new一个实现类的对象去调用，因为它本身也不可在实现类里面被@Override重写。如下：\r\n\r\n    public interface HeroService {\r\n        static void war(List<Hero> heroList) {\r\n            Optional.ofNullable(heroList).orElse(new ArrayList<>()).forEach(item -> {\r\n                System.out.print(item.getName()+\" \");\r\n            });\r\n            System.out.println(\"和您参与激烈的战斗\");\r\n        }\r\n    }\r\n\r\n具体函数内容先别管，我们看到，war函数是用static声明的，这就是静态接口函数，调用如下：\r\n\r\n	HeroService.war(heroList);\r\n\r\n你看，不同于我们平时的调用方式需要new一个实现类的实例去调用（有没有感觉和spring的容器注入的调用方式很像啊，那个也是直接用接口就可以调用实现类里的函数了），这里的原因我也在上面说明了，static是不能在接口实现类里面实现的，你要是硬要在接口实现类写这个同名的函数，那只会被当作另外的和这个接口无关的函数处理。普通调用如下：\r\n\r\n	HeroService heroServiceImpl = new HeroServiceImpl();\r\n\r\n- **default**\r\n\r\n也被称为默认接口函数，和static接口差不多，也是初始时候直接在接口里面能写函数体，但是它不同于static，是可以在实现类里面@Override，也可以不写，随你开心。但是依据这个东西的初衷的话是不建议@Override的，要@Override的话直接用默认的abstract不就好了吗，static和default的初衷就是定义那些不变的接口，定义那些写死的接口，所以没必要去改它，就在interface里面实现就好啦，没必要弄到class里面去实现。如下：\r\n\r\n    public interface HeroService {\r\n\r\n        default String kill(Hero hero) {\r\n            return \"恭喜您，击杀了敌方英雄:\" + hero.getName();\r\n        }\r\n\r\n        default String assists(Hero killHero, Hero dieHero) {\r\n            return \"您帮助队友:\" + killHero.getName() + \"击杀了敌方英雄:\" + dieHero.getName() + \",真是好队友\";\r\n        }\r\n\r\n        default String die(Hero hero) {\r\n            return \"非常不幸，您被敌方英雄:\" + hero.getName() + \"击杀,再接再厉\";\r\n        }\r\n    }\r\n\r\n你也可以实现类重写，如下：\r\n\r\n    public class HeroServiceImpl implements HeroService {\r\n        @Override\r\n        public String kill(Hero hero) {\r\n            return null;\r\n        }\r\n\r\n        @Override\r\n        public String assists(Hero killHero, Hero dieHero) {\r\n            return null;\r\n        }\r\n\r\n        @Override\r\n        public String die(Hero hero) {\r\n            return null;\r\n        }\r\n    }\r\n\r\n调用的话也和static有区别，它就不能再用接口直接调用咯，和平常一样需要声明实现类的实例去调用，你会发现，咦？我明明没有在实现类里面重写，为啥可以调用呢？这就是default和static的真正作用咯，相当于你写了个公共的接口，不管哪个实现类都会有这些接口\r\n\r\n    HeroService heroServiceImpl = new HeroServiceImpl();\r\n    heroServiceImpl.kill(Galen)\r\n\r\n##### 关于代码中的Hero类是我自己创建的，你们可以改了。\r\n\r\n#### 2.函数式接口：\r\n何为函数式接口？其实它是一种规范，就是说你的接口里面只能有且只有一个abstract函数，也就是普通的函数，当然这里我说的是只能有一个普通函数，你也可以有很多static的函数，有很多default的函数，还可以有个特殊的就是：可以有所有的Object类里面的public的函数,所以，一个函数式接口可以包括四个东西：\r\n\r\n- ##### 唯一的一个普通函数（abstract）\r\n- ##### n个static函数\r\n- ##### n个default函数\r\n- ##### 所有的Object类里面的public的函数\r\n\r\n如下：\r\n\r\n    @FunctionalInterface\r\n    public interface FunctionalService {\r\n        /**\r\n        * 只能有唯一的一个abstract函数\r\n        *\r\n        * @author Soul\r\n        * @date 2020/1/29 16:44\r\n        */\r\n        void create();\r\n\r\n        /**\r\n        * 可以有多个default函数\r\n        *\r\n        * @author Soul\r\n        * @date 2020/1/29 16:44\r\n        */\r\n        default void delete() {\r\n        }\r\n\r\n        /**\r\n        * 可以有多个static函数\r\n        *\r\n        * @author Soul\r\n        * @date 2020/1/29 16:46\r\n        */\r\n        static void update() {\r\n        }\r\n\r\n        /**\r\n        * 可以有所有的Object类里面的public的函数\r\n        * 他们不算是自己写的abstract函数\r\n        *\r\n        * @author Soul\r\n        * @date 2020/1/29 16:47\r\n        */\r\n        boolean equals(Object object);\r\n\r\n        String toString();\r\n\r\n        int hashCode();\r\n    }\r\n\r\n你会发现我接口上面有一个注解@FunctionalInterface，这是干嘛的呢？这其实是JDK8的一个函数式接口检测注解，如果你写上这个注解，你的接口就一定得是函数式接口，不是的话会报错哦。如果不写这个注解但是你的接口又符合函数式接口规范呢，那这个接口同样是一个函数式接口，只是没有严格的去通过注解检测而已，但是为了方便起见建议每写一个函数式接口都加上这个注解，因为要是你一不小心多些了几个接口让它不成为函数式接口咋办。为啥得有函数式接口这个规范呢？有啥用啊？它其实多配合与匿名函数和lambda表达式使用，下面我们具体看，让你彻底理解它的作用。\r\n\r\n在这里，我们回忆一下有关多线程开发的知识，要开多线程的话，有四种方法：\r\n\r\n- ##### 继承Thread类\r\n- ##### 实现Runnable接口\r\n- ##### 实现Callable接口\r\n- ##### 线程池\r\n\r\n在这里，我们回忆一下前三种就行了，线程池自己有兴趣可以去看看。那我们为什么提到它们呢，因为**Runnable接口**和**Callable接口**就是函数式接口，他们其实一直都是函数式接口，但是在jdk8之前是没加@FunctionalInterface标识的，jdk8后就加了@FunctionalInterface作为标识表明它是函数式接口。如下：\r\n\r\n    package java.lang;\r\n\r\n    @FunctionalInterface\r\n    public interface Runnable {\r\n        void run();\r\n    }\r\n\r\n以及\r\n\r\n    package java.util.concurrent;\r\n\r\n    @FunctionalInterface\r\n    public interface Callable<V> {\r\n        V call() throws Exception;\r\n    }\r\n\r\n看见那个@FunctionalInterface没，它标志着这两个接口一定是函数式接口。\r\n\r\n- **继承Thread类**\r\n\r\n这个大家都知道，多线程开发就是基于这个线程类的，它的操作呢也很简单，只需要new一个Thread，然后start它即可，你也可以重写它的run方法去执行你的线程逻辑，这个代码应该很清楚的，为了方便看，我把实体类，Thread继承类，主函数写在了一起。\r\n\r\n    public class PeopleThread extends Thread {\r\n        private String name;\r\n        private int age;\r\n\r\n        public PeopleThread(String name, int age) {\r\n            this.name = name;\r\n            this.age = age;\r\n        }\r\n\r\n        @Override\r\n        public void run() {\r\n            System.out.println(\"我是\" + name + \",我今年\" + age + \"岁\");\r\n        }\r\n\r\n        public static void main(String[] args) {\r\n            PeopleThread peopleThread = new PeopleThread(\"张三\", 18);\r\n            PeopleThread peopleThread1 = new PeopleThread(\"李四\", 20);\r\n            PeopleThread peopleThread2 = new PeopleThread(\"王五\", 25);\r\n            peopleThread.start();\r\n            peopleThread1.start();\r\n            peopleThread2.start();\r\n            System.out.println(\"张三的线程名称是：\" + peopleThread.getName() + \",线程Id为\" + peopleThread.getId());\r\n            System.out.println(\"李四的线程名称是：\" + peopleThread1.getName() + \",线程Id为\" + peopleThread1.getId());\r\n            System.out.println(\"王五的线程名称是：\" + peopleThread2.getName() + \",线程Id为\" + peopleThread2.getId());\r\n        }\r\n    }\r\n\r\n- **实现Runnable接口**\r\n\r\n这个就比上面的复杂一点点了，因为它实现了Runnable里面的run函数之后还得使用Thread封装过才能实现多线程，其实看源码你会发现Thread类的run函数就是实现于Runnable接口的run函数，在上面的代码你重写run函数和这里的重写run函数其实都是重写一个地方，都是Runnable接口的run函数：\r\n\r\n    public class PeopleRunnable implements Runnable {\r\n        private String name;\r\n        private int age;\r\n\r\n        public PeopleRunnable(String name, int age) {\r\n            this.name = name;\r\n            this.age = age;\r\n        }\r\n\r\n        @Override\r\n        public void run() {\r\n            System.out.println(\"我是\" + name + \",我今年\" + age + \"岁\");\r\n        }\r\n\r\n        public static void main(String[] args) {\r\n            PeopleRunnable peopleRunnable = new PeopleRunnable(\"张三\", 18);\r\n            PeopleRunnable peopleRunnable1 = new PeopleRunnable(\"李四\", 20);\r\n            PeopleRunnable peopleRunnable2 = new PeopleRunnable(\"王五\", 25);\r\n\r\n            Thread thread = new Thread(peopleRunnable);\r\n            Thread thread1 = new Thread(peopleRunnable1);\r\n            Thread thread2 = new Thread(peopleRunnable2);\r\n            thread.start();\r\n            thread1.start();\r\n            thread2.start();\r\n            System.out.println(\"张三的线程名称是：\" + thread.getName() + \",线程Id为\" + thread.getId());\r\n            System.out.println(\"李四的线程名称是：\" + thread1.getName() + \",线程Id为\" + thread1.getId());\r\n            System.out.println(\"王五的线程名称是：\" + thread2.getName() + \",线程Id为\" + thread2.getId());\r\n        }\r\n    }\r\n\r\n你点开Runnable接口的run函数你会发现有很多很多类实现类它，不止是Thread。随便点一个看一看，你会看到基本都是匿名函数，直接new这个接口去实现run函数，如：(这是随便选的Win32ShellFolderManager2类里面的代码)\r\n\r\n           Runnable comRun = new Runnable() {\r\n                public void run() {\r\n                    try {\r\n                        Win32ShellFolderManager2.initializeCom();\r\n                        task.run();\r\n                    } finally {\r\n                        Win32ShellFolderManager2.uninitializeCom();\r\n                    }\r\n\r\n                }\r\n            };\r\n\r\n这就是函数式接口用作匿名函数使用的例子，也许你会说，匿名函数也可以同时实现多个接口的，不一定得是函数式接口啊。那你得想我要是需求只需要实现一个函数，那么匿名函数里面多的函数岂不是无用了？删也不能删，匿名函数如同实现类一样，里面少实现接口里的函数就会报错。\r\n\r\n- **实现Callable接口**\r\n\r\n如果上面的例子不明显感觉出函数式接口的作用，那么我们继续来看函数式接口在lambda表达式上的应用，这里我们以Callable接口为例，\r\nCallable接口是Runnable的一个增强版，它不同于Runnable的run函数返回值是void，它拥有的是call函数，可以返回一个泛型，同时它也可以做异常处理，通过异常的处理我们可以获取返回值。如下：\r\n（普通形式，里面包含了实体，下面两种形式都直接用了，没有再写）\r\n\r\n    public class PeopleCallable implements Callable<String> {\r\n        private String name;\r\n        private int age;\r\n\r\n        public PeopleCallable(String name, int age) {\r\n            this.name = name;\r\n            this.age = age;\r\n        }\r\n\r\n        @Override\r\n        public String toString() {\r\n            return \"PeopleCallable{\" +\r\n                    \"name=\'\" + name + \'\\\'\' +\r\n                    \", age=\" + age +\r\n                    \'}\';\r\n        }\r\n\r\n        @Override\r\n        public String call() throws Exception {\r\n            try {\r\n                return \"我是\" + name + \",我今年\" + age + \"岁\";\r\n            } catch (Exception e) {\r\n                throw new Exception(\"参数异常\");\r\n            }\r\n        }\r\n\r\n        public static void main(String[] args) throws Exception {\r\n            PeopleCallable peopleCallable = new PeopleCallable(\"张三\", 18);\r\n            FutureTask<String> futureTask = new FutureTask<>(peopleCallable);\r\n            Thread thread = new Thread(futureTask, \"Thread1\");\r\n            thread.start();\r\n            try {\r\n                System.out.println(futureTask.get());\r\n            } catch (Exception e) {\r\n                throw new Exception(\"未能获取到返回值\");\r\n            }\r\n        }\r\n    }\r\n\r\n（匿名函数形式，实体类直接使用普通形式里面的实体，没有再写）\r\n\r\n    public class PeopleCallableAnonymous {\r\n        public static void main(String[] args) {\r\n            FutureTask<String> futureTask = new FutureTask<>(new Callable<String>() {\r\n                @Override\r\n                public String call() throws Exception {\r\n                    try {\r\n                        Set<PeopleCallable> peopleCallableSet = new HashSet<>();\r\n                        peopleCallableSet.add(new PeopleCallable(\"张三\", 18));\r\n                        peopleCallableSet.add(new PeopleCallable(\"李四\", 20));\r\n                        peopleCallableSet.add(new PeopleCallable(\"王五\", 25));\r\n                        Optional.of(peopleCallableSet).orElse(new HashSet<>()).forEach(System.out::println);\r\n                        return peopleCallableSet.toString();\r\n                    } catch (Exception e) {\r\n                        throw new Exception(\"set集合异常\");\r\n                    }\r\n                }\r\n            });\r\n            Thread thread = new Thread(futureTask, \"FirstTread\");\r\n            thread.start();\r\n            try {\r\n                System.out.println(futureTask.get());\r\n            } catch (Exception e) {\r\n                e.printStackTrace();\r\n            }\r\n        }\r\n    }\r\n\r\n（lambda形式的，实体类直接使用普通形式里面的实体，没有再写）\r\n\r\n    public class PeopleCallableLambda {\r\n        public static void main(String[] args) {\r\n            FutureTask<String> futureTask = new FutureTask<>((Callable<String>) () -> {\r\n                try {\r\n                    Set<PeopleCallable> peopleCallableSet = new HashSet<>();\r\n                    peopleCallableSet.add(new PeopleCallable(\"张三\", 18));\r\n                    peopleCallableSet.add(new PeopleCallable(\"李四\", 20));\r\n                    peopleCallableSet.add(new PeopleCallable(\"王五\", 25));\r\n                    Optional.of(peopleCallableSet).orElse(new HashSet<>()).forEach(System.out::println);\r\n                    return peopleCallableSet.toString();\r\n                } catch (Exception e) {\r\n                    throw new Exception(\"set集合异常\");\r\n                }\r\n            });\r\n            Thread thread = new Thread(futureTask, \"FirstTread\");\r\n            thread.start();\r\n            try {\r\n                System.out.println(futureTask.get());\r\n            } catch (Exception e) {\r\n                e.printStackTrace();\r\n            }\r\n        }\r\n    }\r\n\r\n发现没有，普通形式的话我们先重写call函数再使用；匿名函数形式我们是直接再匿名函数里面实现的call函数，（若有多个，也可以实现多个）；而lambda形式的完全看不到call函数的声影，Lambda表达式是如何在java的类型系统中表示的呢？每一个lambda表达式都对应一个类型，通常是接口类型。而“函数式接口”是指仅仅只包含一个抽象方法的接口，每一个该类型的lambda表达式都会被匹配到这个抽象方法。也就是Lambda它唯一实现一个接口的抽象函数。所以说函数式接口是和lambda表达式完美配合的。现在理解函数式接口的用途了吧！\r\n\r\n------------\r\n\r\n### 每日一类之Date类\r\n**Date**在java上有两个**java.util.Date**和**java.sql.Date**，前者是代码中使用的日期工具类，后者是连接数据库时向数据库传日期时使用的，这里我们主要说的是前者，后者使用是一样的。它的使用很简单，直接实例化就行了，当然它也提供了许多不同参数的构造方法\r\n\r\n    import java.util.Date;\r\n    public class TestDate {\r\n        public static void main(String[] args) {\r\n            // 当前时间\r\n            Date d1 = new Date();\r\n            System.out.println(\"当前时间:\");\r\n            System.out.println(d1);\r\n            System.out.println();\r\n            // 从1970年1月1日 早上8点0分0秒 开始经历的毫秒数\r\n            Date d2 = new Date(5000);\r\n            System.out.println(\"从1970年1月1日 早上8点0分0秒 开始经历了5秒的时间\");\r\n            System.out.println(d2);\r\n        }\r\n    }\r\n\r\n**getTime**()方法：得到一个long型的整数，这个整数代表从1970.1.1 08:00:00:000 开始每经历一毫秒，增加1\r\n\r\n    import java.util.Date;\r\n    public class TestDate {\r\n        public static void main(String[] args) {\r\n            //注意：是java.util.Date;\r\n            //而非 java.sql.Date，此类是给数据库访问的时候使用的\r\n            Date now= new Date();\r\n            //打印当前时间\r\n            System.out.println(\"当前时间:\"+now.toString());\r\n            //getTime() 得到一个long型的整数\r\n            //这个整数代表 1970.1.1 08:00:00:000，每经历一毫秒，增加1\r\n            System.out.println(\"当前时间getTime()返回的值是：\"+now.getTime());\r\n            Date zero = new Date(0);\r\n            System.out.println(\"用0作为构造方法，得到的日期是:\"+zero);\r\n        }\r\n    }\r\n\r\n**currentTimeMillis**()方法：获取当前日期的毫秒数\r\n\r\n    import java.util.Date;\r\n    public class TestDate {\r\n        public static void main(String[] args) {\r\n            Date now= new Date();\r\n            //当前日期的毫秒数\r\n            System.out.println(\"Date.getTime() \\t\\t\\t返回值: \"+now.getTime());\r\n            //通过System.currentTimeMillis()获取当前日期的毫秒数\r\n            System.out.println(\"System.currentTimeMillis() \\t返回值: \"+System.currentTimeMillis());\r\n        }\r\n    }\r\n![5b10e2581cb26.jpg](http://127.0.0.1:1111/articleImage/8326f956576f4ad9afa7fa4f1dd5fc80.jpg)', 9, 0, 1, NULL, 'http://127.0.0.1:1111/articleImage/8326f956576f4ad9afa7fa4f1dd5fc80.jpg', NULL, 1, '2020-02-08', '2020-02-08', 'admin', 'admin');
INSERT INTO `sys_article` VALUES (2, '系列文章之JDK8新特性(二)', '# JDK8新特性\r\n### 二.Lambda篇：\r\n#### 1.Lambda表达式：\r\nLambda表达式是JDK8中最重要的一个了，在JDK8之后你会看到一堆Lambda表达式的代码，要是不会那就看不懂别人的代码了。更别说自己写了。前面我们也说过了，Lambda可以很好的兼容函数式接口，它可以取代大部分的匿名内部类，写出更优雅的 Java 代码，尤其在集合的遍历和其他集合操作中，可以极大地优化代码结构。\r\n\r\n- #### 1.1 演变\r\n\r\nLambda表达式可以看成是匿名类一点点演变过来，我们现在有一个函数式接口（ps：注意抽象类是无法使用Lambda的哦，若是其中有抽象函数，只能写匿名函数实例化）\r\n\r\n    @FunctionalInterface\r\n    public interface Demo<T> {\r\n        T delete(int a, int b);\r\n    }\r\n\r\n我们要使用这个接口里面的方法有几种形式：\r\n\r\n- **实现类实现方法之后实例化实现类**：\r\n- **匿名函数实例化**\r\n- **Lambda形式**\r\n\r\n如：\r\n\r\n    // 实现类\r\n    public class DemoImpl implements Demo<Integer> {\r\n        @Override\r\n        public Integer delete(int a, int b) {\r\n            return a - b;\r\n        }\r\n    }\r\n    \r\n    // 实现类形式调用\r\n    Demo<Integer> demo = new DemoImpl();\r\n    System.out.println(demo.delete(10, 20));\r\n\r\n再来看看匿名函数形式的调用：\r\n\r\n    // 匿名函数调用\r\n    Demo<Integer> demo1 = new Demo() {\r\n        @Override\r\n        public Integer delete(int a, int b) {\r\n            return a - b;\r\n        }\r\n    };\r\n    System.out.println(demo1.delete(20, 10));\r\n\r\n上面的匿名函数我们可以去去它的壳，只保留方法参数和方法体，参数和方法体之间加上符号 ->，你会问，我都没有指定方法名呀？因为你只有一个方法，它是知道你要实现哪一个的。\r\n\r\n    // 第一遍去壳\r\n    Demo<Integer> demo1 = (int a, int b) -> {\r\n        return a - b;\r\n    };\r\n\r\n继续把return和{}去掉，(方法只有一条语句，才可以省略方法体大括号)\r\n\r\n    // 第二遍去壳\r\n    Demo<Integer> demo1 = (int a, int b) -> a - b;\r\n\r\n把 参数类型和圆括号去掉(只有一个参数的时候，才可以去掉圆括号)\r\n\r\n    // 第三遍去壳，最终的Lambda表达式诞生\r\n    Demo<Integer> demo1 = (a, b) -> a - b;\r\n    System.out.println(demo1.delete(20, 10));\r\n\r\n你可以比较看看代码量少了多少，匿名函数6行，这里只需要1行。而且lambda表达式是可以作为参数传递的，它的类型就是接口类型，比如有一个方法需要用到Demo这个接口的实例\r\n\r\n    // 有方法需要接口对象作为参数\r\n    public Integer add(int a, int b, int c, Demo<Integer> demo1) {\r\n        return a + demo1.delete(b, c);\r\n    }\r\n\r\n    // 可以写完Lambda实现之后直接传参\r\n    Demo<Integer> demo1 = (a, b) -> a - b);\r\n    add(10,20,30,demo1);\r\n\r\n    // 也可以直接写Lambda表达式作为参数，这一点匿名函数也是可以的，这是一种把方法作为参数进行传递的编程思想\r\n    add(10,20,30,(a, b) -> a - b);\r\n\r\n其实Java在背后，悄悄的把这些Lambda表达式都还原成匿名类方式。\r\n\r\n- #### 1.2 场景\r\n\r\nLambda表达式除了用于简化匿名函数之外，它还有一大作用是用于集合类上面，集合类对Lambda表达式做了兼容，我们就来看看有哪些应用场景吧。\r\n\r\n- **列表迭代（遍历）**\r\n\r\n列表迭代是集合的操作之一，但我们遍历一个集合对象的时候，可以循环，可以增强循环，可以迭代器。那么Lambda更加简化这个操作：\r\n\r\n    // 集合遍历\r\n    List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);\r\n    for (int element : numbers) {\r\n        System.out.println(element);\r\n    }\r\n\r\n    // Lambda形式\r\n    numbers.forEach(element -> System.out.println(element));\r\n\r\n为什么可以这么写？你看了.forEach的参数你就知道了，它是个函数式接口（Consumer消费性接口），所以可以Lambda做参数直接使用\r\n\r\n    default void forEach(Consumer<? super T> action) {\r\n        Objects.requireNonNull(action);\r\n        for (T t : this) {\r\n            action.accept(t);\r\n        }\r\n    }\r\n\r\n当然还可以这么写：（这种就是jdk8另外一个特性，叫方法引用，下文我们会讲）\r\n\r\n    numbers.forEach(System.out::println);\r\n\r\n- **事件监听**\r\n\r\n事件监听实在图形编程里面的，这里也是可以用Lambda的，因为它也是函数式接口作为参数\r\n\r\n    // 普通形式（匿名函数）\r\n    button.addActionListener(new ActionListener(){\r\n        @Override\r\n        public void actionPerformed(ActionEvent e) {\r\n            //handle the event\r\n        }\r\n    });\r\n\r\n    //Lambda形式\r\n    button.addActionListener(e -> {\r\n        //handle the event\r\n    });\r\n\r\nActionListener本身就是一个函数式接口。\r\n\r\n    public interface ActionListener extends EventListener {\r\n        /**\r\n        * Invoked when an action occurs.\r\n        */\r\n        public void actionPerformed(ActionEvent e);\r\n    }\r\n\r\n- **四个功能型接口实现**\r\n\r\nLambda表达式必须先定义接口，创建相关方法之后才能调用,这样做十分不便，其实java8已经内置了许多接口, 例如下面四个功能型接口.所有标注@FunctionalInterface注解的接口都是函数式接口，前面我们已经提过Consumer了，下面我们详细看一看这几个接口。\r\n\r\n - **Consumer** 消费型接口：有入参，无返回值。\r\n\r\n适用场景：因为没有出参，常⽤用于打印、发送短信等消费动作\r\n\r\n    @FunctionalInterface\r\n    public interface Consumer<T> {\r\n        void accept(T t);\r\n        ...\r\n    }\r\n\r\n - **Supplier** 供给型接口：无入参，有返回值。\r\n\r\n适用场景：泛型一定和方法的返回值类型是同一种类型，并且不需要传入参数,例如 无参的工厂方法\r\n\r\n    @FunctionalInterface\r\n    public interface Supplier<T> {\r\n        T get();\r\n    }\r\n\r\n - **Function** 函数型接口：有入参，有返回值。\r\n\r\n适用场景：传入参数经过函数的计算返回另一个值\r\n\r\n    @FunctionalInterface\r\n    public interface Function<T, R> {\r\n        R apply(T t);\r\n        ...\r\n    }\r\n\r\n - **Predicate** 断言型接口：有入参，有返回值，返回值类型确定是boolean。(断言是啥，自己Google咯)\r\n\r\n适用场景：接收一个参数，用于判断是否满一定的条件，过滤数据\r\n\r\n    @FunctionalInterface\r\n    public interface Predicate<T> {\r\n        boolean test(T t);\r\n        ...\r\n    }\r\n\r\n我们再看看实现吧，加深理解：\r\n\r\n    public class LambdaDemo {\r\n        public void consumer(double money, Consumer<Double> c) {\r\n            c.accept(money);\r\n        }\r\n\r\n        public void supplier(Supplier<Double> s) {\r\n            System.out.println(s.get());\r\n        }\r\n\r\n        public void function(Integer age, Function<Integer, String> f) {\r\n            System.out.println(f.apply(age));\r\n        }\r\n\r\n        public void predicate(double money, Predicate<Double> p) {\r\n            System.out.println(p.test(money));\r\n        }\r\n\r\n        public static void main(String[] args) {\r\n            LambdaDemo lambdaDemo = new LambdaDemo();\r\n            // 消费型接口\r\n            lambdaDemo.consumer(10, (x) -> System.out.println(x));\r\n            // 供给型接口\r\n            lambdaDemo.supplier(() -> 10D);\r\n            // 函数型接口\r\n            lambdaDemo.function(18, x -> x.toString());\r\n            // 断言型接口\r\n            lambdaDemo.predicate(10D, (x) -> x > 5D);\r\n        }\r\n    }\r\n\r\n- **Stream流中的Lambda**\r\n\r\nStream流也是JDK8的一个新特性，它是为了方便操作集合而生的。它可以配合Lambda进行一系列操作，这里我们列举一两个例子：reduce 操作，就是通过二元运算对所有元素进行聚合，最终得到一个结果。例如使用加法对列表进行聚合，就是将列表中所有元素累加，得到总和\r\n\r\n    List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5);\r\n    int sum = numbers.stream().reduce((x, y) -> x + y).get();\r\n    System.out.println(sum);\r\n\r\n使用 Stream 对象的 map 方法将原来的列表经由 Lambda 表达式映射为另一个列表，并通过 collect 方法转换回 List 类型：\r\n\r\n    List<Integer> numbers1 = Arrays.asList(1, 2, 3, 4, 5);\r\n    List<Integer> mapped = numbers1.stream().map(x -> x * 2).collect(Collectors.toList());\r\n    mapped.forEach(System.out::println);\r\n\r\nStream接口中的函数几乎都有四大基本函数式接口为参数，所以几乎都可以使用Lambda，不一一实践。反正原理都一样。\r\n\r\n- **线程**\r\n\r\n线程也是一样的道理，开线程的其中两个方法，实现Runnable，Callable接口，而这两个接口就是函数式接口。我上一篇文章说过，这里不再详细说明。\r\n\r\n- **Lambda 表达式中的闭包问题（题外话）**\r\n\r\n这个问题我们在匿名内部类中也会存在，如果我们把注释放开会报错，告诉我 num 值是 final 不能被改变。这里我们虽然没有标识 num 类型为 final，但是在编译期间虚拟机会帮我们加上 final 修饰关键字\r\n\r\n    import java.util.function.Consumer;\r\n    public class Main {\r\n        public static void main(String[] args) {\r\n            int num = 10;\r\n            Consumer<String> consumer = ele -> {\r\n                System.out.println(num);\r\n            };\r\n            //num = num + 2;\r\n            consumer.accept(\"hello\");\r\n        }\r\n    }\r\n\r\n#### 2.方法引用：\r\n方法引用是联系Lambda表达式一起使用，它相当于Lambda表达式的方法体里面如果用了一些特定的函数，那么可以再简化，分别有四种类型的方法引用，但是在解释之前我们先做一些准备工作：\r\n\r\n- 构造器引用\r\n- 静态方法引用\r\n- 对象方法引用\r\n- 容器中对象方法引用\r\n\r\n1.创建一个类，里面包含构造器，静态方法，普通方法三种即可\r\n\r\n    public class People {\r\n        People(){\r\n            System.out.println(\"我是构造方法\");\r\n        }\r\n\r\n        void print1(){\r\n            System.out.println(\"我是普通方法\");\r\n        }\r\n\r\n        static void print2(){\r\n            System.out.println(\"我是静态方法\");\r\n        }\r\n    }\r\n\r\n2.创建一个函数式接口\r\n\r\n    @FunctionalInterface\r\n    public interface PeopleInterface {\r\n        void test();\r\n    }\r\n\r\n3.创建一个Main函数\r\n\r\n    public class Main {\r\n        void constructorReference(PeopleInterface peopleInterface) {\r\n            peopleInterface.test();\r\n        }\r\n\r\n        void staticReference(PeopleInterface peopleInterface) {\r\n            peopleInterface.test();\r\n        }\r\n\r\n        void objectMethodReference(PeopleInterface peopleInterface) {\r\n            peopleInterface.test();\r\n        }\r\n\r\n        void containerObjectMethodReference(ArrayList<People> peopleArrayList, PeopleInterface2 peopleInterface2) {\r\n            for (People people : peopleArrayList) {\r\n                peopleInterface2.test(people);\r\n            }\r\n        }\r\n\r\n        // main函数\r\n        public static void main(String[] args) {\r\n            Main main = new Main();\r\n            ...\r\n        }\r\n    }\r\n\r\n接下来的操作都在main函数里执行：\r\n\r\n**构造器引用**：\r\n\r\n    // 匿名函数调用构造器\r\n    main.constructorReference(new PeopleInterface() {\r\n        @Override\r\n        public void test() {\r\n            new People();\r\n        }\r\n    });\r\n    // Lambda调用构造器\r\n    main.constructorReference(() -> new People());\r\n    // 构造器引用\r\n    main.constructorReference(People::new);\r\n\r\n\r\n可以清楚的看出当我们想要使用People类的构造器时有三种形式，而构造器引用形式就是直接帮你调用了，你无需写其他操作。其实::也是暗中帮你一步一步的实现匿名函数的。这也就更加让我们深入了解了函数式编程的思想，“**从起点到终点的道路只有一条，既然只有一条，那我们就把能省略的操作都省略，封装成“->”或是“::”它们的功能就是打通这条路，它不需要知道一些多余的信息，因为要实现的方法只有一个/要实现的功能只有一个，你只需要给出必要的参数和实现内容，其他的全由符号搞定**”\r\n\r\n**静态方法引用**：\r\n\r\n    // 匿名函数调用静态函数\r\n    main.staticReference(new PeopleInterface() {\r\n        @Override\r\n        public void test() {\r\n            People.print2();\r\n        }\r\n    });\r\n    // Lambda调用静态函数\r\n    main.staticReference(() -> People.print2());\r\n    // 静态函数引用\r\n    main.staticReference(People::print2);\r\n\r\n静态函数/方法也称类函数/方法，所以引用的时候直接用类名引用\r\n\r\n**对象方法引用**：\r\n\r\n    // 匿名函数调用普通函数\r\n    main.objectMethodReference(new PeopleInterface() {\r\n        @Override\r\n        public void test() {\r\n            new People().print1();\r\n        }\r\n    });\r\n    // Lambda调用普通函数\r\n    main.objectMethodReference(() -> new People().print1());\r\n    // 普通函数的引用\r\n    People people = new People();\r\n    main.objectMethodReference(people::print1);\r\n\r\n**容器中对象方法引用**\r\n这个东西稍微复杂一点，它的意思时当对象一集合或者对象数组形式存放，我们也可以直接使用类名引用。为了不影响之前的函数式接口，我们重建一个函数式接口\r\n\r\n    // 新的函数式接口\r\n    public interface PeopleInterface2 {\r\n        void test(People people);\r\n    }\r\n\r\n\r\n    ArrayList<People> peopleArrayList = new ArrayList<>();\r\n    for (int i = 0; i < 5; i++) {\r\n        peopleArrayList.add(new People());\r\n    }\r\n    // 匿名函数调用容器里面的普通函数\r\n    main.containerObjectMethodReference(peopleArrayList, new PeopleInterface2() {\r\n        @Override\r\n        public void test(People people) {\r\n            people.print1();\r\n        }\r\n    });\r\n    // Lambda调用容器里面的普通函数\r\n    main.containerObjectMethodReference(peopleArrayList, (people1) -> people1.print1());\r\n    // 容器里面的普通函数引用\r\n    main.containerObjectMethodReference(peopleArrayList, People::print1);\r\n\r\n这个很简单的，我就不多解释了，体会代码吧~\r\nLambda表达式就告一段落了，接下来的最后一篇将会很短，因为最最主要的特性我们已经学了，别的特性都很简单，我将简单介绍即可。\r\n\r\n------------\r\n\r\n### 每日一类之Optional\r\n这个类也是JDK8特性之一，但有的文章并没有拿出来单独讲，作为一个新增的容器/工具类，我们也只是学会怎么用即可。Optional 类主要解决的问题是臭名昭著的空指针异常（NullPointerException），本质上，这是一个包含有可选值的包装类，这意味着 Optional 类既可以含有对象也可以为空。Optional 也是 Java 实现函数式编程的强劲一步。\r\n\r\n**以前**：我们是不是讲过stream流的reduce聚合方法，你点进去看源码，你会发现，咦？返回值是Optional类型的哎。在以前我们为了确保逻辑正确不报错，会这么写（好多判空啊，什么鬼代码）：\r\n\r\n    if (user != null) {\r\n        Address address = user.getAddress();\r\n        if (address != null) {\r\n            Country country = address.getCountry();\r\n            if (country != null) {\r\n                String isocode = country.getIsocode();\r\n                if (isocode != null) {\r\n                    isocode = isocode.toUpperCase();\r\n                }\r\n            }\r\n        }\r\n    }\r\n\r\n**Optional则可以这样**：要用哪些方法随你咯\r\n\r\n    // 创建一个空的 Optional\r\n    Optional<User> emptyOpt = Optional.empty();\r\n    // 创建一定包含值的 Optional\r\n    Optional<User> opt = Optional.of(user);\r\n    // 创建可能是 null 也可能是非 null的 Optional\r\n    Optional<User> opt = Optional.ofNullable(user);\r\n    // 判断是否为空\r\n    isPresent() \r\n    // 该方法除了执行检查，还接受一个Consumer(消费者) 参数，如果对象不是空的，就对执行传入的 Lambda 表达式\r\n    ifPresent() \r\n    // 如果有值则返回该值，否则返回传递给它的参数值\r\n    // 如果为非空，返回 Optional 描述的指定值，否则返回空的 Optional\r\n    ofNullable()\r\n    orElse() \r\n    // 这个方法会在有值的时候返回值，如果没有值，它会执行作为参数传入的 Supplier(供应者) 函数式接口，并将返回其执行结果\r\n    orElseGet() \r\n    // 它会在对象为空的时候抛出异常，而不是返回备选的值\r\n    orElseThrow()\r\n    // 取值\r\n    get() \r\n![re3213w31ar3.jpg](http://127.0.0.1:1111/articleImage/fd42f7d3b69246b1a9d10fdb8b617cc1.jpg)', 3, 0, 1, NULL, 'http://127.0.0.1:1111/articleImage/fd42f7d3b69246b1a9d10fdb8b617cc1.jpg', NULL, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');
INSERT INTO `sys_article` VALUES (3, '系列文章之JDK8新特性(三)', '# JDK8新特性\r\n### 三.杂篇：\r\n#### 1.base64：\r\n由于某些系统中只能使用ASCII字符。Base64就是用来将非ASCII字符的数据转换成ASCII字符的一种方法。 Base64其实不是安全领域下的加密解密算法，而是一种编码，也就是说，它是可以被翻译回原来的样子。它并不是一种加密过程。所以base64只能算是一个编码算法，对数据内容进行编码来适合传输。虽然base64编码过后原文也变成不能看到的字符格式，但是这种方式很初级，很简单。\r\n\r\nBase64就是 一种基于64个可打印字符来表示二进制数据的方法， 基于64个字符A-Z,a-z，0-9，+，/的编码方式， 是一种能将任意二进制数据用64种字元组合成字符串的方法：\r\n\r\n    import sun.misc.BASE64Decoder;\r\n    import sun.misc.BASE64Encoder;\r\n\r\n    import java.util.Base64;\r\n\r\n    public class Main {\r\n        public static void main(String[] args) throws Exception {\r\n            /**\r\n            * jdk8以前的写法\r\n            * 编码和解码的效率⽐较差，公开信息说以后的版本会取消这个⽅法\r\n            */\r\n            BASE64Encoder encoder = new BASE64Encoder();\r\n            BASE64Decoder decoder = new BASE64Decoder();\r\n            byte[] textByte = \"敷衍三连，哦，牛批，666\".getBytes(\"UTF-8\");\r\n            //编码\r\n            String encodedText = encoder.encode(textByte);\r\n            System.out.println(encodedText);//5Zyj6a2U5a+85biI\r\n            //解码\r\n            System.out.println(new String(decoder.decodeBuffer(encodedText), \"UTF-8\"));//圣魔导师\r\n\r\n            /**\r\n            * jdk8的写法\r\n            * 编解码销量远⼤于 sun.misc 和 Apache Commons Codec，可以自己动手压测一下速度\r\n            */\r\n            Base64.Decoder decoder2 = Base64.getDecoder();\r\n            Base64.Encoder encoder2 = Base64.getEncoder();\r\n            byte[] textByte2 = \"敷衍三连，哦，牛批，666\".getBytes(\"UTF-8\");\r\n            //编码\r\n            String encodedText2 = encoder2.encodeToString(textByte2);\r\n            System.out.println(encodedText);//5Zyj6a2U5a+85biI\r\n            //解码\r\n            System.out.println(new String(decoder2.decode(encodedText2), \"UTF-8\"));//圣魔导师\r\n        }\r\n    }\r\n\r\n#### 2.最新的Date/Time：\r\nSimpleDateFormat,Calendar等类的 API设计⽐较差，⽇期/时间对象⽐较，加减麻烦,Date 还是⾮线程安全的，Java 8通过发布新的Date-Time API (JSR 310)来进一步加强对日期与时间的处理。以下为两个比较重要的 API：\r\n\r\n    1.Local(本地) − 简化了日期时间的处理，没有时区的问题。\r\n    2.Zoned(时区) − 通过制定的时区处理日期时间。\r\n\r\n新的java.time包涵盖了所有处理日期，时间，日期/时间，时区，时刻（instants），过程（during）与时钟（clock）的操作\r\n\r\n#### 3.支持并行（parallel）数组：\r\nJava 8增加了大量的新方法来对数组进行并行处理。可以说，最重要的是parallelSort()方法，因为它可以在多核机器上极大提高数组排序的速度：\r\n\r\n    long[] arrayOfLong = new long [ 20000 ];\r\n    //1.给数组随机赋值\r\n    Arrays.parallelSetAll( arrayOfLong, index -> ThreadLocalRandom.current().nextInt( 1000000 ) );\r\n    //2.打印出前10个元素\r\n    Arrays.stream( arrayOfLong ).limit( 10 ).forEach(i -> System.out.print( i + \" \" ) );\r\n    System.out.println();\r\n    //3.数组排序\r\n    Arrays.parallelSort( arrayOfLong );\r\n    //4.打印排序后的前10个元素\r\n    Arrays.stream( arrayOfLong ).limit( 10 ).forEach(i -> System.out.print( i + \" \" ) );\r\n    System.out.println();\r\n\r\n#### 4.Stream流操作：\r\n通过将集合转换为这么⼀种叫做 “流”的元素队列，能够对集合中的每个元素进行任意操作。总共分为4个步骤：\r\n - 数据元素便是原始集合：如List、Set、Map等\r\n - 生成流：可以是串行流stream() 或者并行流 parallelStream()\r\n - 中间操作：可以是 排序，聚合，过滤，转换等\r\n - 终端操作：统一收集返回一个流\r\n\r\n 代码来~~~:\r\n\r\n    package cn.xy.importantKnowledge.stream;\r\n\r\n    import java.util.*;\r\n    import java.util.stream.Collectors;\r\n    import java.util.stream.Stream;\r\n\r\n    public class Main {\r\n        public static void main(String[] args) {\r\n            List<String> list = Arrays.asList(\"张麻子\", \"李蛋\", \"王二狗\", \"Angell\");\r\n            List<Student> users = Arrays.asList(\r\n                    new Student(\"张三\", 23),\r\n                    new Student(\"赵四\", 24),\r\n                    new Student(\"二狗\", 23),\r\n                    new Student(\"田七\", 22),\r\n                    new Student(\"皮特\", 20),\r\n                    new Student(\"Tony\", 20),\r\n                    new Student(\"二柱子\", 25));\r\n            /**\r\n            * map：对集合的每个对象做处理\r\n            */\r\n            List<String> collect = list.stream().map(obj -> \"哈哈\" + obj).collect(Collectors.toList());\r\n            list.forEach(obj -> System.out.println(obj));\r\n            System.out.println(\"----------------\");\r\n            collect.forEach(obj -> System.out.println(obj));\r\n\r\n            /**\r\n            * filter：boolean判断，用于条件过滤\r\n            */\r\n            System.out.println(\"----------------\");\r\n            Set<String> set = list.stream().filter(obj -> obj.length() > 2).collect(Collectors.toSet());\r\n            set.forEach(obj -> System.out.println(obj));\r\n\r\n            /**\r\n            * sorted：对流进行自然排序\r\n            */\r\n            System.out.println(\"----------------\");\r\n            Set<String> sorteds = list.stream().sorted().collect(Collectors.toSet());\r\n            sorteds.forEach(obj -> System.out.println(obj));\r\n            // 自定义排序规则\r\n            // 根据长度排序(正序)\r\n            System.out.println(\"----------------\");\r\n            List<String> resultList = list.stream().sorted(Comparator.comparing(obj -> obj.length())).collect(Collectors.toList());\r\n            resultList.forEach(obj -> System.out.println(obj));\r\n            System.out.println(\"----------------\");\r\n            // 根据长度排序(倒序)\r\n            List<String> resultList2 = list.stream().sorted(Comparator.comparing(obj -> obj.length(), Comparator.reverseOrder())).collect(Collectors.toList());\r\n            resultList2.forEach(obj -> System.out.println(obj));\r\n            System.out.println(\"----------------\");\r\n            // 手动指定排序规则(根据年龄大小排序)\r\n            List<Student> collect2 = users.stream().sorted(\r\n                    Comparator.comparing(Student::getAge, (x, y) -> {\r\n                        if (x > y) {\r\n                            return 1;\r\n                        } else {\r\n                            return -1;\r\n                        }\r\n                    })\r\n            ).collect(Collectors.toList());\r\n            collect2.forEach(obj -> System.out.println(obj.getAge() + \" : \" + obj.getProvince()));\r\n\r\n            /**\r\n            * limit：截取包含指定数量的元素\r\n            */\r\n            System.out.println(\"----------------\");\r\n            List<String> collect3 = list.stream().limit(2).collect(Collectors.toList());\r\n            collect3.forEach(obj -> System.out.println(obj));\r\n\r\n            /**\r\n            * allMatch：匹配所有元素，只有全部符合才返回true\r\n            */\r\n            System.out.println(\"----------------\");\r\n            boolean flag = list.stream().allMatch(obj -> obj.length() > 2);\r\n            System.out.println(flag);\r\n            System.out.println(\"----------------\");\r\n\r\n            /**\r\n            * anyMatch：匹配所有元素，至少一个元素满足就为true\r\n            */\r\n            boolean flag2 = list.stream().anyMatch(obj -> obj.length() > 2);\r\n            System.out.println(flag2);\r\n            System.out.println(\"----------------\");\r\n            \r\n            /**\r\n            * max和min：最大值和最小值\r\n            */\r\n            Optional<Student> max = users.stream().max(Comparator.comparingInt(Student::getAge));\r\n            System.out.println(max.get().getAge() + \" : \" + max.get().getProvince());\r\n            System.out.println(\"----------------\");\r\n            Optional<Student> min = users.stream().min((s1, s2) -> Integer.compare(s1.getAge(), s2.getAge()));\r\n            System.out.println(min.get().getAge() + \" : \" + min.get().getProvince());\r\n\r\n            /**\r\n            * reduce：对Stream中的元素进行计算后返回一个唯一的值\r\n            */\r\n            // 计算所有值的累加\r\n            int value = Stream.of(1, 2, 3, 4, 5).reduce((item1, item2) -> item1 + item2).get();\r\n            // 100作为初始值，然后累加所有值\r\n            int value2 = Stream.of(1, 2, 3, 4, 5).reduce(100, (sum, item) -> sum + item);\r\n            // 找出最大值\r\n            int value3 = Stream.of(1, 4, 5, 2, 3).reduce((x, y) -> x > y ? x : y).get();\r\n\r\n            System.out.println(value);\r\n            System.out.println(value2);\r\n            System.out.println(value3);\r\n        }\r\n    }\r\n\r\n\r\n    class Student {\r\n        private String province;\r\n        private int age;\r\n\r\n        public String getProvince() {\r\n            return province;\r\n        }\r\n\r\n        public void setProvince(String province) {\r\n            this.province = province;\r\n        }\r\n\r\n        public int getAge() {\r\n            return age;\r\n        }\r\n\r\n        public void setAge(int age) {\r\n            this.age = age;\r\n        }\r\n\r\n        public Student(String province, int age) {\r\n            this.age = age;\r\n            this.province = province;\r\n        }\r\n    }\r\n\r\n#### 5.注解相关:\r\n\r\n**可以进行重复注解**\r\n自从Java 5引入了注解机制，这一特性就变得非常流行并且广为使用。然而，使用注解的一个限制是相同的注解在同一位置只能声明一次，不能声明多次。Java 8打破了这条规则，引入了重复注解机制，这样相同的注解可以在同一地方声明多次。重复注解机制本身必须用@Repeatable注解。事实上，这并不是语言层面上的改变，更多的是编译器的技巧，底层的原理保持不变。\r\n\r\n    // 自定义一个包装类Hints注解用来放置一组具体的Hint注解\r\n    @interface MyHints {\r\n        Hint[] value();\r\n    }\r\n\r\n    @Repeatable(MyHints.class)\r\n    @interface Hint {\r\n        String value();\r\n    }\r\n\r\n    // 旧方法\r\n    @MyHints({@Hint(\"hint1\"), @Hint(\"hint2\")})\r\n    class Person {}\r\n\r\n    // 新方法\r\n    @Hint(\"hint1\")\r\n    @Hint(\"hint2\")\r\n    class Person {}\r\n\r\n**扩展注解的支持**\r\nJava 8扩展了注解的上下文。现在几乎可以为任何东西添加注解：局部变量、泛型类、父类与接口的实现，就连方法的异常也能添加注解。而且新增了两个Target的值：\r\n\r\n- ElementType.TYPE_PARAMETER 表示该注解能写在类型变量的声明语句中。\r\n- ElementType.TYPE_USE 表示该注解能写在使用类型的任何语句中（eg：声明语句、泛型和强制转换语句中的类型）。\r\n\r\n------------\r\n\r\n### 每日一类之Stream数据处理方法\r\n今天的每日一类没啥文字描述的，直接上代码\r\n\r\n    package cn.xy.importantKnowledge.collector;\r\n\r\n    import java.util.*;\r\n    import java.util.concurrent.CopyOnWriteArrayList;\r\n    import java.util.stream.Collectors;\r\n    import java.util.stream.Stream;\r\n\r\n    public class Main {\r\n        /**\r\n        * 数据结构收集collectors\r\n        *\r\n        * @author Soul\r\n        * @date 2020/2/17 23:09\r\n        */\r\n        private void collectors() {\r\n            List<String> data = Arrays.asList(\"张三\", \"王五\", \"李四\");\r\n            List<String> list = data.stream().collect(Collectors.toList());\r\n            Set<String> set = data.stream().collect(Collectors.toSet());\r\n            LinkedList<String> linkedList = data.stream().collect(Collectors.toCollection(LinkedList::new));\r\n            System.out.println(list);\r\n            System.out.println(set);\r\n            System.out.println(linkedList);\r\n            Collectors.toSet();\r\n            Collectors.toCollection(LinkedList::new);\r\n            Collectors.toCollection(CopyOnWriteArrayList::new);\r\n            Collectors.toCollection(TreeSet::new);\r\n        }\r\n\r\n        /**\r\n        * 拼接器joining\r\n        *\r\n        * @author Soul\r\n        * @date 2020/2/17 23:09\r\n        */\r\n        private void joining() {\r\n            List<String> list = Arrays.asList(\"springBoot\", \"springCloud\", \"netty\");\r\n            String result1 = list.stream().collect(Collectors.joining());\r\n            String result2 = list.stream().collect(Collectors.joining(\"——\"));\r\n            String result3 = list.stream().collect(Collectors.joining(\"—\", \"【\", \"\"));\r\n            String result4 = Stream.of(\"hello\", \"world\").collect(Collectors.joining(\"—\", \"【\", \"】\"));\r\n\r\n            System.out.println(result1);\r\n            System.out.println(result2);\r\n            System.out.println(result3);\r\n            System.out.println(result4);\r\n        }\r\n\r\n        /**\r\n        * 分组器partitioning\r\n        *\r\n        * @author Soul\r\n        * @date 2020/2/17 23:11\r\n        */\r\n        private void partitioning() {\r\n            List<String> list = Arrays.asList(\"sdfsdf\", \"xxxx\", \"bbb\", \"bbb\");\r\n            Map<Boolean, List<String>> collect = list.stream().collect(Collectors.partitioningBy(obj -> obj.length() > 3));\r\n            System.out.println(collect);\r\n        }\r\n\r\n        /**\r\n        * 统计器counting\r\n        *\r\n        * @author Soul\r\n        * @date 2020/2/17 23:11\r\n        */\r\n        private void counting() {\r\n            List<Student> students = Arrays.asList(new Student(\"⼴东\", 23),\r\n                    new Student(\"⼴东\", 24),\r\n                    new Student(\"⼴东\", 23),\r\n                    new Student(\"北京\", 22),\r\n                    new Student(\"北京\", 20),\r\n                    new Student(\"北京\", 20),\r\n                    new Student(\"海南\", 25));\r\n            // 通过名称分组\r\n            Map<String, List<Student>> listMap = students.stream().collect(Collectors.groupingBy(obj -> obj.getProvince()));\r\n            listMap.forEach((key, value) -> {\r\n                System.out.println(\"========\");\r\n                System.out.println(key);\r\n                value.forEach(obj -> {\r\n                    System.out.println(obj.getAge());\r\n                });\r\n            });\r\n            System.out.println(\"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\");\r\n            // 根据名称分组，并统计每个分组的个数\r\n            Map<String, Long> map = students.stream().collect(Collectors.groupingBy(Student::getProvince, Collectors.counting()));\r\n            map.forEach((key, value) -> {\r\n                System.out.println(key + \"省人数有\" + value);\r\n            });\r\n        }\r\n\r\n        /**\r\n        * 统计器summarizing\r\n        *\r\n        * @author Soul\r\n        * @date 2020/2/17 23:13\r\n        */\r\n        private void summarizing() {\r\n            List<Student> students = Arrays.asList(new Student(\"⼴东\", 23),\r\n                    new Student(\"⼴东\", 24),\r\n                    new Student(\"⼴东\", 23),\r\n                    new Student(\"北京\", 22),\r\n                    new Student(\"北京\", 20),\r\n                    new Student(\"北京\", 20),\r\n                    new Student(\"海南\", 25));\r\n            // summarizingInt；  summarizingLong；    summarizingDouble\r\n            IntSummaryStatistics summaryStatistics = students.stream().collect(Collectors.summarizingInt(Student::getAge));\r\n            System.out.println(\"平均值：\" + summaryStatistics.getAverage());\r\n            System.out.println(\"人数：\" + summaryStatistics.getCount());\r\n            System.out.println(\"最大值：\" + summaryStatistics.getMax());\r\n            System.out.println(\"最小值：\" + summaryStatistics.getMin());\r\n            System.out.println(\"总和：\" + summaryStatistics.getSum());\r\n        }\r\n\r\n        /**\r\n        * 计算器reduce\r\n        *\r\n        * @author Soul\r\n        * @date 2020/2/17 23:14\r\n        */\r\n        private void reduce() {\r\n            // 计算所有值的累加\r\n            int value = Stream.of(1, 2, 3, 4, 5).reduce((item1, item2) -> item1 + item2).get();\r\n            // 100作为初始值，然后累加所有值\r\n            int value2 = Stream.of(1, 2, 3, 4, 5).reduce(100, (sum, item) -> sum + item);\r\n            // 找出最大值\r\n            int value3 = Stream.of(1, 4, 5, 2, 3).reduce((x, y) -> x > y ? x : y).get();\r\n\r\n            System.out.println(value);\r\n            System.out.println(value2);\r\n            System.out.println(value3);\r\n        }\r\n\r\n        public static void main(String[] args) throws Exception {\r\n            Main main = new Main();\r\n            main.collectors();\r\n            main.counting();\r\n            main.joining();\r\n            main.partitioning();\r\n            main.reduce();\r\n            main.summarizing();\r\n        }\r\n    }\r\n\r\n    class Student {\r\n        private String province;\r\n        private int age;\r\n        public String getProvince() {\r\n            return province;\r\n        }\r\n        public void setProvince(String province) {\r\n            this.province = province;\r\n        }\r\n        public int getAge() {\r\n            return age;\r\n        }\r\n        public void setAge(int age) {\r\n            this.age = age;\r\n        }\r\n        public Student(String province, int age) {\r\n            this.age = age;\r\n            this.province = province;\r\n        }\r\n    }\r\n\r\n![timg.jpg](http://127.0.0.1:1111/articleImage/64d6548540b846bd911fa8c69ead3bf4.jpg)', 2, 0, 1, NULL, 'http://127.0.0.1:1111/articleImage/64d6548540b846bd911fa8c69ead3bf4.jpg', NULL, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');
INSERT INTO `sys_article` VALUES (4, '集合类综合讲解', '# 集合\r\n**集合类在java中有着不言而喻的地位，在我看来，学完java基础之后的java中级中就有它的一席之地**\r\n\r\n### 一.综述:\r\n**1.以“345”口诀来看的话，常见的有：**\r\n\r\n- List的实现类有ArrayList，LinkedList，Vector(3个)；\r\n- Set的实现类有HashSet，TreeSet，EnumSet，LinkedHashSet(4个)；\r\n- Map的实现类有HashMap，TreeMap，EnumMap，HashTable，LinkedHashMap(5个)；\r\n\r\n**2.上面的只是常见的，不常见的有：**\r\n\r\n- List还有不常见的Stack，AttributeList等；\r\n- Set还有不常见的HashAttributeSet；(ps：EntrySet和KeySet会被误以为是Set实现类，这两个其实不是Set实现类，而是Map实现类里面的两个内部类，是为了Map部分数据的组织，方便迭代查找操作；重点的是和他们同名的两个函数entrySet()，keySet())；\r\n- Map还有不常见的WeakHashMap，IdentityHashMap，ConcurrentHashMap等；\r\n- 当然，这些不常见的大多都是继承于上面常见的实现类，Map那几个不是，它们属于独立的集合实现类。\r\n\r\n**3.三大集合实现关系：**\r\n\r\n- Set和List并不是顶级接口，他们之上还有一个Collection接口，Collection接口之上还有个Iterable接口，这里就可以看出了Set和List 是继承同样的接口以迭代器模式形成的（迭代器模式建议去看看设计模式，设计模式对于高级的软件开发人员是必不可少的）\r\n- Map接口自身就是顶级接口，他没用任何设计模式，就为Map的那几个实现类提供接口\r\n- 值得注意的是Set大多数实现类是继承于Map的实现类的，如EntrySet，KeySet，HashSet，TreeSet等。所以总结说来Set和List的接口规范相同，但Set与Map的底层实现基本相同\r\n[图片位]\r\n\r\n**4.联系于数据结构：**\r\n\r\n学过数据结构我们都知道，逻辑结构有线性表和非线性表之分。线性表对应的物理结构又有顺序表（数组），链表，栈，队列，串；线性表对应的物理结构又有树，图，集合；还有顺序表（数组）+链表形成的特殊的结构——散列/哈希表。这其实与集合这部分知识点是相对应的：\r\nList：\r\n\r\n- ArrayList——顺序表（数组）\r\n- Vector——顺序表（线程安全数组）\r\n- LinkedList——双向链表\r\n\r\nSet：\r\n\r\n- EnumSet——顺序表（枚举类型的数组）\r\n- TreeSet——红黑树（基于TreeMap）\r\n- HashSet——哈希表（基于HashMap）\r\n- LinkedHashSet——哈希表+双向链表（基于HashSet）\r\n\r\nMap：\r\n\r\n- EnumMap——顺序表（K-V形式）（枚举类型的数组）\r\n- TreeMap——红黑树（K-V形式）\r\n- HashTable——哈希表（K-V形式，线程安全）（jdk1.8之后转为哈希表+红黑树）\r\n- HashMap——哈希表（K-V形式）（jdk1.8之后转为哈希表+红黑树）\r\n- LinkedHashMap——哈希表+双向链表（K-V形式）（jdk1.8之后转为哈希表+红黑树+双向链表）\r\n\r\n### 二.List\r\nList我们主要讲3个：\r\n\r\n- **ArrayList**\r\n\r\n这个是最简单的一种集合类型，它的底层实现就是数组，没有别的。我这边贴出源码并注释出来，大家看看它的属性有哪些：\r\n\r\n    // ArrayList的基本属性\r\n    // 序列化版本Id\r\n    private static final long serialVersionUID = 8683452581122892189L;\r\n    // 默认容量\r\n    private static final int DEFAULT_CAPACITY = 10;\r\n    // 空元素数据\r\n    private static final Object[] EMPTY_ELEMENTDATA = new Object[0];\r\n    // 空元素数据的默认容量\r\n    private static final Object[] DEFAULTCAPACITY_EMPTY_ELEMENTDATA = new Object[0];\r\n    // 元素数据（ps：transient关键字作用是让这个属性不进行序列化）\r\n    transient Object[] elementData;\r\n    // 尺寸\r\n    private int size;\r\n    // 最大尺寸\r\n    private static final int MAX_ARRAY_SIZE = 2147483639;\r\n不难看出底层是一个数组实现的顺序表了吧。\r\n\r\n- **LinkedList**\r\n\r\n这是以双向链表形式存储的集合形式，同样的给你们看源码：（注意，它不仅实现双向链表Deque，还实现了队列Queue哦）\r\n\r\n    // LinkedList的基本属性\r\n    // 尺寸\r\n    transient int size;\r\n    // 首元结点\r\n    transient LinkedList.Node<E> first;\r\n    // 尾结点\r\n    transient LinkedList.Node<E> last;\r\n    // 序列化版本Id\r\n    private static final long serialVersionUID = 876323262645176354L;\r\n我们再看看结点定义：\r\n\r\n    // LinkedList的结点信息\r\n    // 泛型结点，任何类型都可以\r\n    private static class Node<E> {\r\n        // 当前类型\r\n        E item;\r\n        // 下一结点\r\n        LinkedList.Node<E> next;\r\n        // 上一结点\r\n        LinkedList.Node<E> prev;\r\n\r\n        // 构造函数(Constructor)\r\n        Node(LinkedList.Node<E> prev, E element, LinkedList.Node<E> next) {\r\n            this.item = element;\r\n            this.next = next;\r\n            this.prev = prev;\r\n        }\r\n    }\r\n\r\n- **Vector**\r\n\r\nVector和ArrayList一样，同样是数组实现的顺序表，但是它的方法基本都带有synchronized（同步锁）关键字，这表明它是线程安全的，不会发生死锁等情况。但相对的，安全的同时，效率是极低的。所以除非是真的要做线程安全，不然的话不建议使用，老规矩，贴源码：\r\n\r\n    // Vector的基本属性\r\n    // 元素数据\r\n    protected Object[] elementData;\r\n    // 元素计数\r\n    protected int elementCount;\r\n    // 容量增加\r\n    protected int capacityIncrement;\r\n    // 序列化版本Id\r\n    private static final long serialVersionUID = -2767605614048989439L;\r\n    // 最大尺寸\r\n    private static final int MAX_ARRAY_SIZE = 2147483639;\r\n我们再看看它的几个方法：\r\n\r\n    // Vector的部分线程安全方法\r\n    public synchronized int capacity() {\r\n        return this.elementData.length;\r\n    }\r\n\r\n    public synchronized int size() {\r\n        return this.elementCount;\r\n    }\r\n\r\n    public synchronized boolean isEmpty() {\r\n        return this.elementCount == 0;\r\n    }\r\n都是有synchronized修饰的，证明它是进行了线程的同步互斥操作的（管程）。\r\n\r\n### 三.Set和Map对比学习\r\nSet我们主要讲4个，Map讲5个，并且我们采用对比学习的形式，因为Set和Map有很大的瓜葛\r\n\r\n- **HashTable与HashMap**\r\n\r\n两者的底层实现都是以哈希表+红黑树（jdk8之前只以哈希表实现），看源码：\r\n\r\n    // HashMap的基本属性\r\n    // 序列化版本Id\r\n    private static final long serialVersionUID = 362498820763181265L;\r\n    // 默认初始容量\r\n    static final int DEFAULT_INITIAL_CAPACITY = 16;\r\n    // 最大容量\r\n    static final int MAXIMUM_CAPACITY = 1073741824;\r\n    // 默认负载因子\r\n    static final float DEFAULT_LOAD_FACTOR = 0.75F;\r\n    /**\r\n     * 这里说明一下，之后的三个属性就是jdk8之后加入的，与红黑树转化有关。\r\n     *\r\n     * 树化阈值：为bin使用tree还是list一个bin数目阈值。\r\n     * 在至少达到这个数目节点的情况下增加元素，bins将会转化成tree。\r\n     * 该值必须大于2，至少应该是8，与移除树的假设相适应\r\n     */\r\n    static final int TREEIFY_THRESHOLD = 8;\r\n    // 还原阈值：在调整大小操作时反树化（切分）一个bin的bin数目阈值，在移除时检测最大是6\r\n    static final int UNTREEIFY_THRESHOLD = 6;\r\n    // 树形化时bins的最小哈希表容量：为避免在调整大小和树形化阈值之间产生矛盾，这个值至少是4\r\n    static final int MIN_TREEIFY_CAPACITY = 64;\r\n    // 哈希表结点\r\n    transient HashMap.Node<K, V>[] table;\r\n    /**\r\n     * 提供给entrySet()函数使用的属性。(ps：entrySet()函数是快速遍历Map的K-V的函数)\r\n     *\r\n     * 这里说明一下，还有一个keySet属性是提供给keySet()函数使用的属性，但这个属性位于抽象类AbstractMap中。\r\n     * \r\n     * ps:keySet()同样是快速遍历Map的K-V的函数，但是推荐entrySet()，\r\n     * keySet其实是遍历了2次，一次是转为Iterator对象，另一次是从hashMap中取出key对应value。\r\n     */\r\n    transient Set<Entry<K, V>> entrySet;\r\n    // 尺寸\r\n    transient int size;\r\n    // 模数\r\n    transient int modCount;\r\n    // 阈\r\n    int threshold;\r\n    // 负载系数\r\n    final float loadFactor;\r\n------------\r\n    // HashMap的结点信息\r\n    static class Node<K, V> implements Entry<K, V> {\r\n        // 哈希值，根据冲突算法计算\r\n        final int hash;\r\n        // 键\r\n        final K key;\r\n        // 值\r\n        V value;\r\n        // 下个结点\r\n        HashMap.Node<K, V> next;\r\n\r\n        // 构造函数(Constructor)\r\n        Node(int hash, K key, V value, HashMap.Node<K, V> next) {\r\n            this.hash = hash;\r\n            this.key = key;\r\n            this.value = value;\r\n            this.next = next;\r\n        }\r\n    ...}\r\n根据源码我们也看出来它的底层是哈希表与红黑树实现的，HashTable的底层和HashMao的大同小异，我就不全部说明：\r\n\r\n    // hashTable结点属性\r\n    private transient Hashtable.Entry<?, ?>[] table;\r\n\r\n    // hashTable结点信息\r\n    private static class Entry<K, V> implements java.util.Map.Entry<K, V> {\r\n        // 哈希值，根据冲突算法计算\r\n        final int hash;\r\n        // 键\r\n        final K key;\r\n        // 值\r\n        V value;\r\n        // 下个结点\r\n        Hashtable.Entry<K, V> next;\r\n\r\n        // 构造函数(Constructor)\r\n        protected Entry(int hash, K key, V value, Hashtable.Entry<K, V> next) {\r\n            this.hash = hash;\r\n            this.key = key;\r\n            this.value = value;\r\n            this.next = next;\r\n        }\r\n    ...}\r\n那么他俩什么区别呢？最大的区别就像是Vector和ArrayList一样的，一个有线程安全但效率慢(HashTable)，一个无线程安全但是效率快(HashMap)，这里不再赘述，看看源码就知道。（同样的，建议使用HashMap，除非真的做线程安全时候才用HashTable。而且HashMap自身也可以实现线程安全，调用Collections.synchronizedMap()获取一个线程安全的集合即可）。还有一个区别是HashMap可以存放null而Hashtable不能存放null\r\n\r\n    // HashTable的部分线程安全方法\r\n    public synchronized boolean isEmpty() {\r\n        return this.count == 0;\r\n    }\r\n\r\n    public synchronized Enumeration<K> keys() {\r\n        return this.getEnumeration(0);\r\n    }\r\n\r\n    public synchronized Enumeration<V> elements() {\r\n        return this.getEnumeration(1);\r\n    }\r\n\r\n- **HashMap与HashSet**\r\n\r\n我们前面也提过，HashSet是基于HashMap的，所以他们的大多功能是一致的，我们随便看两个HashSet的构造函数就可以看出它都 new 了一个 HashMap。(HashSet同样是非线程安全的)\r\n\r\n    // HashSet的构造函数，都有HashMap的身影\r\n    public HashSet(int initialCapacity, float loadFactor) {\r\n        this.map = new HashMap(initialCapacity, loadFactor);\r\n    }\r\n\r\n    public HashSet(int initialCapacity) {\r\n        this.map = new HashMap(initialCapacity);\r\n    }\r\n所以显而易见，HashSet的底层是和HashMap一致的。那么他们有什么区别呢？我们看一看：\r\n**Set：**\r\n\r\n- 所得元素的只有key没有value，value就是key\r\n- 不允许出现键值重复\r\n- 所有的元素都会被自动排序 \r\n- 不能通过迭代器来改变set的值，因为set的值就是键\r\n\r\n**Map：**\r\n\r\n- 所有元素都是key-value存在\r\n- 不允许键重复，但是值可重复\r\n- 所有元素是通过键进行自动排序的\r\n- map的键是不能修改的，但是其键对应的值是可以修改的\r\n\r\n综上所述，它们其实就一个区别，就是Set只有key，Map是key-value都有。但是因为key的唯一性和不可改的特性，产生了几个不同点。\r\n\r\n- **TreeMap与TreeSet**\r\n\r\n讲述标题之前，先来看看HashMap和TreeMap的区别吧。在Jdk8之前HashMap和TreeMap是完全不同的结构，一个哈希表结构，一个红黑树结构。但在JDK8之后HashMap也引入了红黑树，这就使TreeMap的使用率更少了，但是习惯成自然，还是有很多人使用TreeMap而不去使用HashMap转化树形。TreeMap大多属性和HashMap作用一样，我们只看一下它比较显著的属性:\r\n\r\n    // TreeMap部分属性\r\n    // 红黑树的红色结点\r\n    private static final boolean RED = false;\r\n    // 红黑树的黑色结点\r\n    private static final boolean BLACK = true;\r\n\r\n    // TreeMap结点信息(标准的树形结构)\r\n    static final class Entry<K, V> implements java.util.Map.Entry<K, V> {\r\n        // 键\r\n        K key;\r\n        // 值\r\n        V value;\r\n        // 左孩子\r\n        TreeMap.Entry<K, V> left;\r\n        // 右孩子\r\n        TreeMap.Entry<K, V> right;\r\n        // 父结点\r\n        TreeMap.Entry<K, V> parent;\r\n        // 默认是黑色结点，也就是根结点\r\n        boolean color = true;\r\n\r\n        // 构造函数(Constructor)\r\n        Entry(K key, V value, TreeMap.Entry<K, V> parent) {\r\n            this.key = key;\r\n            this.value = value;\r\n            this.parent = parent;\r\n        }\r\n    ...}\r\n通过源码我们也可以看出它是标准的红黑树结构。值得注意的是HashMap和TreeMap都是非线程安全的。那么HashMap和TreeMap的区别是啥？很好理解，我们只需要知道哈希表和红黑树的区别，优缺点即可：\r\n\r\n- 红黑树是有序的；哈希表是无序的（这里的无序不是说HashMap，HashSet没有自排序，无序是指和插入时顺序不一致称为无序。HashMap，HashSet会根据键自排序而打乱插入顺序，所以称为无序，而红黑树，List等就是有序的。）\r\n- 红黑树占用的内存更小（仅需要为其存在的节点分配内存）；哈希表事先就应该分配足够的内存存储散列表（即使有些槽可能遭弃用）\r\n- 红黑树查找和删除的时间复杂度都是O(logn)；哈希表查找和删除的时间复杂度都是O(1)\r\n- 红黑树适用于按自然顺序或自定义顺序遍历键；哈希表适用于在Map中插入、删除和定位元素\r\n\r\n接下来回归标题，TreeMap和TreeSet什么区别呢？TreeSet其实是基于TreeMap的，所以TreeMap的功能，TreeSet基本都有，我们也来看看TreeSet的构造函数吧：\r\n\r\n    // TreeSet的构造函数，都有TreeMap的身影\r\n    public TreeSet() {\r\n        this((NavigableMap)(new TreeMap()));\r\n    }\r\n\r\n    public TreeSet(Comparator<? super E> comparator) {\r\n        this((NavigableMap)(new TreeMap(comparator)));\r\n    }\r\n然而区别呢，上面也讲过了，Set和Map的区别，不再赘述，往上看一看吧。\r\n\r\n- **LinkedHashMap与LinkedHashSet**\r\n\r\n这两个东西分别是HashMap和HashSet的子类，本来可不作为大类来详细叙述的，但是用的比较多，就介绍一下吧。它们很简单了，多了个Linked，从字面我们就可以看出，是多了一个双向链表，其他的区别和上面一样。那么，多个双向链表干嘛呢？其实是为了保持遍历顺序和插入顺序一致的问题，什么意思呢？当你使用put像Map中添加一条数据时，双向链表便会记录你put的顺序，使得遍历的时候是和你插入的顺序是一致的，这可是有很多大用处的哦。作用说完了，看看源码吧：\r\n\r\n    // LinkedHashMap在HashMap基础上添加了含有头尾结点的双向链表\r\n    transient LinkedHashMap.Entry<K, V> head;\r\n    transient LinkedHashMap.Entry<K, V> tail;\r\n------------\r\n    // LinkedHashSet继承了HashSet\r\n    public class LinkedHashSet<E> extends HashSet<E> implements Set<E>, Cloneable, Serializable {\r\n        ...\r\n    }\r\n    // HashSet里面有一个构造函数，new了一个LinkedHashMap\r\n    HashSet(int initialCapacity, float loadFactor, boolean dummy) {\r\n        this.map = new LinkedHashMap(initialCapacity, loadFactor);\r\n    }\r\n可以看出LinkedHashSet还是基于LinkedHashMap的。\r\n\r\n- **EnumMap与EnumSet**\r\n\r\n这两个东西其实说起来不是特别常见，因为枚举本身就用的不多，做项目的时候是一群人做，与其慢慢读你的枚举变量，不如用finnal写成常量就好了。当然，枚举之所以存在是有它的意义的，通过EnumMap与EnumSet我们省去了枚举类中很多繁琐的操作：\r\n\r\n    // EnumMap这样就可以把枚举对象加入Map进行一次性传递\r\n    enumMap.put(EnumTest01.DELETE, \"dsdsd\");\r\n    enumMap.put(EnumTest01.UPDATE, \"qqqqqq\");\r\n    \r\n    // EnumSet和EnumMap大同小异，只是它没有value，key既是value\r\n    enumSet.add(EnumTest01.DELETE);\r\n    enumSet.add(EnumTest01.UPDATE);\r\n为什么要用这个EnumMap呢？因为它的性能高！为什么性能高？因为它的底层是用数组来维护的！我们可以看一下它的源码实现：\r\n\r\n    // EnumMap用数组作为底层，并非哈希表，没有哈希结点\r\n    private transient K[] keyUniverse;\r\n    private transient Object[] vals;\r\n\r\n    // EnumMap的put函数\r\n    public V put(K key, V value) {\r\n        this.typeCheck(key);\r\n        int index = key.ordinal();\r\n        Object oldValue = this.vals[index];\r\n        this.vals[index] = this.maskNull(value);\r\n        if (oldValue == null) {\r\n            ++this.size;\r\n        }\r\n\r\n        return this.unmaskNull(oldValue);\r\n    }\r\n我们都知道，数组作为查询什么的是很快的，它不擅长于增加和删除。这正好符合我们需要遍历枚举对象的需求，所以有了EnumMap。而EnumSet实际上不是一个实现类，是一个抽象类，它有两个继承类：JumboEnumSet和RegularEnumSet。在使用的时候，需要制定枚举类型。它的特点也是速度非常快，为什么速度很快呢？因为每次add的时候，每个枚举值只占一个长整型的一位。我们翻看源码来看看它的实现：\r\n\r\n    // JumboEnumSet以长整型数组存放枚举值，它适用于枚举类的常量数量多于64个的时候\r\n    class JumboEnumSet<E extends Enum<E>> extends EnumSet<E> {\r\n        private static final long serialVersionUID = 334349849919042784L;\r\n        private long[] elements;\r\n        private int size = 0;\r\n        ...\r\n    }\r\n\r\n    /**\r\n     * RegularEnumSet以长整型变量计算枚举值的临时存放，\r\n     * 它没有数组存储，所以只适用于枚举类的常量数量少于64个的时候，也是我们常用的\r\n     */\r\n    class RegularEnumSet<E extends Enum<E>> extends EnumSet<E> {\r\n        private static final long serialVersionUID = 3411599620347842686L;\r\n        private long elements = 0L;\r\n        ...\r\n    }\r\n\r\n### 四.不常见集合类简述\r\n\r\n- **List**\r\n\r\nStack：Stack(栈)，大家对栈都很熟悉了，先进后出，后进先出，它还可以代替递归什么的，java中的栈是继承于Vector的，那么底层就不用我说都知道了吧，是一个线程安全的数组。\r\n\r\nAttributeList： AttributeList继承了ArrayList，不过是在包javax.management包中，看名字，难道叫“属性”List,它的作用是表示MBean的属性值的列表。请参阅MBeanServer和MBeanServerConnection的getAttribute和setAttribute方法。\r\n\r\n- **Set**\r\n\r\nHashAttributeSet：HashAttributeSet是AttributeSet的一个实现类，AttributeSet是打印属性集的指定接口。和AttributeList类似，HashAttributeSet也是表示属性值的，但不是列表形式，而是哈希表形式，它是基于HashMap实现的\r\n\r\n- **Map**\r\n\r\nWeakHashMap：它不是继承于HashMap，而是实现的Map接口，属于和Map同级别的存在。WeakHashMap的键是“弱键”。在 WeakHashMap 中，当某个键不再正常使用时，会被从WeakHashMap中被自动移除。更精确地说，对于一个给定的键，其映射的存在并不阻止垃圾回收器对该键的丢弃，这就使该键成为可终止的，被终止，然后被回收。某个键被终止时，它对应的键值对也就从映射中有效地移除了。\r\n\r\nIdentityHashMap：它不是继承于HashMap，而是实现的Map接口，属于和Map同级别的存在。使用HashMap操作的时候，key内容是不能重复的，如果现在希望key内容可以重复（指的是两个对象的地址不一样key1==key2 ）则要使用IdentityHashMap类，所以它的作用是为了增加重复的键。\r\n\r\nConcurrentHashMap：ConcurrentHashMap实现于ConcurrentMap，而ConcurrentMap也是继承于Map接口，所以也可以说ConcurrentHashMap和HashMap是同级别的。这个类很强，完全可以代替HashTable，为什么这么说呢？它底层采用分段的数组+链表实现，线程安全。通过把整个Map分为N个Segment，可以提供相同的线程安全，但是效率提升N倍，默认提升16倍，过程是根据key.hashCode()算出放到哪个Segment中。Hashtable的synchronized是针对整张Hash表的，即每次锁住整张表让线程独占，ConcurrentHashMap允许多个修改操作并发进行，其关键在于使用了锁分离技术。\r\n\r\n------------\r\n\r\n### 每日一类之Map，Set拓展\r\n**1.SortedMap**和**SortedSet**：这两个不是实现类，而是接口。见名识意，Map和Set的实现类之所以自排序就是因为有一个构造函数的参数调用这两个接口进行实现\r\n\r\n**2.entrySet()**和**keySet()**：这两个方法是每个Map实现类里面都有的，是为了遍历k-v和输出的方便设计的。keySet()是k的集合，Set里面的类型即key的类型；entrySet()是k-v对的集合，Set里面的类型是Map.Entry。keySet()的速度比entrySet()慢了很多。使用entrySet()必须将map对象转换为Map.Entry；keySet()则不需要\r\n![572d63306d7e1.jpg](http://127.0.0.1:1111/articleImage/ef333757a39342b89eb9814aa65eeb30.jpg)', 2, 0, 1, NULL, 'http://127.0.0.1:1111/articleImage/ef333757a39342b89eb9814aa65eeb30.jpg', NULL, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');

-- ----------------------------
-- Table structure for sys_article_label
-- ----------------------------
DROP TABLE IF EXISTS `sys_article_label`;
CREATE TABLE `sys_article_label`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `article_id` int(0) NULL DEFAULT NULL COMMENT '文章编号',
  `label_id` int(0) NULL DEFAULT NULL COMMENT '标签编号',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否启用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` date NULL DEFAULT NULL COMMENT '修改时间',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_article_fk`(`article_id`) USING BTREE,
  INDEX `sys_label_fk`(`label_id`) USING BTREE,
  CONSTRAINT `sys_article_fk` FOREIGN KEY (`article_id`) REFERENCES `sys_article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sys_label_fk` FOREIGN KEY (`label_id`) REFERENCES `sys_label` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章标签关联' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_article_label
-- ----------------------------
INSERT INTO `sys_article_label` VALUES (1, NULL, 1, 8, NULL, '', NULL, 1, '2020-02-08', '2020-02-08', 'admin', 'admin');
INSERT INTO `sys_article_label` VALUES (2, NULL, 2, 8, NULL, '', NULL, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');
INSERT INTO `sys_article_label` VALUES (3, NULL, 3, 8, NULL, '', NULL, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');
INSERT INTO `sys_article_label` VALUES (4, NULL, 4, 9, NULL, '', NULL, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');
INSERT INTO `sys_article_label` VALUES (5, NULL, 4, 10, NULL, '', NULL, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');
INSERT INTO `sys_article_label` VALUES (6, NULL, 4, 6, NULL, '', NULL, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');

-- ----------------------------
-- Table structure for sys_classify
-- ----------------------------
DROP TABLE IF EXISTS `sys_classify`;
CREATE TABLE `sys_classify`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类名称',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否启用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建日期',
  `modify_time` date NULL DEFAULT NULL COMMENT '修改日期',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文章分类' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_classify
-- ----------------------------
INSERT INTO `sys_classify` VALUES (1, 'Java', NULL, '1', 'JavaSE', 1, '2020-01-29', '2020-01-29', '谢印', '谢印');
INSERT INTO `sys_classify` VALUES (2, '后端', NULL, '1', '后端', 1, '2019-07-07', '2019-07-07', '谢印', '谢印');
INSERT INTO `sys_classify` VALUES (3, '前端', NULL, '1', '前端', 1, '2019-07-10', '2019-07-10', '谢印', '谢印');
INSERT INTO `sys_classify` VALUES (4, '服务器', NULL, '1', '服务器', 1, '2019-07-10', '2019-07-10', '谢印', '谢印');
INSERT INTO `sys_classify` VALUES (5, 'SSM', NULL, '1', 'SSM', 1, '2019-07-10', '2019-07-10', '谢印', '谢印');
INSERT INTO `sys_classify` VALUES (6, 'SpringBoot', NULL, '1', 'SpringBoot', 1, '2019-07-10', '2019-07-10', '谢印', '谢印');
INSERT INTO `sys_classify` VALUES (7, 'SpringCloud', NULL, '1', 'SpringCloud', 1, '2019-07-10', '2019-07-10', '谢印', '谢印');
INSERT INTO `sys_classify` VALUES (8, 'Vue', NULL, '1', 'Vue', 1, '2019-07-10', '2019-07-10', '谢印', '谢印');
INSERT INTO `sys_classify` VALUES (9, 'web开发', NULL, '1', 'web开发', 1, '2019-07-10', '2019-07-10', '谢印', '谢印');
INSERT INTO `sys_classify` VALUES (10, '其他', NULL, '1', '记录非专业,非技术的博客文章', 1, '2019-07-10', '2019-07-10', '谢印', '谢印');

-- ----------------------------
-- Table structure for sys_discuss
-- ----------------------------
DROP TABLE IF EXISTS `sys_discuss`;
CREATE TABLE `sys_discuss`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `parent_id` int(0) NULL DEFAULT NULL COMMENT '父级编号',
  `article_id` int(0) NULL DEFAULT NULL COMMENT '文章编号',
  `message` varchar(10000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论内容',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否启用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建日期',
  `modify_time` date NULL DEFAULT NULL COMMENT '修改日期',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `discuss_article_fk`(`article_id`) USING BTREE,
  INDEX `discuss_parent_fk`(`parent_id`) USING BTREE,
  CONSTRAINT `discuss_article_fk` FOREIGN KEY (`article_id`) REFERENCES `sys_article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `discuss_parent_fk` FOREIGN KEY (`parent_id`) REFERENCES `sys_discuss` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_discuss
-- ----------------------------
INSERT INTO `sys_discuss` VALUES (1, '根评论', NULL, NULL, '我是根评论', NULL, '1', '根评论,用作别的评论额父节点', 1, '2019-07-08', '2019-07-08', 'admin', 'admin');
INSERT INTO `sys_discuss` VALUES (2, NULL, 1, 1, '感谢分享', NULL, '', NULL, 1, '2020-02-08', '2020-02-08', '游客', '游客');
INSERT INTO `sys_discuss` VALUES (3, NULL, 2, 1, '1', NULL, '', NULL, 1, '2020-07-16', '2020-07-16', '游客', '游客');

-- ----------------------------
-- Table structure for sys_file
-- ----------------------------
DROP TABLE IF EXISTS `sys_file`;
CREATE TABLE `sys_file`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件名',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '文件路径',
  `type` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '1：封面、2：文章内容图片、3：其他',
  `article_id` int(0) NULL DEFAULT NULL COMMENT '文章编号',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否启用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建日期',
  `modify_time` date NULL DEFAULT NULL COMMENT '修改日期',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_file_article_fk`(`article_id`) USING BTREE,
  CONSTRAINT `sys_file_article_fk` FOREIGN KEY (`article_id`) REFERENCES `sys_article` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '文件' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_file
-- ----------------------------
INSERT INTO `sys_file` VALUES (1, '首条文件数据', '暂无', '暂无', NULL, NULL, '1', '这是首条文件数据', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');
INSERT INTO `sys_file` VALUES (2, '文章:\'系列文章之JDK8新特性(一)\'的文件', 'http://127.0.0.1:1111/articleImage/8326f956576f4ad9afa7fa4f1dd5fc80.jpg', '图片', 1, NULL, '', NULL, 1, '2020-02-08', '2020-02-08', 'admin', 'admin');
INSERT INTO `sys_file` VALUES (3, '文章:\'系列文章之JDK8新特性(二)\'的文件', 'http://127.0.0.1:1111/articleImage/fd42f7d3b69246b1a9d10fdb8b617cc1.jpg', '图片', 2, NULL, '', NULL, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');
INSERT INTO `sys_file` VALUES (4, '文章:\'系列文章之JDK8新特性(三)\'的文件', 'http://127.0.0.1:1111/articleImage/64d6548540b846bd911fa8c69ead3bf4.jpg', '图片', 3, NULL, '', NULL, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');
INSERT INTO `sys_file` VALUES (5, '文章:\'集合类综合讲解\'的文件', 'http://127.0.0.1:1111/articleImage/ef333757a39342b89eb9814aa65eeb30.jpg', '图片', 4, NULL, '', NULL, 1, '2020-02-18', '2020-02-18', 'admin', 'admin');

-- ----------------------------
-- Table structure for sys_label
-- ----------------------------
DROP TABLE IF EXISTS `sys_label`;
CREATE TABLE `sys_label`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标签名',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否启用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建时间',
  `modify_time` date NULL DEFAULT NULL COMMENT '修改时间',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '标签' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_label
-- ----------------------------
INSERT INTO `sys_label` VALUES (1, '处子博文', NULL, '1', '第一篇', 1, '2019-07-07', '2019-07-07', '谢印', '谢印');
INSERT INTO `sys_label` VALUES (2, '心情', NULL, '1', '心情', 1, '2019-07-10', '2019-07-10', '谢印', '谢印');
INSERT INTO `sys_label` VALUES (3, 'nginx', NULL, '1', 'nginx', 1, '2019-12-05', '2019-12-05', '谢印', '谢印');
INSERT INTO `sys_label` VALUES (4, 'shrio', NULL, '1', 'shrio认证', 1, '2019-12-05', '2019-12-05', '谢印', '谢印');
INSERT INTO `sys_label` VALUES (5, 'AOP', NULL, '1', 'AOP切面编程', 1, '2019-12-05', '2019-12-05', '谢印', '谢印');
INSERT INTO `sys_label` VALUES (6, 'Map', NULL, '1', '多种Map区别', 1, '2019-12-05', '2019-12-05', '谢印', '谢印');
INSERT INTO `sys_label` VALUES (7, 'manjaro', NULL, '1', 'manjaro配置', 1, '2019-12-05', '2019-12-05', '谢印', '谢印');
INSERT INTO `sys_label` VALUES (8, 'JDK8', NULL, '1', '新特性', 1, '2020-01-29', '2020-01-29', '谢印', '谢印');
INSERT INTO `sys_label` VALUES (9, 'Set', NULL, '1', '多种Set区别', 1, '2020-02-18', '2020-02-18', '谢印', '谢印');
INSERT INTO `sys_label` VALUES (10, 'List', NULL, '1', '多种List区别', 1, '2020-02-18', '2020-02-18', '谢印', '谢印');

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `browser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '浏览器',
  `operation` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '操作方式：GET/POST',
  `from_url` varchar(1000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访问的实际url地址',
  `ip` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '来源ip地址',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '访问url相对地址',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否可用，1：可用，0：不可用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建日期',
  `modify_time` date NULL DEFAULT NULL COMMENT '末次更新时间',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建用户名称',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '末次更新用户名称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 165 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '日志' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_page
-- ----------------------------
DROP TABLE IF EXISTS `sys_page`;
CREATE TABLE `sys_page`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面名称',
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '页面路径',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否启用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建日期',
  `modify_time` date NULL DEFAULT NULL COMMENT '修改日期',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '页面' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_page
-- ----------------------------
INSERT INTO `sys_page` VALUES (1, '首条页面数据', '暂无', NULL, '1', '这是首条页面数据', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');

-- ----------------------------
-- Table structure for sys_res
-- ----------------------------
DROP TABLE IF EXISTS `sys_res`;
CREATE TABLE `sys_res`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(11) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `parent_id` int(0) NULL DEFAULT NULL COMMENT '父权限资源编号',
  `des` varchar(1024) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `url` varchar(512) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'url地址',
  `level` int(0) NULL DEFAULT NULL COMMENT '层级',
  `icon_cls` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `type` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '类型：1 功能 2 权限',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否可用，1：可用，0：不可用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建日期',
  `modify_time` date NULL DEFAULT NULL COMMENT '末次更新时间',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建用户名称',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '末次更新用户名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_res_parent_fk`(`parent_id`) USING BTREE,
  CONSTRAINT `sys_res_parent_fk` FOREIGN KEY (`parent_id`) REFERENCES `sys_res` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限资源' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_res
-- ----------------------------
INSERT INTO `sys_res` VALUES (1, '所有资源', NULL, '可以访问所有资源', 'www.xysoul.cn', 1, NULL, '所有请求类', NULL, '1', '可以访问所有资源', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');
INSERT INTO `sys_res` VALUES (2, '游客资源', NULL, '只能看博文和评论', 'www.xysoul.cn', 2, NULL, 'Get请求', NULL, '1', '只能看博文和评论', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `parent_id` int(0) NULL DEFAULT NULL COMMENT '父角色编号',
  `des` varchar(128) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `icon_cls` varchar(55) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '图标',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否可用，1：可用，0：不可用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建日期',
  `modify_time` date NULL DEFAULT NULL COMMENT '末次更新时间',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建用户名称',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '末次更新用户名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_role_parent_fk`(`parent_id`) USING BTREE,
  CONSTRAINT `sys_role_parent_fk` FOREIGN KEY (`parent_id`) REFERENCES `sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '权限' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', NULL, '这是超级管理员,具有所有权限', NULL, NULL, '1', '具有所有权限', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');
INSERT INTO `sys_role` VALUES (2, '博主', 1, '第二博主也拥有最高权限', NULL, NULL, '1', '第二博主也拥有最高权限', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');

-- ----------------------------
-- Table structure for sys_role_res
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_res`;
CREATE TABLE `sys_role_res`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `role_id` int(0) NULL DEFAULT NULL COMMENT '角色编号',
  `res_id` int(0) NULL DEFAULT NULL COMMENT '权限资源编号',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否可用，1：可用，0：不可用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建日期',
  `modify_time` date NULL DEFAULT NULL COMMENT '末次更新时间',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建用户名称',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '末次更新用户名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_res_fk`(`res_id`) USING BTREE,
  INDEX `sys_role_fk`(`role_id`) USING BTREE,
  CONSTRAINT `sys_res_fk` FOREIGN KEY (`res_id`) REFERENCES `sys_res` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sys_role_fk` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '角色权限关联' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_role_res
-- ----------------------------
INSERT INTO `sys_role_res` VALUES (1, '关联测试', 1, 1, NULL, '1', '关联测试', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');
INSERT INTO `sys_role_res` VALUES (2, '关联测试', 1, 2, NULL, '1', '关联测试', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');
INSERT INTO `sys_role_res` VALUES (3, '关联测试', 2, 1, NULL, '1', '关联测试', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');
INSERT INTO `sys_role_res` VALUES (4, '关联测试', 2, 2, NULL, '1', '关联测试', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');

-- ----------------------------
-- Table structure for sys_setting
-- ----------------------------
DROP TABLE IF EXISTS `sys_setting`;
CREATE TABLE `sys_setting`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `web_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '站点地址',
  `web_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '站点标题',
  `web_child_title` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '站点子标题',
  `web_message` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '站点基础信息',
  `web_key` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '站点关键词',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否启用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建日期',
  `modify_time` date NULL DEFAULT NULL COMMENT '修改日期',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '系统基本设置' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_setting
-- ----------------------------
INSERT INTO `sys_setting` VALUES (1, '首条站点基本信息', 'www.xysoul.cn', '冫Soul丶', '冫Mate丶', '灵魂伴侣', '灵魂伴侣', NULL, '1', '这是首条站点基本信息', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');

-- ----------------------------
-- Table structure for sys_timeline
-- ----------------------------
DROP TABLE IF EXISTS `sys_timeline`;
CREATE TABLE `sys_timeline`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `message` varchar(15000) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '历程内容',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否启用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建日期',
  `modify_time` date NULL DEFAULT NULL COMMENT '修改日期',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '历程' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_timeline
-- ----------------------------
INSERT INTO `sys_timeline` VALUES (1, '博客开始', '作为一个编程小白，每次查资料到别人博客站都觉得挺骚，想来自己也写一个个人博客吧，也好记录与分享自己的所见所闻所学所想。于2019年5月1日，我的博客系统正式开工，计划两个月，希望顺利完工！！', NULL, '1', '博客开始', 1, '2019-05-01', '2019-05-01', '谢印', '谢印');
INSERT INTO `sys_timeline` VALUES (2, '博客结束', '特大惊喜，在2019年7月10号这天，我的博客终于部署在自己的服务器上正式运行了，为期两个月零10天，每天写一点终于算是写出来了，以后大家便可以访问www.xysoul.cn进入我的博客观光了，开发中途是想写历程的，后来想想还是算了，开发的辛酸史就懒得记录了，嘿嘿！！', NULL, '1', '博客结束', 1, '2019-07-10', '2019-07-10', '谢印', '谢印');
INSERT INTO `sys_timeline` VALUES (3, '新的开始', '今天是2020年2月1日，离我博客系统开发完成已经有满满的7个月时间了。这7个月里我一直闲置我的博客系统，一篇文章没发过。不是我不想发，真的是太忙了太忙了，开发完成之后我就准备研究生考试去了，一直到12月底才考完，考完试不得放松放松？又出去玩了一阵子，玩回来就是过年了，哈哈。也不怪我不写文章，实在是老天不让我写啊。最近面临着毕业，面试工作，毕业设计什么的一堆事情搞得我有点烦躁，突然玩手机时候想着自己还有个博客系统快发霉了，想来还是认认真真打理一下吧。以后，我会少则1天多则一周的发一篇文章以保持写文章的好习惯。加油吧，少年郎！！', NULL, '1', '开始我的第一篇博文', 1, '2020-02-01', '2020-02-01', '谢印', '谢印');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `qq` int(0) NULL DEFAULT NULL COMMENT 'qq号',
  `github` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT 'github账号',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否启用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建日期',
  `modify_time` date NULL DEFAULT NULL COMMENT '修改日期',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建者',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '修改者',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, '谢印', '981214', '437665122@qq.com', 437665122, '437665122@qq.com', NULL, '1', '第一个博主及超级管理员', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');
INSERT INTO `sys_user` VALUES (2, '冫Soul丶', '123456', '995932621@qq.com', 995932621, '437665122@qq.com', NULL, '1', '第二用户', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '名称',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '用户编号',
  `role_id` int(0) NULL DEFAULT NULL COMMENT '角色编号',
  `sort` int(0) NULL DEFAULT NULL COMMENT '排序',
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `is_enable` tinyint(0) NULL DEFAULT NULL COMMENT '是否可用，1：可用，0：不可用',
  `create_time` date NULL DEFAULT NULL COMMENT '创建日期',
  `modify_time` date NULL DEFAULT NULL COMMENT '末次更新时间',
  `create_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '创建用户名称',
  `modify_user` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '末次更新用户名称',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sys_role1_fk`(`role_id`) USING BTREE,
  INDEX `sys_user_fk`(`user_id`) USING BTREE,
  CONSTRAINT `sys_role1_fk` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `sys_user_fk` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '用户角色关联' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, '关联测试', 1, 1, NULL, '1', '关联测试', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');
INSERT INTO `sys_user_role` VALUES (2, '关联测试', 2, 1, NULL, '1', '关联测试', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');
INSERT INTO `sys_user_role` VALUES (3, '关联测试', 1, 2, NULL, '1', '关联测试', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');
INSERT INTO `sys_user_role` VALUES (4, '关联测试', 2, 2, NULL, '1', '关联测试', 1, '2019-07-08', '2019-07-08', '谢印', '谢印');

SET FOREIGN_KEY_CHECKS = 1;
