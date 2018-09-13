package com.fanyin.dto;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;

/**
 * 用户请求信息
 * @author 二哥很猛
 * @date 2018/8/15 13:56
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class DataMessage extends AccessToken implements Serializable {

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

}
