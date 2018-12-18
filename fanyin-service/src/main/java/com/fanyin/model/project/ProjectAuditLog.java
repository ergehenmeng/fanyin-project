package com.fanyin.model.project;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 审核记录表
 * @author 二哥很猛
 */
@Data
public class ProjectAuditLog implements Serializable {
    private static final long serialVersionUID = -8136119240648118109L;
    /**
     * <br>主键
     * 表 : project_audit_log<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 产品ID<br>
     * 表 : project_audit_log<br>
     * 对应字段 : project_id<br>
     */
    private Integer projectId;

    /**
     * 审核状态 1:初审通过 2:初审打回 3:复审通过 4:复审打回 5:满标复审通过 6:产品撤回<br>
     * 表 : project_audit_log<br>
     * 对应字段 : state<br>
     */
    private Byte state;

    /**
     * 审核记录<br>
     * 表 : project_audit_log<br>
     * 对应字段 : remark<br>
     */
    private String remark;

    /**
     * 审核时间<br>
     * 表 : project_audit_log<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 审核人<br>
     * 表 : project_audit_log<br>
     * 对应字段 : operator_id<br>
     */
    private Integer operatorId;


}