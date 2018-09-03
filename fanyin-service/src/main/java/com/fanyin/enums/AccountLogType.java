package com.fanyin.enums;

/**
 * 资产变动详细记录类型 包含借款人和投资人(平台账户以银行为准)
 * @author 二哥很猛
 * @date 2018/8/8 11:52
 */
public enum AccountLogType {

    /**
     * 投资人充值
     */
    RECHARGE(0,"充值"),

    /**
     * 投资人投标
     */
    TENDER(1,"投标"),

    /**
     * 投资人待收本金增加
     */
    RECEIVE_ADD(2,"待收增加"),

    /**
     * 回款
     */
    RECEIVE(3,"回款"),

    /**
     * 投资人提现冻结
     */
    WITHDRAW_FREEZE(4,"提现冻结"),

    /**
     * 提现成功
     */
    WITHDRAW(5,"提现"),


    /**
     *借款人充值
     */
    BORROWER_RECHARGE(6,"借款人充值"),

    /**
     * 借款人还款
     */
    REPAYMENT(7,"还款"),

    /**
     * 借款人提现冻结
     */
    BORROWER_WITHDRAW_FREEZE(8,"借款人提现冻结"),

    /**
     * 借款人提现成功
     */
    BORROWER_WITHDRAW(9,"提现成功"),
    ;

    /**
     * 资金变动类型
     */
    private int type;

    /**
     * 资金变动说明
     */
    private String msg;

    AccountLogType(int type, String msg) {
        this.type = type;
        this.msg = msg;
    }

    public int getType() {
        return type;
    }

    public void setType(int type) {
        this.type = type;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
