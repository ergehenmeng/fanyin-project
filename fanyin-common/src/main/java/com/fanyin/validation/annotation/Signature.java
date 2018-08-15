package com.fanyin.validation.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * @author 王艳兵
 * @date 2018/8/15 15:24
 */
@Documented
@Target(METHOD)
@Retention(RUNTIME)
public @interface Signature {

    /**
     * 请求是否需要签名
     * @return 默认是
     */
    boolean value() default true;
}
