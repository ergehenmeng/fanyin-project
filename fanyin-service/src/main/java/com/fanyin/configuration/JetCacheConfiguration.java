package com.fanyin.configuration;

import com.alicp.jetcache.anno.support.SpringConfigProvider;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;

/**
 * jetCache缓存配置
 * @author 二哥很猛
 * @date 2018/9/14 15:58
 */
//@Configuration
//@EnableMethodCache(basePackages = "com.fanyin.service")
//@EnableCreateCacheAnnotation
//@PropertySource("classpath:redis.properties")
public class JetCacheConfiguration {


    /**
     * 链接地址
     */
    @Value("${host}")
    private String host;

    /**
     * 端口
     */
    @Value("${port}")
    private int port;

    /**
     * 超时时间
     */
    @Value("${timeout:60000}")
    private int timeout;

    @Value("${max-idle:10}")
    private int maxIdle;

    @Value("${min-idle:2}")
    private int minIdle;

    @Value("${max-total:10}")
    private int maxTotal;


    @Bean
    public SpringConfigProvider provider(){
        return new SpringConfigProvider();
    }



}
