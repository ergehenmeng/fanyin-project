package com.fanyin.dto;

import java.io.Serializable;

/**
 * 用户请求信息
 * @author 王艳兵
 * @date 2018/8/15 13:56
 */
public class DataMessage extends Token implements Serializable {

    private static final long serialVersionUID = 1588228430420375286L;

    /**
     * 软件版本号 针对app端
     */
    private String version;

    /**
     * 客户端类型 ANDROID,IOS,PC,H5
     */
    private String source;

    /**
     * 客户端平台版本号 ios: 10.4.1,android:8.1.0
     */
    private String osVersion;

    public DataMessage(String version, String source, String osVersion) {
        this.version = version;
        this.source = source;
        this.osVersion = osVersion;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getOsVersion() {
        return osVersion;
    }

    public void setOsVersion(String osVersion) {
        this.osVersion = osVersion;
    }
}
