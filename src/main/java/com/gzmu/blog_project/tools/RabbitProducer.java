package com.gzmu.blog_project.tools;

import com.gzmu.blog_project.entity.SysLog;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.amqp.core.AmqpTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Rabbit服务端
 * 发送和接收队列消息
 *
 * @author soul
 * @version 1.0
 * @date 19-3-25 14:51
 */
@RestController
@Aspect
public class RabbitProducer {
    private final
    HttpServletRequest httpServletRequest;

    /**
     * AmqpTemplate接口定义了发送和接收消息的基本操作。
     */
    private final
    AmqpTemplate rabbitmqTemplate;

    @Autowired
    public RabbitProducer(AmqpTemplate rabbitmqTemplate, HttpServletRequest httpServletRequest) {
        this.rabbitmqTemplate = rabbitmqTemplate;
        this.httpServletRequest = httpServletRequest;
    }

    /**
     * aop切面监控所有执行的方法，获取基本信息保存到log
     *
     * getRequestURI()：请求的URI（相对路劲）
     * getMethod()：请求方式
     * getRequestURL()：请求的URL（绝对路劲）
     * getRemoteAddr()：来源ip
     * getServerPort()：端口
     * getServerName()：服务器名，若失败，则返回来源ip
     * getHeader("User-Agent")：浏览器信息
     * getRemoteHost()：客户端电脑名，若失败，则返回来源ip
     *
     * @param joinPoint
     * @throws Throwable
     */
    @Around("execution(* com.gzmu.blog_project.repository.*..*(..))")
    public Object processTx(ProceedingJoinPoint joinPoint) throws Throwable {
        if (joinPoint.getArgs().length > 0) {
            Date date = new Date();
            SysLog sysLog = new SysLog();
            sysLog.setStatus(1);
            sysLog.setCreateTime(date);
            sysLog.setCreateUser("admin");
            sysLog.setBrowser(httpServletRequest.getHeader("User-Agent"));
            sysLog.setIp(httpServletRequest.getRemoteAddr());
            sysLog.setFromUrl(httpServletRequest.getRequestURL().toString());
            sysLog.setUrl(httpServletRequest.getRequestURI());
            sysLog.setOperation(httpServletRequest.getMethod());
            sysLog.setName("来自"+httpServletRequest.getRequestURL().toString()+"的日志信息");
            rabbitmqTemplate.convertAndSend(RabbitConfig.EXCHANGE, RabbitConfig.ROUTING_KEY, sysLog);
            return joinPoint.proceed(joinPoint.getArgs());
        } else {
            return joinPoint.proceed();
        }
    }

    /**
     * 测试立即消费者发送方
     */
    @RequestMapping("/immediateTest")
    public String ImmediateSend() {
        SysLog sysLog = new SysLog();
        sysLog.setFromUrl(httpServletRequest.getServletPath());
        rabbitmqTemplate.convertAndSend(RabbitConfig.EXCHANGE, RabbitConfig.ROUTING_KEY, sysLog);
        return "队列成功";
    }

    /**
     * 测试延时消费者发送方
     * delayTime表示设置的延迟时间
     */
    @RequestMapping("/delayTest")
    public String DelaySend(@RequestParam(value = "delayTime", defaultValue = "1000") String delayTime) {
        SysLog sysLog = new SysLog();
        sysLog.setFromUrl(httpServletRequest.getServletPath());
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        System.out.println("消息发送时间:" + simpleDateFormat.format(new Date()));
        rabbitmqTemplate.convertAndSend(RabbitConfig.DELAY_EXCHANGE, RabbitConfig.DELAY_ROUTING_KEY, sysLog,
                message -> {
                    message.getMessageProperties().setDelay(Integer.parseInt(delayTime));
                    return message;
                });
        return "队列成功";
    }
}