package com.gzmu.blog_project.auth;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @className: Token
 * @author: 冫soul丶
 * @version: 1.0
 * @date: created in 上午9:49 19-6-20
 * @modified:
 *
 * 不需要验证的接口用此注解
 */
@Target({ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface PassToken {
    boolean required() default true;
}