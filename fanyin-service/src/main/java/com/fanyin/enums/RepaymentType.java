package com.fanyin.enums;

/**
 * 还款方式 计息方式
 * @author 二哥很猛
 * @date 2018/11/12 17:43
 */
public enum RepaymentType {

    /**
     * 等额本息
     */
    EQUAL_AMOUNT((byte)0,"等额本息"),

    /**
     * 按月计息
     */
    MONTHLY((byte)1,"按月计息,到期还本"),

    /**
     * 到期还本还息
     */
    DAILY((byte) 2,"按天计息,到期还本还息");

    private byte mode;

    private String name;

    public String getName() {
        return name;
    }

    RepaymentType(byte mode,String name) {
        this.mode = mode;
        this.name = name;
    }

    public int getMode() {
        return mode;
    }
}

