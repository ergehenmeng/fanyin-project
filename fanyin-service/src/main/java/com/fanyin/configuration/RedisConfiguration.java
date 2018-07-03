package com.fanyin.configuration;

import org.springframework.cache.CacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.core.RedisTemplate;

/**
 * @author 二哥很猛
 * @date 2018/1/8 14:40
 */
@Configuration
public class RedisConfiguration{

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
     * @param redisTemplate redis访问模板类
     * @return bean
     */
    @Bean("defaultCacheManager")
    @Primary
    public CacheManager defaultCacheManager(RedisTemplate<Object,Object> redisTemplate){
        RedisCacheManager cacheManager = new RedisCacheManager(redisTemplate);
        cacheManager.setDefaultExpiration(EXPIRATION_30);
        cacheManager.setUsePrefix(true);
        return cacheManager;
    }

    /**
     * 系统级缓存管理器 默认永不过期
     * @param redisTemplate redisTemplate redis访问模板类
     * @return bean
     */
    @Bean("cacheManager")
    public CacheManager systemCacheManager(RedisTemplate<Object,Object> redisTemplate){
        RedisCacheManager cacheManager = new RedisCacheManager(redisTemplate);
        cacheManager.setUsePrefix(true);
        return cacheManager;
    }

    /**
     * 10分钟过期的缓存管理器
     * @param redisTemplate redisTemplate redis访问模板类
     * @return bean
     */
    @Bean("shortCacheManager")
    public CacheManager cacheManager(RedisTemplate<Object,Object> redisTemplate){
        RedisCacheManager cacheManager = new RedisCacheManager(redisTemplate);
        cacheManager.setDefaultExpiration(EXPIRATION_10);
        cacheManager.setUsePrefix(true);
        return cacheManager;
    }
}
