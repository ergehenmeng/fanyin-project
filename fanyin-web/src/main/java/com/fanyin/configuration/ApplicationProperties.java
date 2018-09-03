package com.fanyin.configuration;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;


/**
 * @author 二哥很猛
 * @date 2018/7/2 14:05
 */
@ConfigurationProperties(prefix = "project")
@Component
public class ApplicationProperties {

    /**
     * 系统版本号
     */
    private String version;

    /**
     * 未登陆忽略,不拦截的地址
     */
    private String ignoreUrl;

    /**
     * 已登录 忽略的地址
     */
    private String loginIgnoreUrl;

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getIgnoreUrl() {
        return ignoreUrl;
    }

    public void setIgnoreUrl(String ignoreUrl) {
        this.ignoreUrl = ignoreUrl;
    }

    public String getLoginIgnoreUrl() {
        return loginIgnoreUrl;
    }

    public void setLoginIgnoreUrl(String loginIgnoreUrl) {
        this.loginIgnoreUrl = loginIgnoreUrl;
    }
}
