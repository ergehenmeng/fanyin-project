package com.fanyin.exception;

import com.fanyin.enums.ErrorCodeEnum;

/**
 * @author 验签异常
 * @date 2018/11/22 19:43
 */
public class TokenException extends SystemException{

    private static final long serialVersionUID = -9091773376155376126L;

    public TokenException(ErrorCodeEnum error) {
        super(error);
    }

    TokenException(int code, String msg) {
        super(code, msg);
    }

    public TokenException(String msg, Throwable e) {
        super(msg, e);
    }

    public TokenException(Throwable e) {
        super(e);
    }
}
