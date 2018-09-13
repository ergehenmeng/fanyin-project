package com.fanyin.configuration;

import com.fanyin.inteceptor.AccessHandlerInterceptor;
import com.google.code.kaptcha.Constants;
import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
import org.apache.catalina.connector.Connector;
import org.springframework.boot.context.embedded.EmbeddedServletContainerFactory;
import org.springframework.boot.context.embedded.tomcat.TomcatEmbeddedServletContainerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import java.util.Properties;

/**
 * mvc全局配置,继承WebMvcConfigurerAdapter无需@EnableWebMvc
 * @author 二哥很猛
 * @date 2018/1/18 18:35
 */
@Configuration
public class WebMvcConfiguration extends WebMvcConfigurerAdapter {

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

    /**
     * 图形验证码
     * @return bean
     */
    @Bean("producer")
    public DefaultKaptcha captcha(){
        DefaultKaptcha captcha = new DefaultKaptcha();
        Properties properties = new Properties();
        properties.setProperty(Constants.KAPTCHA_BORDER,"no");
        properties.setProperty(Constants.KAPTCHA_TEXTPRODUCER_FONT_COLOR,"black");
        properties.setProperty(Constants.KAPTCHA_IMAGE_WIDTH,"125");
        properties.setProperty(Constants.KAPTCHA_IMAGE_HEIGHT,"45");
        properties.setProperty(Constants.KAPTCHA_TEXTPRODUCER_CHAR_LENGTH,"4");
        properties.setProperty(Constants.KAPTCHA_TEXTPRODUCER_CHAR_SPACE,"5");
        properties.setProperty(Constants.KAPTCHA_TEXTPRODUCER_CHAR_STRING,"abcdefhkmnprstwxy23456789ABCEFGHGKMNPRSTWXY");
        properties.setProperty(Constants.KAPTCHA_TEXTPRODUCER_FONT_NAMES,"宋体");
        properties.setProperty(Constants.KAPTCHA_OBSCURIFICATOR_IMPL,"com.google.code.kaptcha.impl.ShadowGimpy");
        Config config = new Config(properties);
        captcha.setConfig(config);
        return captcha;
    }


    /**
     * url中如果包含 "." 默认情况下后面的会被截取,将参数设置为false则会全部匹配
     * @param configurer configurer
     */
    @Override
    public void configurePathMatch(PathMatchConfigurer configurer) {
        configurer.setUseRegisteredSuffixPatternMatch(false);
    }

   @Bean
    public EmbeddedServletContainerFactory servletContainerFactory(){
        TomcatEmbeddedServletContainerFactory factory = new TomcatEmbeddedServletContainerFactory();
        factory.addAdditionalTomcatConnectors(connector());
        return factory;
    }

    /**
     * 将所有的链接由8080 转到 9999
     * @return 连接器
     */
    @Bean
    public Connector connector(){
        Connector connector = new Connector("org.apache.coyote.http11.Http11NioProtocol");
        connector.setScheme("http");
        connector.setPort(8081);
        connector.setSecure(false);
        connector.setRedirectPort(8080);
        return connector;
    }
}
