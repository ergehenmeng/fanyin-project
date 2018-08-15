package com.fanyin.annotation;

import org.springframework.core.MethodParameter;

import java.lang.annotation.Documented;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

/**
 * 对请求参数进行参数校验
 * 请求参数必须为application/json格式,
 * 并且数据绑定对象必须为非基本类型
 * @see com.fanyin.inteceptor.ValidationHandlerMethodArgumentResolver#supportsParameter(MethodParameter)  拦截规则
 * @author 王艳兵
 * @date 2018/8/15 17:55
 */
@Documented
@Target(METHOD)
@Retention(RUNTIME)
public @interface Validation {

}
