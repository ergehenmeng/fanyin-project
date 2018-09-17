package com.fanyin.configuration;

import com.alicp.jetcache.CacheBuilder;
import com.alicp.jetcache.anno.CacheConsts;
import com.alicp.jetcache.anno.config.EnableCreateCacheAnnotation;
import com.alicp.jetcache.anno.config.EnableMethodCache;
import com.alicp.jetcache.anno.support.GlobalCacheConfig;
import com.alicp.jetcache.anno.support.SpringConfigProvider;
import com.alicp.jetcache.embedded.EmbeddedCacheBuilder;
import com.alicp.jetcache.embedded.LinkedHashMapCacheBuilder;
import com.alicp.jetcache.redis.RedisCacheBuilder;
import com.alicp.jetcache.support.FastjsonKeyConvertor;
import com.alicp.jetcache.support.JavaValueDecoder;
import com.alicp.jetcache.support.JavaValueEncoder;
import com.google.common.collect.Maps;
import org.apache.commons.pool2.impl.GenericObjectPoolConfig;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.util.Pool;

import java.util.Map;

/**
 * jetCache缓存配置
 * @author 王艳兵
 * @date 2018/9/14 15:58
 */
@Configuration
@EnableMethodCache(basePackages = "com.fanyin.service")
@EnableCreateCacheAnnotation
@PropertySource("classpath:redis.properties")
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

    @Bean
    public Pool<Jedis> pool(){
        GenericObjectPoolConfig config = new GenericObjectPoolConfig();
        config.setMaxIdle(10);
        config.setMaxTotal(10);
        config.setMinIdle(2);
        return new JedisPool(config, host, port,timeout);
    }

    @Bean
    public SpringConfigProvider provider(){
        return new SpringConfigProvider();
    }

    @Bean
    public GlobalCacheConfig config(SpringConfigProvider configProvider, Pool<Jedis> pool){

        Map<String,CacheBuilder> localBuilder = Maps.newHashMap();
        EmbeddedCacheBuilder localCacheBuilder = LinkedHashMapCacheBuilder.createLinkedHashMapCacheBuilder()
                .keyConvertor(FastjsonKeyConvertor.INSTANCE);
        localBuilder.put(CacheConsts.DEFAULT_AREA,localCacheBuilder);

        Map<String,CacheBuilder> remoteBuilder = Maps.newHashMap();
        RedisCacheBuilder remoteCacheBuilder = RedisCacheBuilder.createRedisCacheBuilder()
                .keyConvertor(FastjsonKeyConvertor.INSTANCE)
                .valueDecoder(JavaValueDecoder.INSTANCE)
                .valueEncoder(JavaValueEncoder.INSTANCE)
                .jedisPool(pool);

        remoteBuilder.put(CacheConsts.DEFAULT_AREA,remoteCacheBuilder);

        GlobalCacheConfig config = new GlobalCacheConfig();
        config.setConfigProvider(configProvider);
        config.setRemoteCacheBuilders(remoteBuilder);
        config.setLocalCacheBuilders(localBuilder);
        config.setEnableMethodCache(true);
        config.setStatIntervalMinutes(15);
        config.setAreaInCacheName(false);
        return config;
    }

}
