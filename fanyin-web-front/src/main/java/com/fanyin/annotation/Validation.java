package com.fanyin.annotation;

import org.springframework.core.MethodParameter;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * 对请求参数进行参数校验
 * 请求参数必须为application/json格式,
 * 并且数据绑定对象必须为非基本类型
 * @see com.fanyin.interceptor.ValidationHandlerMethodArgumentResolver#supportsParameter(MethodParameter)  拦截规则
 * @author 二哥很猛
 * @date 2018/8/15 17:55
 */
@Documented
@Target({METHOD,TYPE})
@Retention(RUNTIME)
public @interface Validation {

}
