package com.fanyin.annotation;

import com.fanyin.enums.Source;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * 等同于Access+Signature+Validation
 * 即:需要登陆,数据签名,数据校验
 * @author 王艳兵
 * @date 2018/9/13 11:40
 */
@Documented
@Target({METHOD,TYPE})
@Retention(RUNTIME)
public @interface GroupAccess {
    /**
     * 客户端类型
     * @return 默认后台请求
     */
    Source[] value() default Source.PC;
}
