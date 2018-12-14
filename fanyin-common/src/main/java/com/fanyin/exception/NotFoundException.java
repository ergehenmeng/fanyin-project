package com.fanyin.exception;

import com.fanyin.enums.ErrorCodeEnum;

/**
 * 数据未查找到
 * @author 二哥很猛
 * @date 2018/12/3 17:10
 */
public class NotFoundException extends BusinessException {
    private static final long serialVersionUID = -5687886803254978251L;

    public NotFoundException(ErrorCodeEnum error) {
        super(error);
    }

    public NotFoundException(int code, String msg) {
        super(code, msg);
    }
}
