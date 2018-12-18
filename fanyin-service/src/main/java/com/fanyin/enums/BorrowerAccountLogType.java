package com.fanyin.enums;

/**
 * @author 二哥很猛
 * @date 2018/11/19 16:36
 */
public enum  BorrowerAccountLogType {

    /**
     * 放款
     */
    BORROWER_LOAN((byte)0,"放款"),

    /**
     * 借款人提现
     */
    BORROWER_WITHDRAW((byte)1,"提现"),

    /**
     * 借款人缴费
     */
    BORROWER_PAY((byte)2,"缴费"),

    /**
     * 借款人充值
     */
    BORROWER_RECHARGE((byte)3,"充值"),

    /**
     * 借款人还款
     */
    BORROWER_REPAYMENT((byte)4,"还款"),
    ;

    /**
     * 资金变动类型
     */
    private byte classify;

    /**
     * 资金变动说明
     */
    private String msg;


    BorrowerAccountLogType(byte classify, String msg) {
        this.classify = classify;
        this.msg = msg;
    }

    public byte getClassify() {
        return classify;
    }

    public String getMsg() {
        return msg;
    }
}
