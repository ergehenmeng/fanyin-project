package com.fanyin.enums;

/**
 * @author 王艳兵
 * @date 2018/11/12 11:41
 */
public enum ProjectStatus {

    /**
     * 废弃
     */
    DISCARD(-2,"废弃"),

    /**
     * 标的撤回
     */
    REVOCATION(-1,"标的撤回"),

    /**
     * 待初审
     */
    AUDIT(0,"待初审"),

    /**
     *待复审
     */
    RECHECK(1,"待复审"),

    /**
     * 募集中
     */
    RAISE(2,"募集中"),

    /**
     *满标待复审
     */
    FULL(3,"满标待复审"),

    /**
     *还款中
     */
    REPAYMENT(4,"还款中"),

    /**
     * 还款完成
     */
    FINISH(5,"还款完成"),

    /**
     * 逾期结清
     */
    OVERDUE(6,"逾期结清");

    private int code;

    private String name;

    public int getCode() {
        return code;
    }

    public String getName() {
        return name;
    }

    ProjectStatus(int code, String name) {
        this.code = code;
        this.name = name;
    }
}

