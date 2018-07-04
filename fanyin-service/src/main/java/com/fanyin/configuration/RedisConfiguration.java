package com.fanyin.configuration;

import com.fasterxml.jackson.annotation.JsonAutoDetect;
import com.fasterxml.jackson.annotation.PropertyAccessor;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.cache.CacheManager;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.data.redis.cache.RedisCacheManager;
import org.springframework.data.redis.connection.RedisConnectionFactory;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

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
     * 默认redisAutoConfiguration配置时,采用的是jdk序列化,该处可自定义序列化方式;
     * <br>在新版本fastJson也提供了序列化:
     * <br>FastJsonRedisSerializer(可配置化)
     * <br>GenericFastJsonRedisSerializer(默认配置)
     * @param factory factory
     * @return bean
     */
    @Bean("redisTemplate")
    @Primary
    public RedisTemplate<Object,Object> redisTemplate(RedisConnectionFactory factory){
        RedisTemplate<Object,Object> redisTemplate = new RedisTemplate<>();
        redisTemplate.setConnectionFactory(factory);
        Jackson2JsonRedisSerializer<Object> serializer = new Jackson2JsonRedisSerializer<>(Object.class);
        ObjectMapper mapper = new ObjectMapper();
        mapper.setVisibility(PropertyAccessor.ALL, JsonAutoDetect.Visibility.ANY);
        mapper.enableDefaultTyping(ObjectMapper.DefaultTyping.NON_FINAL);
        serializer.setObjectMapper(mapper);
        redisTemplate.setValueSerializer(serializer);
        redisTemplate.setKeySerializer(new StringRedisSerializer());
        redisTemplate.afterPropertiesSet();
        return redisTemplate;
    }


    /**
     * 默认缓存管理期 默认30分钟过期
     * @param redisTemplate redis访问模板类
     * @return bean
     */
    @Bean("longCacheManager")
    public CacheManager longCacheManager(RedisTemplate<Object,Object> redisTemplate){
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
    @Primary
    public CacheManager cacheManager(RedisTemplate<Object,Object> redisTemplate){
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
    public CacheManager shortCacheManager(RedisTemplate<Object,Object> redisTemplate){
        RedisCacheManager cacheManager = new RedisCacheManager(redisTemplate);
        cacheManager.setDefaultExpiration(EXPIRATION_10);
        cacheManager.setUsePrefix(true);
        return cacheManager;
    }
}
