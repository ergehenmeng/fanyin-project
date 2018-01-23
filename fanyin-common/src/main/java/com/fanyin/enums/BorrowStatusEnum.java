package com.fanyin.enums;

/**
 * @description: 标的状态枚举
 * @author: 二哥很猛
 * @date: 2018/1/10
 * @time: 17:50
 */
public enum BorrowStatusEnum {

    /**
     * 标的撤回
     */
    STATUS_$1(-1,"标的撤回"),
    /**
     * 待初审
     */
    STATUS_0(0,"待初审"),
    /**
     * 待复审
     */
    STATUS_1(1,"待复审"),
    /**
     * 募集中
     */
    STATUS_2(2,"募集中"),
    /**
     * 满标待审
     */
    STATUS_3(3,"满标待审"),
    /**
     * 还款中
     */
    STATUS_4(4,"还款中"),
    /**
     * 还款完成
     */
    STATUS_5(5,"还款完成");

    private int status;

    private String name;

    BorrowStatusEnum(int status, String name) {
        this.status = status;
        this.name = name;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
