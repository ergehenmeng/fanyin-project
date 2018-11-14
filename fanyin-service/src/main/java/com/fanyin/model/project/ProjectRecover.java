package com.fanyin.model.project;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 投资人回款信息表
 * @author 二哥很猛
 */
public class ProjectRecover implements Serializable {
    /**
     * 主键<br>
     * 表 : project_recover<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 投资人ID<br>
     * 表 : project_recover<br>
     * 对应字段 : user_id<br>
     */
    private Integer userId;

    /**
     * 回款状态 0:待回款 1:已回款<br>
     * 表 : project_recover<br>
     * 对应字段 : status<br>
     */
    private Byte status;

    /**
     * 投标ID<br>
     * 表 : project_recover<br>
     * 对应字段 : tender_id<br>
     */
    private Integer tenderId;

    /**
     * 项目ID<br>
     * 表 : project_recover<br>
     * 对应字段 : project_id<br>
     */
    private Integer projectId;

    /**
     * 第几期回款<br>
     * 表 : project_recover<br>
     * 对应字段 : period<br>
     */
    private Byte period;

    /**
     * 总期数<br>
     * 表 : project_recover<br>
     * 对应字段 : periods<br>
     */
    private Byte periods;

    /**
     * 应还本金<br>
     * 表 : project_recover<br>
     * 对应字段 : capital<br>
     */
    private BigDecimal capital;

    /**
     * 预计回款利息(基础利息)<br>
     * 表 : project_recover<br>
     * 对应字段 : interest<br>
     */
    private BigDecimal interest;

    /**
     * 预计平台加息利息<br>
     * 表 : project_recover<br>
     * 对应字段 : platform_interest<br>
     */
    private BigDecimal platformInterest;

    /**
     * 预计加息券利息<br>
     * 表 : project_recover<br>
     * 对应字段 : coupon_interest<br>
     */
    private BigDecimal couponInterest;

    /**
     * 预计回款时间(精确到天)<br>
     * 表 : project_recover<br>
     * 对应字段 : receive_time<br>
     */
    private Date receiveTime;

    /**
     * 实际回款时间<br>
     * 表 : project_recover<br>
     * 对应字段 : real_receive_time<br>
     */
    private Date realReceiveTime;

    /**
     * 预计回款月yyyy-MM<br>
     * 表 : project_recover<br>
     * 对应字段 : receive_month<br>
     */
    private String receiveMonth;

    /**
     * 实际回款月yyyy-MM<br>
     * 表 : project_recover<br>
     * 对应字段 : real_receive_month<br>
     */
    private String realReceiveMonth;

    /**
     * 添加时间<br>
     * 表 : project_recover<br>
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
     * @return 投资人ID
     */
    public Integer getUserId() {
        return userId;
    }

    /**
     * @param userId  投资人ID
     */
    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    /**
     * @return 回款状态 0:待回款 1:已回款
     */
    public Byte getStatus() {
        return status;
    }

    /**
     * @param status  回款状态 0:待回款 1:已回款
     */
    public void setStatus(Byte status) {
        this.status = status;
    }

    /**
     * @return 投标ID
     */
    public Integer getTenderId() {
        return tenderId;
    }

    /**
     * @param tenderId  投标ID
     */
    public void setTenderId(Integer tenderId) {
        this.tenderId = tenderId;
    }

    /**
     * @return 项目ID
     */
    public Integer getProjectId() {
        return projectId;
    }

    /**
     * @param projectId  项目ID
     */
    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    /**
     * @return 第几期回款
     */
    public Byte getPeriod() {
        return period;
    }

    /**
     * @param period  第几期回款
     */
    public void setPeriod(Byte period) {
        this.period = period;
    }

    /**
     * @return 总期数
     */
    public Byte getPeriods() {
        return periods;
    }

    /**
     * @param periods  总期数
     */
    public void setPeriods(Byte periods) {
        this.periods = periods;
    }

    /**
     * @return 应还本金
     */
    public BigDecimal getCapital() {
        return capital;
    }

    /**
     * @param capital  应还本金
     */
    public void setCapital(BigDecimal capital) {
        this.capital = capital;
    }

    /**
     * @return 预计回款利息(基础利息)
     */
    public BigDecimal getInterest() {
        return interest;
    }

    /**
     * @param interest  预计回款利息(基础利息)
     */
    public void setInterest(BigDecimal interest) {
        this.interest = interest;
    }

    /**
     * @return 预计平台加息利息
     */
    public BigDecimal getPlatformInterest() {
        return platformInterest;
    }

    /**
     * @param platformInterest  预计平台加息利息
     */
    public void setPlatformInterest(BigDecimal platformInterest) {
        this.platformInterest = platformInterest;
    }

    /**
     * @return 预计加息券利息
     */
    public BigDecimal getCouponInterest() {
        return couponInterest;
    }

    /**
     * @param couponInterest  预计加息券利息
     */
    public void setCouponInterest(BigDecimal couponInterest) {
        this.couponInterest = couponInterest;
    }

    /**
     * @return 预计回款时间(精确到天)
     */
    public Date getReceiveTime() {
        return receiveTime;
    }

    /**
     * @param receiveTime  预计回款时间(精确到天)
     */
    public void setReceiveTime(Date receiveTime) {
        this.receiveTime = receiveTime;
    }

    /**
     * @return 实际回款时间
     */
    public Date getRealReceiveTime() {
        return realReceiveTime;
    }

    /**
     * @param realReceiveTime  实际回款时间
     */
    public void setRealReceiveTime(Date realReceiveTime) {
        this.realReceiveTime = realReceiveTime;
    }

    /**
     * @return 预计回款月yyyy-MM
     */
    public String getReceiveMonth() {
        return receiveMonth;
    }

    /**
     * @param receiveMonth  预计回款月yyyy-MM
     */
    public void setReceiveMonth(String receiveMonth) {
        this.receiveMonth = receiveMonth == null ? null : receiveMonth.trim();
    }

    /**
     * @return 实际回款月yyyy-MM
     */
    public String getRealReceiveMonth() {
        return realReceiveMonth;
    }

    /**
     * @param realReceiveMonth  实际回款月yyyy-MM
     */
    public void setRealReceiveMonth(String realReceiveMonth) {
        this.realReceiveMonth = realReceiveMonth == null ? null : realReceiveMonth.trim();
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
        ProjectRecover other = (ProjectRecover) that;
        return (this.getId() == null ? other.getId() == null : this.getId().equals(other.getId()))
            && (this.getUserId() == null ? other.getUserId() == null : this.getUserId().equals(other.getUserId()))
            && (this.getStatus() == null ? other.getStatus() == null : this.getStatus().equals(other.getStatus()))
            && (this.getTenderId() == null ? other.getTenderId() == null : this.getTenderId().equals(other.getTenderId()))
            && (this.getProjectId() == null ? other.getProjectId() == null : this.getProjectId().equals(other.getProjectId()))
            && (this.getPeriod() == null ? other.getPeriod() == null : this.getPeriod().equals(other.getPeriod()))
            && (this.getPeriods() == null ? other.getPeriods() == null : this.getPeriods().equals(other.getPeriods()))
            && (this.getCapital() == null ? other.getCapital() == null : this.getCapital().equals(other.getCapital()))
            && (this.getInterest() == null ? other.getInterest() == null : this.getInterest().equals(other.getInterest()))
            && (this.getPlatformInterest() == null ? other.getPlatformInterest() == null : this.getPlatformInterest().equals(other.getPlatformInterest()))
            && (this.getCouponInterest() == null ? other.getCouponInterest() == null : this.getCouponInterest().equals(other.getCouponInterest()))
            && (this.getReceiveTime() == null ? other.getReceiveTime() == null : this.getReceiveTime().equals(other.getReceiveTime()))
            && (this.getRealReceiveTime() == null ? other.getRealReceiveTime() == null : this.getRealReceiveTime().equals(other.getRealReceiveTime()))
            && (this.getReceiveMonth() == null ? other.getReceiveMonth() == null : this.getReceiveMonth().equals(other.getReceiveMonth()))
            && (this.getRealReceiveMonth() == null ? other.getRealReceiveMonth() == null : this.getRealReceiveMonth().equals(other.getRealReceiveMonth()))
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
        result = prime * result + ((getUserId() == null) ? 0 : getUserId().hashCode());
        result = prime * result + ((getStatus() == null) ? 0 : getStatus().hashCode());
        result = prime * result + ((getTenderId() == null) ? 0 : getTenderId().hashCode());
        result = prime * result + ((getProjectId() == null) ? 0 : getProjectId().hashCode());
        result = prime * result + ((getPeriod() == null) ? 0 : getPeriod().hashCode());
        result = prime * result + ((getPeriods() == null) ? 0 : getPeriods().hashCode());
        result = prime * result + ((getCapital() == null) ? 0 : getCapital().hashCode());
        result = prime * result + ((getInterest() == null) ? 0 : getInterest().hashCode());
        result = prime * result + ((getPlatformInterest() == null) ? 0 : getPlatformInterest().hashCode());
        result = prime * result + ((getCouponInterest() == null) ? 0 : getCouponInterest().hashCode());
        result = prime * result + ((getReceiveTime() == null) ? 0 : getReceiveTime().hashCode());
        result = prime * result + ((getRealReceiveTime() == null) ? 0 : getRealReceiveTime().hashCode());
        result = prime * result + ((getReceiveMonth() == null) ? 0 : getReceiveMonth().hashCode());
        result = prime * result + ((getRealReceiveMonth() == null) ? 0 : getRealReceiveMonth().hashCode());
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
        sb.append(", userId=").append(userId);
        sb.append(", status=").append(status);
        sb.append(", tenderId=").append(tenderId);
        sb.append(", projectId=").append(projectId);
        sb.append(", period=").append(period);
        sb.append(", periods=").append(periods);
        sb.append(", capital=").append(capital);
        sb.append(", interest=").append(interest);
        sb.append(", platformInterest=").append(platformInterest);
        sb.append(", couponInterest=").append(couponInterest);
        sb.append(", receiveTime=").append(receiveTime);
        sb.append(", realReceiveTime=").append(realReceiveTime);
        sb.append(", receiveMonth=").append(receiveMonth);
        sb.append(", realReceiveMonth=").append(realReceiveMonth);
        sb.append(", addTime=").append(addTime);
        sb.append(", serialVersionUID=").append(serialVersionUID);
        sb.append("]");
        return sb.toString();
    }
}