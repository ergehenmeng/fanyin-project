package com.fanyin.enums;

/**
 * @author 王艳兵
 * @date 2018/11/23 18:49
 */
public enum DepositStatus {
    /**
     * 未开户
     */
    DEFAULT((byte)0,"未开户"),

    /**
     * 激活中
     */
    APPLY((byte)1,"激活中"),

    /**
     * 开户成功
     */
    SUCCESS((byte)2,"开户成功"),

    /**
     * 开户失败
     */
    FAIL((byte)3,"开户失败"),

    /**
     * 重新授权中
     */
    AUTH((byte)4,"存管授权中"),

    /**
     * 银行预留手机号变更中
     */
    MODIFY_MOBILE((byte)5,"银行预留手机号变更中"),
    /**
     * 银行卡号变更中
     */
    MODIFY_BANK((byte)6,"银行卡号变更中"),

    /**
     * 企业信息变更中
     */
    MODIFY_ENTERPRISE((byte)7,"企业信息变更中"),
    ;

    private byte code;

    private String msg;

    DepositStatus(byte code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public byte getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}

