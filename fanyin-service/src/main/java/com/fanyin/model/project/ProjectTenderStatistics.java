package com.fanyin.model.project;

import java.io.Serializable;
import java.util.Date;

/**
 * 投标统计信息表
 * @author 二哥很猛
 */
public class ProjectTenderStatistics implements Serializable {
    /**
     * 主键<br>
     * 表 : project_tender_statistics<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 产品id<br>
     * 表 : project_tender_statistics<br>
     * 对应字段 : project_id<br>
     */
    private Integer projectId;

    /**
     * 用户id<br>
     * 表 : project_tender_statistics<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 投标id<br>
     * 表 : project_tender_statistics<br>
     * 对应字段 : tender_id<br>
     */
    private Integer tenderId;

    /**
     * 类型 0:首投 1:最高 2:扫尾<br>
     * 表 : project_tender_statistics<br>
     * 对应字段 : type<br>
     */
    private Byte type;

    /**
     * 添加时间<br>
     * 表 : project_tender_statistics<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    private static final long serialVersionUID = 1L;

    /**
     * @return 主键
     */
    public Integer getId() {
        return id;
    }

    /**
     * @param id  主键
     */
    public void setId(Integer id) {
        this.id = id;
    }

    /**
     * @return 产品id
     */
    public Integer getProjectId() {
        return projectId;
    }

    /**
     * @param projectId  产品id
     */
    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    /**
     * @return 用户id
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * @param userId  用户id
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * @return 投标id
     */
    public Integer getTenderId() {
        return tenderId;
    }

    /**
     * @param tenderId  投标id
     */
    public void setTenderId(Integer tenderId) {
        this.tenderId = tenderId;
    }

    /**
     * @return 类型 0:首投 1:最高 2:扫尾
     */
    public Byte getType() {
        return type;
    }

    /**
     * @param type  类型 0:首投 1:最高 2:扫尾
     */
    public void setType(Byte type) {
        this.type = type;
    }

    /**
     * @return 添加时间
     */
    public Date getAddTime() {
        return addTime;
    }

    /**
     * @param addTime  添加时间
     */
    public void setAddTime(Date addTime) {
        this.addTime = addTime;
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
        ProjectTenderStatistics other = (ProjectTenderStatistics) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getProjectId() == null ? other.getProjectId() == null : this.getProjectId().equals(other.getProjectId()))
            && (this.getUserId() == null ? other.getUserId() == null : this.getUserId().equals(other.getUserId()))
            && (this.getTenderId() == null ? other.getTenderId() == null : this.getTenderId().equals(other.getTenderId()))
            && (this.getType() == null ? other.getType() == null : this.getType().equals(other.getType()))
            && (this.getAddTime() == null ? other.getAddTime() == null : this.getAddTime().equals(other.getAddTime()));
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
        result = prime * result + ((getUserId() == null) ? 0 : getUserId().hashCode());
        result = prime * result + ((getTenderId() == null) ? 0 : getTenderId().hashCode());
        result = prime * result + ((getType() == null) ? 0 : getType().hashCode());
        result = prime * result + ((getAddTime() == null) ? 0 : getAddTime().hashCode());
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
        sb.append(", userId=").append(userId);
        sb.append(", tenderId=").append(tenderId);
        sb.append(", type=").append(type);
        sb.append(", addTime=").append(addTime);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}