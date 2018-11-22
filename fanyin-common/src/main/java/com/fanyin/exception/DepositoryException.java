package com.fanyin.exception;

import com.fanyin.enums.ErrorCodeEnum;

/**
 * 存管异常处理
 * @author 二哥很猛
 * @date 2018/11/22 19:39
 */
public class DepositoryException extends SystemException {

    private static final long serialVersionUID = 1076331833229793561L;

    public DepositoryException(ErrorCodeEnum error) {
        super(error);
    }

    DepositoryException(int code, String msg) {
        super(code, msg);
    }

    public DepositoryException(String msg, Throwable e) {
        super(msg, e);
    }

    public DepositoryException(Throwable e) {
        super(e);
    }
}
