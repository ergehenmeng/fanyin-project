package com.fanyin.enums;

/**
 * @author 二哥很猛
 * @date 2018/11/12 11:41
 */
public enum ProjectStatus {

    /**
     * 废弃
     */
    DISCARD((byte)-2,"已废弃"),

    /**
     * 已撤回
     */
    REVOCATION((byte)-1,"已撤回"),

    /**
     * 录入中
     */
    ENTERING((byte)0,"录入中"),
    /**
     * 待初审
     */
    AUDIT((byte)1,"待初审"),

    /**
     *待复审
     */
    RECHECK((byte)2,"待复审"),

    /**
     * 募集中
     */
    RAISE((byte)3,"募集中"),

    /**
     *满标待复审
     */
    FULL((byte)4,"满标待复审"),

    /**
     *还款中
     */
    REPAYMENT((byte)5,"还款中"),

    /**
     * 还款完成
     */
    FINISH((byte)6,"还款完成"),

    /**
     * 逾期结清
     */
    OVERDUE((byte)7,"逾期结清");

    private byte code;

    private String name;

    public byte getCode() {
        return code;
    }

    public String getName() {
        return name;
    }

    ProjectStatus(byte code, String name) {
        this.code = code;
        this.name = name;
    }

    public static ProjectStatus equalsCode(byte code){
        for (ProjectStatus projectStatus : ProjectStatus.values()) {
            if(code == projectStatus.getCode()){
                return projectStatus;
            }
        }
        return DISCARD;
    }
}

