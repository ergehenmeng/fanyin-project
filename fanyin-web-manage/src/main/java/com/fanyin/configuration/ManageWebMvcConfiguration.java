package com.fanyin.configuration;

import org.apache.catalina.connector.Connector;
import org.springframework.boot.context.embedded.EmbeddedServletContainerFactory;
import org.springframework.boot.context.embedded.tomcat.TomcatEmbeddedServletContainerFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * mvc配置信息
 * @author 二哥很猛
 * @date 2018/1/18 18:35
 */
@Configuration
public class ManageWebMvcConfiguration extends WebMvcConfiguration {

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
