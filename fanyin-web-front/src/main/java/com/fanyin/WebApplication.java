package com.fanyin;

import com.fanyin.utils.SpringContextUtil;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.Banner;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.transaction.annotation.EnableTransactionManagement;

/**
 * 前后端分离
 * @author 二哥很猛
 * @date
 */
@SpringBootApplication
@EnableTransactionManagement
@EnableAsync
@EnableAspectJAutoProxy
@MapperScan("com.fanyin.mapper")
@EnableCaching
@ServletComponentScan(basePackages = "com.fanyin.filter")
public class WebApplication {

    public static void main(String[] args) {
        ConfigurableApplicationContext applicationContext = new SpringApplicationBuilder(WebApplication.class).bannerMode(Banner.Mode.OFF).web(true).run(args);
        SpringContextUtil.setApplicationContext(applicationContext);
    }
}
