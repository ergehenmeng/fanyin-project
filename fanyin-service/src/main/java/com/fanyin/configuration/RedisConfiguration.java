package com.fanyin.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.data.redis.RedisProperties;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.cache.CacheManager;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.connection.jedis.JedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.serializer.GenericJackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.RedisSerializer;

/**
 * @description:
 * @author: 二哥很猛
 * @date: 2018/1/8
 * @time: 14:40
 */
@Configuration
@EnableCaching
@EnableConfigurationProperties(value = RedisProperties.class)
public class RedisConfiguration{

    @Autowired
    private RedisProperties redisProperties;

    /**
     * 过期时间 30分钟
     */
    private static final int EXPIRATION_30 = 30 * 60;

    /**
     * 过期时间 10分钟
     */
    private static final int EXPIRATION_10 = 10 * 60;

    /**
     * 默认缓存管理期 默认30分钟过期
     * @param redisTemplate
     * @return
     */
    @Bean("cacheManager")
    @Primary
    public CacheManager defaultCacheManager(RedisTemplate redisTemplate){
        RedisCacheManager cacheManager = new RedisCacheManager(redisTemplate);
        cacheManager.setDefaultExpiration(EXPIRATION_30);
        cacheManager.setUsePrefix(true);
        return cacheManager;
    }

    /**
     * 系统级缓存管理器 默认永不过期
     * @param redisTemplate
     * @return
     */
    @Bean("systemCacheManager")
    public CacheManager systemCacheManager(RedisTemplate redisTemplate){
        RedisCacheManager cacheManager = new RedisCacheManager(redisTemplate);
        cacheManager.setUsePrefix(true);
        return cacheManager;
    }

    /**
     * 10分钟过期的缓存管理器
     * @param redisTemplate
     * @return
     */
    @Bean("shortCacheManager")
    public CacheManager cacheManager(RedisTemplate redisTemplate){
        RedisCacheManager cacheManager = new RedisCacheManager(redisTemplate);
        cacheManager.setDefaultExpiration(EXPIRATION_10);
        cacheManager.setUsePrefix(true);
        return cacheManager;
    }

    @Bean
    public RedisTemplate<String,String> redisTemplate(RedisConnectionFactory factory){
        RedisTemplate<String,String> redisTemplate = new StringRedisTemplate(factory);
        RedisSerializer serializer = new GenericJackson2JsonRedisSerializer();
        redisTemplate.setValueSerializer(serializer);
        redisTemplate.afterPropertiesSet();
        return redisTemplate;
    }

    @Bean
    public RedisConnectionFactory redisConnectionFactory(){
        JedisConnectionFactory factory = new JedisConnectionFactory();
        factory.setPort(redisProperties.getPort());
        factory.setHostName(redisProperties.getHost());
        factory.setPassword(redisProperties.getPassword());
        factory.setTimeout(redisProperties.getTimeout());
        return factory;
    }


}
