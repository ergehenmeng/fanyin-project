package com.fanyin.enums;

/**
 * 产品审核状态 1:初审通过 2:初审打回 3:复审通过 4:复审拒绝 5:复审打回(直接回到录入中) 6:满标复审通过 7:产品撤回
 * @author 二哥很猛
 * @date 2018/11/12 16:58
 */
public enum ProjectAuditStatus {
    /**
     *初审通过
     */
    AUDIT_PASS(1,"初审通过"),

    /**
     * 初审打回
     */
    AUDIT_REPULSE(2,"初审打回"),

    /**
     * 复审通过
     */
    RECHECK_PASS(3,"复审通过"),

    /**
     * 复审拒绝
     */
    RECHECK_REJECT(4,"复审拒绝"),

    /**
     * 复审打回
     */
    RECHECK_REPULSE(5,"复审打回"),

    /**
     * 满标复审通过
     */
    FULL_RECHECK_PASS(6,"满标复审通过"),

    /**
     * 产品撤回
     */
    REVOCATION(7,"产品撤回");

    private int code;

    private String name;

    ProjectAuditStatus(int code, String name) {
        this.code = code;
        this.name = name;
    }

    public int getCode() {
        return code;
    }

    public String getName() {
        return name;
    }
}

