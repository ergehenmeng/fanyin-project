package com.fanyin.model.project;

import java.io.Serializable;
import java.util.Date;

/**
 * 审核记录表
 * @author 二哥很猛
 */
public class ProjectAuditLog implements Serializable {
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
     * 对应字段 : status<br>
     */
    private Byte status;

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

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     * @return  id
     */
    public Integer getId() {
        return id;
    }

    /**
     * 主键
     * @param id   主键
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return 产品ID
     */
    public Integer getProjectId() {
        return projectId;
    }

    /**
     * @param projectId  产品ID
     */
    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    /**
     * @return 审核状态 1:初审通过 2:初审打回 3:复审通过 4:复审打回 5:满标复审通过 6:产品撤回
     */
    public Byte getStatus() {
        return status;
    }

    /**
     * @param status  审核状态 1:初审通过 2:初审打回 3:复审通过 4:复审打回 5:满标复审通过 6:产品撤回
     */
    public void setStatus(Byte status) {
        this.status = status;
    }

    /**
     * @return 审核记录
     */
    public String getRemark() {
        return remark;
    }

    /**
     * @param remark  审核记录
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    /**
     * @return 审核时间
     */
    public Date getAddTime() {
        return addTime;
    }

    /**
     * @param addTime  审核时间
     */
    public void setAddTime(Date addTime) {
        this.addTime = addTime;
    }

    /**
     * @return 审核人
     */
    public Integer getOperatorId() {
        return operatorId;
    }

    /**
     * @param operatorId  审核人
     */
    public void setOperatorId(Integer operatorId) {
        this.operatorId = operatorId;
    }

    /**
     *
     * @param that
     */
    @Override
    public boolean equals(Object that) {
        if (this == that) {
            return true;
        }
        if (that == null) {
            return false;
        }
        if (getClass() != that.getClass()) {
            return false;
        }
        ProjectAuditLog other = (ProjectAuditLog) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getProjectId() == null ? other.getProjectId() == null : this.getProjectId().equals(other.getProjectId()))
            && (this.getStatus() == null ? other.getStatus() == null : this.getStatus().equals(other.getStatus()))
            && (this.getRemark() == null ? other.getRemark() == null : this.getRemark().equals(other.getRemark()))
            && (this.getAddTime() == null ? other.getAddTime() == null : this.getAddTime().equals(other.getAddTime()))
            && (this.getOperatorId() == null ? other.getOperatorId() == null : this.getOperatorId().equals(other.getOperatorId()));
    }

    /**
     *
     */
    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((getId() == null) ? 0 : getId().hashCode());
        result = prime * result + ((getProjectId() == null) ? 0 : getProjectId().hashCode());
        result = prime * result + ((getStatus() == null) ? 0 : getStatus().hashCode());
        result = prime * result + ((getRemark() == null) ? 0 : getRemark().hashCode());
        result = prime * result + ((getAddTime() == null) ? 0 : getAddTime().hashCode());
        result = prime * result + ((getOperatorId() == null) ? 0 : getOperatorId().hashCode());
        return result;
    }

    /**
     *
     */
    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(getClass().getSimpleName());
        sb.append(" [");
        sb.append("Hash = ").append(hashCode());
        sb.append(", id=").append(id);
        sb.append(", projectId=").append(projectId);
        sb.append(", status=").append(status);
        sb.append(", remark=").append(remark);
        sb.append(", addTime=").append(addTime);
        sb.append(", operatorId=").append(operatorId);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}