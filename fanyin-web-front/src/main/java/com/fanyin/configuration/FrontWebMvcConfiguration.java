package com.fanyin.configuration;

import com.fanyin.inteceptor.AccessHandlerInterceptor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;

/**
 * mvc全局配置,继承WebMvcConfigurerAdapter无需@EnableWebMvc
 * @author 二哥很猛
 * @date 2018/1/18 18:35
 */
@Configuration
public class FrontWebMvcConfiguration extends WebMvcConfiguration {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(accessHandlerInterceptor());
    }

    /**
     * 签名,令牌拦截器
     * @return handler
     */
    @Bean
    public HandlerInterceptor accessHandlerInterceptor(){
        return new AccessHandlerInterceptor();
    }



}
