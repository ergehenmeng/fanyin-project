package com.fanyin.dto;

import java.io.Serializable;

/**
 * token令牌
 * @author 王艳兵
 * @date 2018/8/14 17:37
 */
public class Token implements Serializable {

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


    public String getAccessKey() {
        return accessKey;
    }

    public void setAccessKey(String accessKey) {
        this.accessKey = accessKey;
    }

    public String getAccessToken() {
        return accessToken;
    }

    public void setAccessToken(String accessToken) {
        this.accessToken = accessToken;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }


}
