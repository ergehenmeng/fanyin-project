package com.fanyin.dto.security;

import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * token令牌
 * @author 二哥很猛
 * @date 2018/8/14 17:37
 */
@Getter
@Setter
public class AccessToken implements Serializable {

    private static final long serialVersionUID = -539686478899884844L;

    /**
     * accessKey
     */
    private String accessKey;

    /**
     * token
     */
    private String accessToken;

    /**
     * 用户id
     */
    private int userId;

    /**
     * 访问来源 ANDROID IOS
     */
    private String source;
}
