package com.fanyin.enums;

/**
 * @author 充值状态
 * @date 2018/11/22 20:11
 */
public enum  RechargeStatus {

    /**
     * 待充值
     */
    APPLY((byte)0,"待充值"),

    /**
     * 充值成功
     */
    SUCCESS((byte)1,"充值成功"),

    /**
     * 充值失败
     */
    FAIL((byte)2,"充值失败"),
    ;

    /**
     * 状态
     */
    private int code;

    /**
     * msg
     */
    private String msg;

    RechargeStatus(int code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    public int getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}
