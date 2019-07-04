package com.fanyin.configuration;

import com.fanyin.configuration.filter.ByteHttpRequestFilter;
import com.fanyin.interceptor.AccessTokenHandlerInterceptor;
import com.fanyin.interceptor.MessageHandlerInterceptor;
import com.fanyin.interceptor.SignatureHandlerInterceptor;
import org.springframework.boot.web.servlet.DelegatingFilterProxyRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;

import javax.servlet.DispatcherType;
import javax.servlet.Filter;

/**
 * mvc全局配置,继承WebMvcConfigurerAdapter无需@EnableWebMvc
 * @author 二哥很猛
 * @date 2018/1/18 18:35
 */
@Configuration
public class FrontWebMvcConfiguration extends WebMvcConfiguration {

    /**
     * 全局忽略拦截的url,多个采用分号分割
     */
    private static final String IGNORE_URLS = "/upload/**";


    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(signatureHandlerInterceptor()).excludePathPatterns(IGNORE_URLS).order(Integer.MIN_VALUE + 1);
        registry.addInterceptor(messageHandlerInterceptor()).excludePathPatterns(IGNORE_URLS).order(Integer.MIN_VALUE + 2);
        registry.addInterceptor(accessHandlerInterceptor()).excludePathPatterns(IGNORE_URLS).order(Integer.MIN_VALUE + 3);
    }

    /**
     * 登陆校验拦截器
     * @return interceptor
     */
    @Bean
    public HandlerInterceptor accessHandlerInterceptor(){
        return new AccessTokenHandlerInterceptor();
    }

    /**
     * 签名校验拦截器
     * @return interceptor
     */
    @Bean
    public HandlerInterceptor signatureHandlerInterceptor(){
        return new SignatureHandlerInterceptor();
    }

    /**
     * 请求基础信息收集拦截器
     * @return interceptor
     */
    @Bean
    public HandlerInterceptor messageHandlerInterceptor(){
        return new MessageHandlerInterceptor();
    }


    @Bean("byteHttpRequestFilter")
    public Filter byteHttpRequestFilter(){
        return new ByteHttpRequestFilter();
    }

    @Bean
    public DelegatingFilterProxyRegistrationBean registrationBean(){
        DelegatingFilterProxyRegistrationBean registrationBean = new DelegatingFilterProxyRegistrationBean("byteHttpRequestFilter");
        registrationBean.addUrlPatterns("/*");
        registrationBean.addInitParameter(AbstractIgnoreFilter.EXECUTIONS,IGNORE_URLS);
        registrationBean.setDispatcherTypes(DispatcherType.REQUEST);
        registrationBean.setOrder(Integer.MIN_VALUE);
        return registrationBean;
    }
}
