package com.fanyin.enums;

/**
 * 提现状态
 * @author 二哥很猛
 */
public enum WithdrawStatus {

    /**
     * 取消提现
     */
    CANCEL((byte)-1,"取消提现"),

    /**
     * 录入中
     */
    ENTRY((byte)0,"录入中"),

    /**
     * 提现申请
     */
    APPLY((byte)1,"申请中"),

    /**
     * 提现成功
     */
    SUCCESS((byte)2,"提现成功"),

    /**
     * 审核失败
     */
    AUDIT_FAIL((byte)3,"审核失败"),

    /**
     * 提现失败
     */
    FAIL((byte)4,"提现失败"),
    ;

    /**
     * 状态
     */
    private byte code;

    /**
     * msg
     */
    private String msg;

    WithdrawStatus(byte code, String msg) {
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

