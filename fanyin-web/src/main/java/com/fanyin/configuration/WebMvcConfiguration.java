package com.fanyin.configuration;

import com.fanyin.inteceptor.GlobalHandlerInterceptor;
import com.fanyin.inteceptor.SystemHandlerMethodArgumentResolver;
import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.method.support.HandlerMethodArgumentResolver;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import java.util.List;
import java.util.Properties;

/**
 * mvc全局配置
 * @author 二哥很猛
 * @date 2018/1/18 18:35
 */
@Configuration
public class WebMvcConfiguration extends WebMvcConfigurerAdapter {

    @Override
    public void addArgumentResolvers(List<HandlerMethodArgumentResolver> argumentResolvers) {
        //argumentResolvers.add(new SystemHandlerMethodArgumentResolver());
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new GlobalHandlerInterceptor());
    }

    /**
     * 图形验证码
     * @return bean
     */
    @Bean("producer")
    public DefaultKaptcha captcha(){
        DefaultKaptcha captcha = new DefaultKaptcha();
        Properties properties = new Properties();
        properties.setProperty("kaptcha.border","no");
        properties.setProperty("kaptcha.textproducer.font.color","black");
        properties.setProperty("kaptcha.image.width","125");
        properties.setProperty("kaptcha.image.height","45");
        properties.setProperty("kaptcha.textproducer.char.length","4");
        properties.setProperty("kaptcha.textproducer.char.space","5");
        properties.setProperty("kaptcha.textproducer.char.string","abcdefhkmnprstwxy23456789ABCEFGHGKMNPRSTWXY");
        properties.setProperty("kaptcha.textproducer.font.names","宋体");
        properties.setProperty("kaptcha.obscurificator.impl","com.google.code.kaptcha.impl.ShadowGimpy");
        Config config = new Config(properties);
        captcha.setConfig(config);
        return captcha;
    }
}
