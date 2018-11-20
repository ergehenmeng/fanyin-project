package com.fanyin.enums;

/**
 * 资产变动类型 投资人
 * @author 二哥很猛
 * @date 2018/8/8 11:52
 */
public  enum AccountLogType {

    /**
     * 投资人充值
     */
    RECHARGE((byte)0,"充值"),

    /**
     * 投资人投资
     */
    TENDER((byte)1,"投资"),

    /**
     * 投资人回款
     */
    RECEIVE((byte)2,"回款"),

    /**
     * 投资人提现
     */
    WITHDRAW((byte)3,"提现"),

    /**
     * 平台奖励
     */
    PLATFORM_AWARD((byte)4,"平台奖励"),

    /**
     * 转让承接奖励
     */
    AWARD((byte)5,"承接奖励"),

    /**
     * 债权转让回款
     */
    TRANSFER((byte)6,"转让"),

    /**
     * 撤标
     */
    REVOCATION((byte)7,"撤标"),

    /**
     * 满标复审 待收本息早呢更加
     */
    FULL_AUDIT((byte)11,"待收本息增加");

    /**
     * 资金变动类型
     */
    private byte type;

    /**
     * 资金变动说明
     */
    private String msg;


    AccountLogType(byte type, String msg) {
        this.type = type;
        this.msg = msg;
    }

    public byte getType() {
        return type;
    }

    public String getMsg() {
        return msg;
    }

}
