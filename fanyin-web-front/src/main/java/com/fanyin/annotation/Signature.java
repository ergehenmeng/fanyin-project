package com.fanyin.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * 需要请求验签的地方添加该验签
 * @author 二哥很猛
 * @date 2018/8/15 15:24
 */
@Documented
@Target(METHOD)
@Retention(RUNTIME)
public @interface Signature {
}
