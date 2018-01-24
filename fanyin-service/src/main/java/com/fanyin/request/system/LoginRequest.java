package com.fanyin.request.system;

import java.io.Serializable;

/**
 * @description:
 * @author: 二哥很猛
 * @date: 2018/1/19
 * @time: 15:44
 */
public class LoginRequest implements Serializable {

    private static final long serialVersionUID = -8484365440329282780L;

    /**
     * 手机号码
     */
    private String mobile;

    /**
     * 密码
     */
    private String password;

    /**
     * 验证码
     */
    private String validCode;



    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getValidCode() {
        return validCode;
    }

    public void setValidCode(String validCode) {
        this.validCode = validCode;
    }
}
