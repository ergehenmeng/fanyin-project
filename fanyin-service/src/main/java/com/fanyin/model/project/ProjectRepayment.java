package com.fanyin.model.project;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 借款人还款信息表
 * @author 二哥很猛
 */
public class ProjectRepayment implements Serializable {
    /**
     * 主键<br>
     * 表 : project_repayment<br>
     * 对应字段 : id<br>
     */
    private Integer id;

    /**
     * 借款人ID<br>
     * 表 : project_repayment<br>
     * 对应字段 : borrower_id<br>
     */
    private Integer borrowerId;

    /**
     * 标的ID<br>
     * 表 : project_repayment<br>
     * 对应字段 : project_id<br>
     */
    private Integer projectId;

    /**
     * 还款状态 0:未还款 1:正常还款,2:提前还款,3:部分还款,4:逾期还款<br>
     * 表 : project_repayment<br>
     * 对应字段 : status<br>
     */
    private Boolean status;

    /**
     * 第几期还款<br>
     * 表 : project_repayment<br>
     * 对应字段 : period<br>
     */
    private Byte period;

    /**
     * 总期数<br>
     * 表 : project_repayment<br>
     * 对应字段 : periods<br>
     */
    private Byte periods;

    /**
     * 预计还款本金<br>
     * 表 : project_repayment<br>
     * 对应字段 : capital<br>
     */
    private BigDecimal capital;

    /**
     * 基础利息<br>
     * 表 : project_repayment<br>
     * 对应字段 : interest<br>
     */
    private BigDecimal interest;

    /**
     * 平台加息利息<br>
     * 表 : project_repayment<br>
     * 对应字段 : platform_interest<br>
     */
    private BigDecimal platformInterest;

    /**
     * 加息券利息<br>
     * 表 : project_repayment<br>
     * 对应字段 : coupon_interest<br>
     */
    private BigDecimal couponInterest;

    /**
     * 预计还款时间(精确到天)<br>
     * 表 : project_repayment<br>
     * 对应字段 : repay_time<br>
     */
    private Date repayTime;

    /**
     * 实际还款时间(精确到秒)<br>
     * 表 : project_repayment<br>
     * 对应字段 : real_repay_time<br>
     */
    private Date realRepayTime;

    /**
     * 备注信息<br>
     * 表 : project_repayment<br>
     * 对应字段 : remark<br>
     */
    private String remark;

    /**
     * 添加时间<br>
     * 表 : project_repayment<br>
     * 对应字段 : add_time<br>
     */
    private Date addTime;

    /**
     * 更新时间<br>
     * 表 : project_repayment<br>
     * 对应字段 : update_time<br>
     */
    private Date updateTime;

    /**
     * 预计还款月 yyyy-MM
     */
    private String repayMonth;

    /**
     * 实际还款月
     */
    private String realRepayMonth;


    private static final long serialVersionUID = 1L;

    public String getRepayMonth() {
        return repayMonth;
    }

    public void setRepayMonth(String repayMonth) {
        this.repayMonth = repayMonth;
    }

    public String getRealRepayMonth() {
        return realRepayMonth;
    }

    public void setRealRepayMonth(String realRepayMonth) {
        this.realRepayMonth = realRepayMonth;
    }

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
     * @return 借款人ID
     */
    public Integer getBorrowerId() {
        return borrowerId;
    }

    /**
     * @param borrowerId  借款人ID
     */
    public void setBorrowerId(Integer borrowerId) {
        this.borrowerId = borrowerId;
    }

    /**
     * @return 标的ID
     */
    public Integer getProjectId() {
        return projectId;
    }

    /**
     * @param projectId  标的ID
     */
    public void setProjectId(Integer projectId) {
        this.projectId = projectId;
    }

    /**
     * @return 是否还款 0:未还款 1:已还款 2:部分还款
     */
    public Boolean getStatus() {
        return status;
    }

    /**
     * @param status  是否还款 0:未还款 1:已还款 2:部分还款
     */
    public void setStatus(Boolean status) {
        this.status = status;
    }


    /**
     * @return 第几期还款
     */
    public Byte getPeriod() {
        return period;
    }

    /**
     * @param period  第几期还款
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
     * @return 预计还款本金
     */
    public BigDecimal getCapital() {
        return capital;
    }

    /**
     * @param capital  预计还款本金
     */
    public void setCapital(BigDecimal capital) {
        this.capital = capital;
    }

    /**
     * @return 基础利息
     */
    public BigDecimal getInterest() {
        return interest;
    }

    /**
     * @param interest  基础利息
     */
    public void setInterest(BigDecimal interest) {
        this.interest = interest;
    }

    /**
     * @return 平台加息利息
     */
    public BigDecimal getPlatformInterest() {
        return platformInterest;
    }

    /**
     * @param platformInterest  平台加息利息
     */
    public void setPlatformInterest(BigDecimal platformInterest) {
        this.platformInterest = platformInterest;
    }

    /**
     * @return 加息券利息
     */
    public BigDecimal getCouponInterest() {
        return couponInterest;
    }

    /**
     * @param couponInterest  加息券利息
     */
    public void setCouponInterest(BigDecimal couponInterest) {
        this.couponInterest = couponInterest;
    }

    /**
     * @return 预计还款时间(精确到天)
     */
    public Date getRepayTime() {
        return repayTime;
    }

    /**
     * @param repayTime  预计还款时间(精确到天)
     */
    public void setRepayTime(Date repayTime) {
        this.repayTime = repayTime;
    }

    /**
     * @return 实际还款时间(精确到秒)
     */
    public Date getRealRepayTime() {
        return realRepayTime;
    }

    /**
     * @param realRepayTime  实际还款时间(精确到秒)
     */
    public void setRealRepayTime(Date realRepayTime) {
        this.realRepayTime = realRepayTime;
    }

    /**
     * @return 备注信息
     */
    public String getRemark() {
        return remark;
    }

    /**
     * @param remark  备注信息
     */
    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
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
     * @return 更新时间
     */
    public Date getUpdateTime() {
        return updateTime;
    }

    /**
     * @param updateTime  更新时间
     */
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }


}