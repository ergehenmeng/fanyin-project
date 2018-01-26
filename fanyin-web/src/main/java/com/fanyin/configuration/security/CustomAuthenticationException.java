package com.fanyin.configuration.security;

import com.fanyin.enums.ErrorCodeEnum;
import org.springframework.security.core.AuthenticationException;

/**
 * @description: 自定义权限校验失败异常处理类
 * @author: 二哥很猛
 * @date: 2018/1/26
 * @time: 09:44
 */
public class CustomAuthenticationException extends AuthenticationException {

    private int code;

    private CustomAuthenticationException(String msg) {
        super(msg);
    }

    public CustomAuthenticationException(ErrorCodeEnum codeEnum){
        this(codeEnum.getMsg());
        this.code = codeEnum.getCode();
    }

    public int getCode() {
        return code;
    }
}
